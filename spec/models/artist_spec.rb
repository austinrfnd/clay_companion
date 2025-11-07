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
        create_list(:studio_image, 2, artist: artist)
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
end
