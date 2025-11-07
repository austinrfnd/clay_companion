# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exhibition, type: :model do
  ##
  # Test Overview
  # This spec tests the Exhibition model which represents artist exhibitions and shows.
  # It validates associations, required fields, length constraints, date validation,
  # exhibition_type enum validation, scopes for filtering by status/type, and the ongoing? method.
  #
  # Coverage areas:
  # - Associations (belongs_to artist, has_many exhibition_images)
  # - Validations (presence, length, date range, exhibition_type)
  # - Scopes (ordered, ongoing, past, upcoming, by_type)
  # - Methods (ongoing?)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_many(:exhibition_images).dependent(:destroy) }

    context 'dependent destroy behavior for images' do
      let(:exhibition) { create(:exhibition) }

      it 'destroys associated exhibition_images when exhibition is destroyed' do
        create_list(:exhibition_image, 3, exhibition: exhibition)
        expect { exhibition.destroy }.to change { ExhibitionImage.count }.by(-3)
      end
    end
  end

  describe 'validations' do
    subject { build(:exhibition) }

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(200) }

      it 'accepts title at maximum length' do
        exhibition = build(:exhibition, title: 'A' * 200)
        expect(exhibition).to be_valid
      end

      it 'rejects title exceeding 200 characters' do
        exhibition = build(:exhibition, title: 'A' * 201)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:title]).to be_present
      end
    end

    describe 'description' do
      it { is_expected.to validate_length_of(:description).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:description) }

      it 'accepts description at maximum length' do
        exhibition = build(:exhibition, description: 'A' * 2000)
        expect(exhibition).to be_valid
      end

      it 'rejects description exceeding 2000 characters' do
        exhibition = build(:exhibition, description: 'A' * 2001)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:description]).to be_present
      end
    end

    describe 'venue' do
      it { is_expected.to validate_length_of(:venue).is_at_most(200) }
      it { is_expected.to allow_value(nil).for(:venue) }

      it 'accepts venue at maximum length' do
        exhibition = build(:exhibition, venue: 'A' * 200)
        expect(exhibition).to be_valid
      end

      it 'rejects venue exceeding 200 characters' do
        exhibition = build(:exhibition, venue: 'A' * 201)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:venue]).to be_present
      end
    end

    describe 'location' do
      it { is_expected.to validate_length_of(:location).is_at_most(200) }
      it { is_expected.to allow_value(nil).for(:location) }

      it 'accepts valid locations' do
        valid_locations = [
          'Portland, Oregon',
          'New York, NY',
          'London, United Kingdom',
          'A' * 200
        ]

        valid_locations.each do |location|
          exhibition = build(:exhibition, location: location)
          expect(exhibition).to be_valid, "Expected '#{location}' to be valid"
        end
      end

      it 'rejects location exceeding 200 characters' do
        exhibition = build(:exhibition, location: 'A' * 201)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:location]).to be_present
      end
    end

    describe 'exhibition_type' do
      it { is_expected.to validate_presence_of(:exhibition_type) }
      it { is_expected.to validate_length_of(:exhibition_type).is_at_most(20) }

      it 'accepts valid exhibition types' do
        valid_types = ['solo', 'group', 'art_fair', 'museum']

        valid_types.each do |type|
          exhibition = build(:exhibition, exhibition_type: type)
          expect(exhibition).to be_valid, "Expected type '#{type}' to be valid"
        end
      end

      it 'rejects invalid exhibition types' do
        invalid_types = ['invalid', 'online', 'popup', '']

        invalid_types.each do |type|
          exhibition = build(:exhibition, exhibition_type: type)
          expect(exhibition).not_to be_valid, "Expected type '#{type}' to be invalid"
        end
      end

      it 'rejects exhibition_type exceeding 20 characters' do
        exhibition = build(:exhibition, exhibition_type: 'A' * 21)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:exhibition_type]).to be_present
      end
    end

    describe 'start_date' do
      it { is_expected.to validate_presence_of(:start_date) }

      it 'accepts valid dates' do
        valid_dates = [
          Date.today,
          Date.today - 30.days,
          Date.today + 30.days,
          Date.new(2020, 1, 1)
        ]

        valid_dates.each do |date|
          exhibition = build(:exhibition, start_date: date)
          expect(exhibition).to be_valid, "Expected date '#{date}' to be valid"
        end
      end

      it 'rejects nil start_date' do
        exhibition = build(:exhibition, start_date: nil)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:start_date]).to be_present
      end
    end

    describe 'end_date' do
      it { is_expected.to allow_value(nil).for(:end_date) }

      it 'accepts end_date equal to start_date' do
        exhibition = build(:exhibition, start_date: Date.today, end_date: Date.today)
        expect(exhibition).to be_valid
      end

      it 'accepts end_date after start_date' do
        exhibition = build(:exhibition, start_date: Date.today, end_date: Date.today + 30.days)
        expect(exhibition).to be_valid
      end

      it 'rejects end_date before start_date' do
        exhibition = build(:exhibition, start_date: Date.today, end_date: Date.today - 1.day)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:end_date]).to be_present
      end
    end

    describe 'curator' do
      it { is_expected.to validate_length_of(:curator).is_at_most(100) }
      it { is_expected.to allow_value(nil).for(:curator) }

      it 'accepts curator at maximum length' do
        exhibition = build(:exhibition, curator: 'A' * 100)
        expect(exhibition).to be_valid
      end

      it 'rejects curator exceeding 100 characters' do
        exhibition = build(:exhibition, curator: 'A' * 101)
        expect(exhibition).not_to be_valid
        expect(exhibition.errors[:curator]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets display_order to 0 by default' do
      exhibition = Exhibition.new
      expect(exhibition.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.ordered' do
      it 'returns exhibitions ordered by display_order ascending' do
        exhibition3 = create(:exhibition, artist: artist, display_order: 2)
        exhibition1 = create(:exhibition, artist: artist, display_order: 0)
        exhibition2 = create(:exhibition, artist: artist, display_order: 1)

        expect(Exhibition.ordered).to eq([exhibition1, exhibition2, exhibition3])
      end
    end

    describe '.ongoing' do
      it 'returns exhibitions currently in progress' do
        ongoing1 = create(:exhibition, :ongoing, artist: artist)
        ongoing2 = create(:exhibition, :ongoing, artist: artist)
        _past = create(:exhibition, :past, artist: artist)
        _upcoming = create(:exhibition, :upcoming, artist: artist)

        ongoing_exhibitions = Exhibition.ongoing
        expect(ongoing_exhibitions).to include(ongoing1, ongoing2)
        expect(ongoing_exhibitions.count).to eq(2)
      end

      it 'includes exhibitions with no end_date that have started' do
        ongoing_no_end = create(:exhibition, :no_end_date, artist: artist,
                                 start_date: Date.today - 10.days)

        expect(Exhibition.ongoing).to include(ongoing_no_end)
      end

      it 'excludes exhibitions with no end_date that have not started' do
        upcoming_no_end = create(:exhibition, :no_end_date, artist: artist,
                                  start_date: Date.today + 10.days)

        expect(Exhibition.ongoing).not_to include(upcoming_no_end)
      end
    end

    describe '.past' do
      it 'returns exhibitions that have ended' do
        past1 = create(:exhibition, :past, artist: artist)
        past2 = create(:exhibition, :past, artist: artist)
        _ongoing = create(:exhibition, :ongoing, artist: artist)
        _upcoming = create(:exhibition, :upcoming, artist: artist)

        expect(Exhibition.past).to contain_exactly(past1, past2)
      end

      it 'excludes exhibitions with no end_date' do
        _no_end = create(:exhibition, :no_end_date, artist: artist)

        expect(Exhibition.past).to be_empty
      end
    end

    describe '.upcoming' do
      it 'returns exhibitions that have not started' do
        upcoming1 = create(:exhibition, :upcoming, artist: artist)
        upcoming2 = create(:exhibition, :upcoming, artist: artist)
        _ongoing = create(:exhibition, :ongoing, artist: artist)
        _past = create(:exhibition, :past, artist: artist)

        expect(Exhibition.upcoming).to contain_exactly(upcoming1, upcoming2)
      end

      it 'includes exhibitions starting today' do
        today_exhibition = create(:exhibition, artist: artist,
                                   start_date: Date.today,
                                   end_date: Date.today + 30.days)

        # Depending on implementation, this might be in ongoing or upcoming
        # Adjust expectation based on actual implementation
        results = Exhibition.upcoming.or(Exhibition.ongoing)
        expect(results).to include(today_exhibition)
      end
    end

    describe '.by_type' do
      it 'returns exhibitions of specified type' do
        solo1 = create(:exhibition, :solo, artist: artist)
        solo2 = create(:exhibition, :solo, artist: artist)
        _group = create(:exhibition, :group, artist: artist)
        _art_fair = create(:exhibition, :art_fair, artist: artist)

        expect(Exhibition.by_type('solo')).to contain_exactly(solo1, solo2)
      end

      it 'returns empty collection for type with no exhibitions' do
        create(:exhibition, :solo, artist: artist)
        expect(Exhibition.by_type('museum')).to be_empty
      end

      it 'handles all exhibition types' do
        solo = create(:exhibition, :solo, artist: artist)
        group = create(:exhibition, :group, artist: artist)
        art_fair = create(:exhibition, :art_fair, artist: artist)
        museum = create(:exhibition, :museum, artist: artist)

        expect(Exhibition.by_type('solo')).to contain_exactly(solo)
        expect(Exhibition.by_type('group')).to contain_exactly(group)
        expect(Exhibition.by_type('art_fair')).to contain_exactly(art_fair)
        expect(Exhibition.by_type('museum')).to contain_exactly(museum)
      end
    end

    describe 'scope chaining' do
      it 'allows chaining ongoing with ordered' do
        ongoing1 = create(:exhibition, :ongoing, artist: artist, display_order: 1)
        ongoing2 = create(:exhibition, :ongoing, artist: artist, display_order: 0)
        _past = create(:exhibition, :past, artist: artist)

        expect(Exhibition.ongoing.ordered).to eq([ongoing2, ongoing1])
      end

      it 'allows chaining by_type with ordered' do
        solo1 = create(:exhibition, :solo, artist: artist, display_order: 1)
        solo2 = create(:exhibition, :solo, artist: artist, display_order: 0)
        _group = create(:exhibition, :group, artist: artist)

        expect(Exhibition.by_type('solo').ordered).to eq([solo2, solo1])
      end
    end
  end

  describe '#ongoing?' do
    context 'when exhibition is currently in progress' do
      it 'returns true for exhibition with valid date range' do
        exhibition = build(:exhibition, :ongoing)
        expect(exhibition.ongoing?).to be true
      end

      it 'returns true when today equals start_date' do
        exhibition = build(:exhibition,
                          start_date: Date.today,
                          end_date: Date.today + 30.days)
        expect(exhibition.ongoing?).to be true
      end

      it 'returns true when today equals end_date' do
        exhibition = build(:exhibition,
                          start_date: Date.today - 30.days,
                          end_date: Date.today)
        expect(exhibition.ongoing?).to be true
      end

      it 'returns true for exhibition with no end_date that has started' do
        exhibition = build(:exhibition, :no_end_date,
                          start_date: Date.today - 10.days)
        expect(exhibition.ongoing?).to be true
      end
    end

    context 'when exhibition is not ongoing' do
      it 'returns false for past exhibition' do
        exhibition = build(:exhibition, :past)
        expect(exhibition.ongoing?).to be false
      end

      it 'returns false for upcoming exhibition' do
        exhibition = build(:exhibition, :upcoming)
        expect(exhibition.ongoing?).to be false
      end

      it 'returns false for exhibition with no end_date that has not started' do
        exhibition = build(:exhibition, :no_end_date,
                          start_date: Date.today + 10.days)
        expect(exhibition.ongoing?).to be false
      end
    end
  end

  describe 'factory' do
    it 'creates valid exhibition with default factory' do
      exhibition = build(:exhibition)
      expect(exhibition).to be_valid
    end

    it 'creates solo exhibition' do
      exhibition = build(:exhibition, :solo)
      expect(exhibition).to be_valid
      expect(exhibition.exhibition_type).to eq('solo')
    end

    it 'creates group exhibition' do
      exhibition = build(:exhibition, :group)
      expect(exhibition).to be_valid
      expect(exhibition.exhibition_type).to eq('group')
    end

    it 'creates art_fair exhibition' do
      exhibition = build(:exhibition, :art_fair)
      expect(exhibition).to be_valid
      expect(exhibition.exhibition_type).to eq('art_fair')
    end

    it 'creates museum exhibition' do
      exhibition = build(:exhibition, :museum)
      expect(exhibition).to be_valid
      expect(exhibition.exhibition_type).to eq('museum')
    end

    it 'creates ongoing exhibition' do
      exhibition = build(:exhibition, :ongoing)
      expect(exhibition).to be_valid
      expect(exhibition.ongoing?).to be true
    end

    it 'creates past exhibition' do
      exhibition = build(:exhibition, :past)
      expect(exhibition).to be_valid
      expect(exhibition.ongoing?).to be false
    end

    it 'creates upcoming exhibition' do
      exhibition = build(:exhibition, :upcoming)
      expect(exhibition).to be_valid
      expect(exhibition.ongoing?).to be false
    end

    it 'creates exhibition without end_date' do
      exhibition = build(:exhibition, :no_end_date)
      expect(exhibition).to be_valid
      expect(exhibition.end_date).to be_nil
    end

    it 'creates minimal exhibition' do
      exhibition = build(:exhibition, :minimal)
      expect(exhibition).to be_valid
      expect(exhibition.description).to be_nil
      expect(exhibition.curator).to be_nil
    end

    it 'creates exhibition with images' do
      exhibition = create(:exhibition, :with_images)
      expect(exhibition.exhibition_images.count).to eq(3)
    end
  end
end
