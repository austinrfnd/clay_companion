# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PressMention, type: :model do
  ##
  # Test Overview
  # This spec tests the PressMention model which represents media coverage and press articles.
  # It validates associations, required fields, length constraints, URL format validation,
  # and scopes for ordering.
  #
  # Coverage areas:
  # - Associations (belongs_to artist)
  # - Validations (presence, length, URL format)
  # - Default values (display_order)
  # - Scopes (ordered, recent)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
  end

  describe 'validations' do
    subject { build(:press_mention) }

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(200) }

      it 'accepts title at maximum length' do
        mention = build(:press_mention, title: 'A' * 200)
        expect(mention).to be_valid
      end

      it 'rejects title exceeding 200 characters' do
        mention = build(:press_mention, title: 'A' * 201)
        expect(mention).not_to be_valid
        expect(mention.errors[:title]).to be_present
      end
    end

    describe 'publication' do
      it { is_expected.to validate_presence_of(:publication) }
      it { is_expected.to validate_length_of(:publication).is_at_most(200) }

      it 'accepts publication at maximum length' do
        mention = build(:press_mention, publication: 'A' * 200)
        expect(mention).to be_valid
      end

      it 'rejects publication exceeding 200 characters' do
        mention = build(:press_mention, publication: 'A' * 201)
        expect(mention).not_to be_valid
        expect(mention.errors[:publication]).to be_present
      end

      it 'accepts various publication names' do
        valid_publications = [
          'Ceramics Monthly',
          'The New York Times',
          'Art in America',
          'Portland Monthly Magazine'
        ]

        valid_publications.each do |publication|
          mention = build(:press_mention, publication: publication)
          expect(mention).to be_valid, "Expected '#{publication}' to be valid"
        end
      end
    end

    describe 'author' do
      it { is_expected.to validate_length_of(:author).is_at_most(100) }
      it { is_expected.to allow_value(nil).for(:author) }

      it 'accepts author at maximum length' do
        mention = build(:press_mention, author: 'A' * 100)
        expect(mention).to be_valid
      end

      it 'rejects author exceeding 100 characters' do
        mention = build(:press_mention, author: 'A' * 101)
        expect(mention).not_to be_valid
        expect(mention.errors[:author]).to be_present
      end
    end

    describe 'excerpt' do
      it { is_expected.to validate_length_of(:excerpt).is_at_most(1000) }
      it { is_expected.to allow_value(nil).for(:excerpt) }

      it 'accepts excerpt at maximum length' do
        mention = build(:press_mention, excerpt: 'A' * 1000)
        expect(mention).to be_valid
      end

      it 'rejects excerpt exceeding 1000 characters' do
        mention = build(:press_mention, excerpt: 'A' * 1001)
        expect(mention).not_to be_valid
        expect(mention.errors[:excerpt]).to be_present
      end
    end

    describe 'url' do
      it { is_expected.to allow_value(nil).for(:url) }

      context 'format validation' do
        it 'accepts valid URL formats' do
          valid_urls = [
            'https://example.com/article',
            'https://www.example.com/press/article-123',
            'http://example.com/path/to/article',
            'https://subdomain.example.co.uk/article?id=123',
            'https://example.com/path-with-dashes_and_underscores'
          ]

          valid_urls.each do |url|
            mention = build(:press_mention, url: url)
            expect(mention).to be_valid, "Expected '#{url}' to be valid"
          end
        end

        it 'rejects invalid URL formats' do
          invalid_urls = [
            'not a url',
            'ftp://example.com',
            'example.com',
            'www.example.com',
            'https:/example.com',
            'https://example',
            'javascript:alert(1)'
          ]

          invalid_urls.each do |url|
            mention = build(:press_mention, url: url)
            expect(mention).not_to be_valid, "Expected '#{url}' to be invalid"
            expect(mention.errors[:url]).to be_present
          end
        end
      end
    end
  end

  describe 'default values' do
    it 'sets display_order to 0 by default' do
      mention = PressMention.new
      expect(mention.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.ordered' do
      it 'returns press_mentions ordered by display_order ascending' do
        mention3 = create(:press_mention, artist: artist, display_order: 2)
        mention1 = create(:press_mention, artist: artist, display_order: 0)
        mention2 = create(:press_mention, artist: artist, display_order: 1)

        expect(PressMention.ordered).to eq([mention1, mention2, mention3])
      end

      it 'handles same display_order values' do
        mention1 = create(:press_mention, artist: artist, display_order: 0)
        mention2 = create(:press_mention, artist: artist, display_order: 0)

        expect(PressMention.ordered.count).to eq(2)
      end
    end

    describe '.recent' do
      it 'returns press_mentions ordered by published_date descending' do
        old = create(:press_mention, :old, artist: artist)
        recent = create(:press_mention, :recent, artist: artist)
        medium = create(:press_mention, artist: artist,
                       published_date: Date.today - 30.days)

        expect(PressMention.recent).to eq([recent, medium, old])
      end

      it 'handles press_mentions with nil published_date' do
        with_date = create(:press_mention, artist: artist,
                          published_date: Date.today - 10.days)
        without_date = create(:press_mention, artist: artist, published_date: nil)

        # Nil dates should appear last or be excluded depending on implementation
        recent_mentions = PressMention.recent
        expect(recent_mentions).to include(with_date)
        # Check if nil dates are included or excluded
        if recent_mentions.include?(without_date)
          expect(recent_mentions.last).to eq(without_date)
        end
      end

      it 'handles same published_date values' do
        mention1 = create(:press_mention, artist: artist,
                         published_date: Date.today - 10.days)
        mention2 = create(:press_mention, artist: artist,
                         published_date: Date.today - 10.days)

        expect(PressMention.recent.count).to eq(2)
      end
    end

    describe 'scope chaining' do
      it 'allows chaining recent with artist scope' do
        artist1 = create(:artist)
        artist2 = create(:artist)

        recent1 = create(:press_mention, :recent, artist: artist1)
        old1 = create(:press_mention, :old, artist: artist1)
        _recent2 = create(:press_mention, :recent, artist: artist2)

        expect(artist1.press_mentions.recent).to eq([recent1, old1])
      end
    end
  end

  describe 'display_order functionality' do
    let(:artist) { create(:artist) }

    it 'allows custom display_order values' do
      mention1 = create(:press_mention, artist: artist, display_order: 5)
      mention2 = create(:press_mention, artist: artist, display_order: 10)

      expect(mention1.display_order).to eq(5)
      expect(mention2.display_order).to eq(10)
    end

    it 'maintains display_order on update' do
      mention = create(:press_mention, artist: artist, display_order: 3)
      mention.update!(display_order: 7)

      expect(mention.reload.display_order).to eq(7)
    end

    it 'allows multiple mentions with same display_order' do
      mention1 = create(:press_mention, artist: artist, display_order: 1)
      mention2 = create(:press_mention, artist: artist, display_order: 1)

      expect(mention1.display_order).to eq(mention2.display_order)
    end
  end

  describe 'factory' do
    it 'creates valid press_mention with default factory' do
      mention = build(:press_mention)
      expect(mention).to be_valid
    end

    it 'creates recent press_mention' do
      mention = build(:press_mention, :recent)
      expect(mention).to be_valid
      expect(mention.published_date).to be > Date.today - 10.days
    end

    it 'creates old press_mention' do
      mention = build(:press_mention, :old)
      expect(mention).to be_valid
      expect(mention.published_date).to be < Date.today - 300.days
    end

    it 'creates minimal press_mention' do
      mention = build(:press_mention, :minimal)
      expect(mention).to be_valid
      expect(mention.author).to be_nil
      expect(mention.url).to be_nil
      expect(mention.excerpt).to be_nil
      expect(mention.published_date).to be_nil
    end

    it 'creates press_mention with long excerpt' do
      mention = build(:press_mention, :with_long_excerpt)
      expect(mention).to be_valid
      expect(mention.excerpt.length).to eq(1000)
    end
  end
end
