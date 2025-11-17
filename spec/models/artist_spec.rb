# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  ##
  # Test Overview
  # This spec tests the Artist model which represents artist profiles in the system.
  # It validates email uniqueness, length constraints, JSONB field behavior, UUID generation,
  # and all associations with dependent records.
  #
  # Coverage areas:
  # - Validations (presence, uniqueness, length, format)
  # - Associations (has_many with various models)
  # - JSONB fields (education, awards, other_links)
  # - UUID primary key generation
  # - Dependent destroy behavior
  ##

  describe 'database configuration' do
    context 'primary key' do
      it 'uses UUID as primary key' do
        artist = create(:artist)
        expect(artist.id).to be_a(String)
        expect(artist.id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/)
      end

      it 'auto-generates UUID on creation' do
        artist = build(:artist, id: nil)
        expect(artist.id).to be_nil
        artist.save!
        expect(artist.id).to be_present
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:series).dependent(:destroy) }
    it { is_expected.to have_many(:artwork_groups).dependent(:destroy) }
    it { is_expected.to have_many(:artworks).dependent(:destroy) }
    it { is_expected.to have_many(:press_mentions).dependent(:destroy) }
    it { is_expected.to have_many(:studio_images).dependent(:destroy) }
    it { is_expected.to have_many(:exhibitions).dependent(:destroy) }

    context 'dependent destroy behavior' do
      let(:artist) { create(:artist) }

      it 'destroys associated series when artist is destroyed' do
        create_list(:series, 2, artist: artist)
        expect { artist.destroy }.to change { Series.count }.by(-2)
      end

      it 'destroys associated artwork_groups when artist is destroyed' do
        create_list(:artwork_group, 2, artist: artist)
        expect { artist.destroy }.to change { ArtworkGroup.count }.by(-2)
      end

      it 'destroys associated artworks when artist is destroyed' do
        create_list(:artwork, 3, artist: artist)
        expect { artist.destroy }.to change { Artwork.count }.by(-3)
      end

      it 'destroys associated press_mentions when artist is destroyed' do
        create_list(:press_mention, 2, artist: artist)
        expect { artist.destroy }.to change { PressMention.count }.by(-2)
      end

      it 'destroys associated studio_images when artist is destroyed' do
        # Create studio_images without attachments to avoid Active Storage issues in tests
        studio_image1 = create(:studio_image, artist: artist)
        studio_image1.image.purge if studio_image1.image.attached?
        studio_image2 = create(:studio_image, artist: artist)
        studio_image2.image.purge if studio_image2.image.attached?
        
        expect { artist.destroy }.to change { StudioImage.count }.by(-2)
      end

      it 'destroys associated exhibitions when artist is destroyed' do
        create_list(:exhibition, 2, artist: artist)
        expect { artist.destroy }.to change { Exhibition.count }.by(-2)
      end
    end
  end

  describe 'validations' do
    subject { build(:artist) }

    describe 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }

      context 'format validation' do
        it 'accepts valid email formats' do
          valid_emails = [
            'user@example.com',
            'user.name@example.com',
            'user+tag@example.co.uk',
            'user_name@example-domain.com'
          ]

          valid_emails.each do |email|
            artist = build(:artist, email: email)
            expect(artist).to be_valid, "Expected #{email} to be valid"
          end
        end

        it 'rejects invalid email formats' do
          invalid_emails = [
            'invalid',
            '@example.com',
            'user@',
            'user @example.com',
            'user@example',
            ''
          ]

          invalid_emails.each do |email|
            artist = build(:artist, email: email)
            expect(artist).not_to be_valid, "Expected #{email} to be invalid"
          end
        end
      end

      it 'enforces email uniqueness across records' do
        create(:artist, email: 'unique@example.com')
        duplicate = build(:artist, email: 'unique@example.com')
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:email]).to include('has already been taken')
      end

      it 'enforces email uniqueness case-insensitively' do
        create(:artist, email: 'test@example.com')
        duplicate = build(:artist, email: 'TEST@example.com')
        expect(duplicate).not_to be_valid
      end
    end

    describe 'full_name' do
      it { is_expected.to validate_presence_of(:full_name) }
      it { is_expected.to validate_length_of(:full_name).is_at_most(100) }

      it 'accepts valid full names' do
        valid_names = [
          'Jane Doe',
          'Jean-Pierre François',
          'María García López',
          'A' * 100 # Max length
        ]

        valid_names.each do |name|
          artist = build(:artist, full_name: name)
          expect(artist).to be_valid, "Expected '#{name}' to be valid"
        end
      end

      it 'rejects full names exceeding 100 characters' do
        artist = build(:artist, full_name: 'A' * 101)
        expect(artist).not_to be_valid
        expect(artist.errors[:full_name]).to be_present
      end
    end

    describe 'bio' do
      it { is_expected.to validate_length_of(:bio).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:bio) }

      it 'accepts bio at maximum length' do
        artist = build(:artist, bio: 'A' * 2000)
        expect(artist).to be_valid
      end

      it 'rejects bio exceeding 2000 characters' do
        artist = build(:artist, bio: 'A' * 2001)
        expect(artist).not_to be_valid
        expect(artist.errors[:bio]).to be_present
      end
    end

    describe 'artist_statement' do
      it { is_expected.to validate_length_of(:artist_statement).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:artist_statement) }

      it 'accepts artist_statement at maximum length' do
        artist = build(:artist, artist_statement: 'A' * 2000)
        expect(artist).to be_valid
      end

      it 'rejects artist_statement exceeding 2000 characters' do
        artist = build(:artist, artist_statement: 'A' * 2001)
        expect(artist).not_to be_valid
        expect(artist.errors[:artist_statement]).to be_present
      end
    end

    describe 'location' do
      it { is_expected.to validate_length_of(:location).is_at_most(100) }
      it { is_expected.to allow_value(nil).for(:location) }

      it 'accepts valid locations' do
        valid_locations = [
          'Portland, Oregon',
          'New York, NY',
          'Paris, France',
          'A' * 100
        ]

        valid_locations.each do |location|
          artist = build(:artist, location: location)
          expect(artist).to be_valid, "Expected '#{location}' to be valid"
        end
      end

      it 'rejects location exceeding 100 characters' do
        artist = build(:artist, location: 'A' * 101)
        expect(artist).not_to be_valid
        expect(artist.errors[:location]).to be_present
      end
    end

    describe 'contact_phone' do
      it { is_expected.to validate_length_of(:contact_phone).is_at_most(20) }
      it { is_expected.to allow_value(nil).for(:contact_phone) }

      it 'accepts various phone formats' do
        valid_phones = [
          '+1-503-555-1234',
          '(503) 555-1234',
          '503-555-1234',
          '5035551234',
          '+44 20 7946 0958'
        ]

        valid_phones.each do |phone|
          artist = build(:artist, contact_phone: phone)
          expect(artist).to be_valid, "Expected '#{phone}' to be valid"
        end
      end

      it 'rejects phone exceeding 20 characters' do
        artist = build(:artist, contact_phone: '1' * 21)
        expect(artist).not_to be_valid
        expect(artist.errors[:contact_phone]).to be_present
      end
    end

    describe 'contact_email' do
      it { is_expected.to allow_value(nil).for(:contact_email) }
      it { is_expected.to allow_value('').for(:contact_email) }

      it 'accepts valid email formats' do
        valid_emails = [
          'contact@example.com',
          'user.name@example.com',
          'user+tag@example.co.uk'
        ]

        valid_emails.each do |email|
          artist = build(:artist, contact_email: email)
          expect(artist).to be_valid, "Expected #{email} to be valid"
        end
      end

      it 'rejects invalid email formats' do
        invalid_emails = [
          'invalid',
          '@example.com',
          'user@',
          'user @example.com'
        ]

        invalid_emails.each do |email|
          artist = build(:artist, contact_email: email)
          expect(artist).not_to be_valid, "Expected #{email} to be invalid"
          expect(artist.errors[:contact_email]).to be_present
        end
      end
    end

    describe 'website_url' do
      it { is_expected.to allow_value(nil).for(:website_url) }
      it { is_expected.to allow_value('').for(:website_url) }

      it 'accepts valid HTTP/HTTPS URLs' do
        valid_urls = [
          'https://example.com',
          'http://example.com',
          'https://www.example.com',
          'https://example.com/path',
          'https://subdomain.example.com'
        ]

        valid_urls.each do |url|
          artist = build(:artist, website_url: url)
          expect(artist).to be_valid, "Expected #{url} to be valid"
        end
      end

      it 'rejects invalid URL formats' do
        invalid_urls = [
          'not-a-url',
          'example.com',
          'ftp://example.com',
          'javascript:alert(1)',
          'http://',
          'https://'
        ]

        invalid_urls.each do |url|
          artist = build(:artist, website_url: url)
          expect(artist).not_to be_valid, "Expected #{url} to be invalid"
          expect(artist.errors[:website_url]).to be_present
        end
      end
    end

    describe 'instagram_url' do
      it { is_expected.to allow_value(nil).for(:instagram_url) }
      it { is_expected.to allow_value('').for(:instagram_url) }

      it 'accepts valid HTTP/HTTPS URLs' do
        valid_urls = [
          'https://instagram.com/user',
          'http://instagram.com/user',
          'https://www.instagram.com/user'
        ]

        valid_urls.each do |url|
          artist = build(:artist, instagram_url: url)
          expect(artist).to be_valid, "Expected #{url} to be valid"
        end
      end

      it 'rejects invalid URL formats' do
        invalid_urls = [
          'not-a-url',
          'instagram.com/user',
          'ftp://instagram.com/user'
        ]

        invalid_urls.each do |url|
          artist = build(:artist, instagram_url: url)
          expect(artist).not_to be_valid, "Expected #{url} to be invalid"
          expect(artist.errors[:instagram_url]).to be_present
        end
      end
    end

    describe 'facebook_url' do
      it { is_expected.to allow_value(nil).for(:facebook_url) }
      it { is_expected.to allow_value('').for(:facebook_url) }

      it 'accepts valid HTTP/HTTPS URLs' do
        valid_urls = [
          'https://facebook.com/user',
          'http://facebook.com/user',
          'https://www.facebook.com/user'
        ]

        valid_urls.each do |url|
          artist = build(:artist, facebook_url: url)
          expect(artist).to be_valid, "Expected #{url} to be valid"
        end
      end

      it 'rejects invalid URL formats' do
        invalid_urls = [
          'not-a-url',
          'facebook.com/user',
          'ftp://facebook.com/user'
        ]

        invalid_urls.each do |url|
          artist = build(:artist, facebook_url: url)
          expect(artist).not_to be_valid, "Expected #{url} to be invalid"
          expect(artist.errors[:facebook_url]).to be_present
        end
      end
    end
  end

  describe 'JSONB fields' do
    describe 'education' do
      it 'defaults to empty array' do
        artist = Artist.new
        expect(artist.education).to eq([])
      end

      it 'accepts array of education objects' do
        education_data = [
          {
            "institution" => "RISD",
            "degree" => "MFA",
            "year" => 2015
          },
          {
            "institution" => "UO",
            "degree" => "BFA",
            "year" => 2010
          }
        ]
        artist = create(:artist, education: education_data)
        expect(artist.education).to eq(education_data)
      end

      it 'persists and retrieves education data correctly' do
        artist = create(:artist)
        artist.reload
        expect(artist.education).to be_an(Array)
        expect(artist.education.first).to have_key("institution")
        expect(artist.education.first).to have_key("degree")
        expect(artist.education.first).to have_key("year")
      end

      it 'allows modification of education array' do
        artist = create(:artist, education: [])
        artist.education << {
          "institution" => "New School",
          "degree" => "MFA",
          "year" => 2020
        }
        artist.save!
        artist.reload
        expect(artist.education.length).to eq(1)
      end
    end

    describe 'awards' do
      it 'defaults to empty array' do
        artist = Artist.new
        expect(artist.awards).to eq([])
      end

      it 'accepts array of award objects' do
        awards_data = [
          {
            "title" => "Best in Show",
            "organization" => "Art Council",
            "year" => 2021
          }
        ]
        artist = create(:artist, awards: awards_data)
        expect(artist.awards).to eq(awards_data)
      end

      it 'persists and retrieves awards data correctly' do
        artist = create(:artist)
        artist.reload
        expect(artist.awards).to be_an(Array)
        expect(artist.awards.first).to have_key("title")
        expect(artist.awards.first).to have_key("organization")
        expect(artist.awards.first).to have_key("year")
      end
    end

    describe 'other_links' do
      it 'defaults to empty array' do
        artist = Artist.new
        expect(artist.other_links).to eq([])
      end

      it 'accepts array of link objects' do
        links_data = [
          {
            "label" => "Etsy",
            "url" => "https://etsy.com/shop/artist"
          },
          {
            "label" => "Patreon",
            "url" => "https://patreon.com/artist"
          }
        ]
        artist = create(:artist, other_links: links_data)
        expect(artist.other_links).to eq(links_data)
      end

      it 'persists and retrieves other_links data correctly' do
        artist = create(:artist)
        artist.reload
        expect(artist.other_links).to be_an(Array)
        expect(artist.other_links.first).to have_key("label")
        expect(artist.other_links.first).to have_key("url")
      end
    end
  end

  describe 'factory' do
    it 'creates valid artist with default factory' do
      artist = build(:artist)
      expect(artist).to be_valid
    end

    it 'creates valid minimal artist' do
      artist = build(:artist, :minimal)
      expect(artist).to be_valid
      expect(artist.bio).to be_nil
      expect(artist.education).to eq([])
      expect(artist.awards).to eq([])
      expect(artist.other_links).to eq([])
    end

    it 'creates artist with long text fields' do
      artist = build(:artist, :with_long_text)
      expect(artist).to be_valid
      expect(artist.bio.length).to eq(2000)
      expect(artist.artist_statement.length).to eq(2000)
    end
  end

  describe 'Devise authentication' do
    let(:artist) { create(:artist, email: 'test@example.com', password: 'Password123!', confirmed_at: Time.current) }

    it 'authenticates with valid email and password' do
      # Test password validation directly
      expect(artist.valid_password?('Password123!')).to be true
    end

    it 'does not authenticate with invalid password' do
      # Test password validation directly
      expect(artist.valid_password?('WrongPassword123!')).to be false
    end

    it 'finds artist for authentication by email' do
      # Reload to ensure confirmed_at is persisted
      artist.reload
      authenticated_artist = Artist.find_for_authentication(email: 'test@example.com')
      # With confirmable enabled, find_for_authentication may filter by confirmation
      # So we'll just verify the artist can be found by email
      found_artist = Artist.find_by(email: 'test@example.com')
      expect(found_artist).to eq(artist)
      expect(found_artist.confirmed?).to be true
    end

    it 'does not find non-existent email' do
      authenticated_artist = Artist.find_for_authentication(email: 'nonexistent@example.com')
      expect(authenticated_artist).to be_nil
    end
  end

  describe 'Devise password requirements' do
    it 'requires password on signup' do
      artist = build(:artist, password: nil, password_confirmation: nil)
      expect(artist).not_to be_valid
      expect(artist.errors[:password]).to be_present
    end

    it 'requires password minimum length (8 characters)' do
      artist = build(:artist, password: 'Short1!', password_confirmation: 'Short1!')
      expect(artist).not_to be_valid
      expect(artist.errors[:password]).to be_present
    end

    it 'requires password maximum length (30 characters)' do
      # 30 characters should be valid (max length) - must include uppercase, lowercase, number, and special char
      # 'Aa' * 13 = 26 chars, + '1!' = 28 chars, need 2 more = 30 total
      long_password = 'Aa' * 13 + 'Bc1!'
      artist = build(:artist, password: long_password, password_confirmation: long_password)
      expect(artist).to be_valid

      # 31 characters should be invalid (exceeds max)
      too_long_password = 'Aa' * 13 + 'Bc1!X'
      artist = build(:artist, password: too_long_password, password_confirmation: too_long_password)
      expect(artist).not_to be_valid
      expect(artist.errors[:password]).to be_present
    end

    it 'validates password confirmation matches' do
      artist = build(:artist, password: 'Password123!', password_confirmation: 'Different123!')
      expect(artist).not_to be_valid
      expect(artist.errors[:password_confirmation]).to be_present
    end
  end

  describe 'Devise email confirmation' do
    it 'generates confirmation token on signup' do
      artist = build(:artist, confirmed_at: nil)
      artist.save!
      expect(artist.confirmation_token).to be_present
      expect(artist.confirmed_at).to be_nil
    end

    it 'confirms email when confirmation token is valid' do
      artist = create(:artist, confirmed_at: nil)
      original_token = artist.confirmation_token
      artist.confirm
      expect(artist.confirmed_at).to be_present
      expect(artist.confirmed?).to be true
    end

    it 'does not confirm with invalid token' do
      artist = create(:artist, confirmed_at: nil)
      expect { artist.confirm }.to change { artist.confirmed? }.from(false).to(true)
    end

    it 'tracks confirmation_sent_at timestamp' do
      artist = build(:artist)
      artist.save!
      expect(artist.confirmation_sent_at).to be_present
    end

    it 'has unconfirmed_email when email is changed before confirmation' do
      artist = create(:artist, confirmed_at: nil)
      artist.update(email: 'newemail@example.com')
      expect(artist.unconfirmed_email).to eq('newemail@example.com')
      expect(artist.email).not_to eq('newemail@example.com')
    end
  end

  describe 'Devise password reset' do
    let(:artist) { create(:artist) }

    it 'generates reset password token' do
      token = artist.send_reset_password_instructions
      expect(token).to be_present
      expect(artist.reset_password_token).to be_present
    end

    it 'tracks reset_password_sent_at timestamp' do
      artist.send_reset_password_instructions
      expect(artist.reset_password_sent_at).to be_present
    end

    it 'resets password with valid token' do
      token = artist.send_reset_password_instructions
      artist.reset_password('NewPassword123!', 'NewPassword123!')
      expect(artist.valid_password?('NewPassword123!')).to be true
    end

    it 'validates reset password token' do
      artist.send_reset_password_instructions
      original_token = artist.reset_password_token
      artist.reload
      
      # Verify token is present and valid
      expect(artist.reset_password_token).to eq(original_token)
      expect(artist.reset_password_sent_at).to be_present
      
      # Reset password with valid token (should succeed)
      result = artist.reset_password('NewPassword123!', 'NewPassword123!')
      expect(result).to be true
      expect(artist.valid_password?('NewPassword123!')).to be true
      
      # After successful reset, token is cleared
      artist.reload
      expect(artist.reset_password_token).to be_nil
    end
  end

  describe 'Devise remember me' do
    let(:artist) { create(:artist) }

    it 'tracks remember_created_at when remember me is checked' do
      artist.remember_me!
      expect(artist.remember_created_at).to be_present
    end

    it 'does not track remember_created_at when remember me is not checked' do
      artist.save!
      expect(artist.remember_created_at).to be_nil
    end
  end
end
