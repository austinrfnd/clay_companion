# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Series, type: :model do
  ##
  # Test Overview
  # This spec tests the Series model which represents collections of related artworks.
  # It validates associations, required fields, length constraints, boolean defaults,
  # scopes for filtering, and display ordering.
  #
  # Coverage areas:
  # - Associations (belongs_to artist, has_many artwork_groups/artworks)
  # - Validations (presence, length)
  # - Default values (is_ongoing)
  # - Scopes (ordered, ongoing, completed)
  # - Display order functionality
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to have_many(:artwork_groups).dependent(:destroy) }
    it { is_expected.to have_many(:artworks).through(:artwork_groups) }

    context 'dependent destroy behavior' do
      let(:series) { create(:series) }

      it 'destroys associated artwork_groups when series is destroyed' do
        create_list(:artwork_group, 2, series: series, artist: series.artist)
        expect { series.destroy }.to change { ArtworkGroup.count }.by(-2)
      end

      it 'maintains artworks through groups relationship' do
        group = create(:artwork_group, series: series, artist: series.artist)
        create_list(:artwork, 3, artwork_group: group, artist: series.artist, series: series)
        expect(series.artworks.count).to eq(3)
      end
    end
  end

  describe 'validations' do
    subject { build(:series) }

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(200) }

      it 'accepts title at maximum length' do
        series = build(:series, title: 'A' * 200)
        expect(series).to be_valid
      end

      it 'rejects title exceeding 200 characters' do
        series = build(:series, title: 'A' * 201)
        expect(series).not_to be_valid
        expect(series.errors[:title]).to be_present
      end
    end

    describe 'description' do
      it { is_expected.to validate_length_of(:description).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:description) }

      it 'accepts description at maximum length' do
        series = build(:series, description: 'A' * 2000)
        expect(series).to be_valid
      end

      it 'rejects description exceeding 2000 characters' do
        series = build(:series, description: 'A' * 2001)
        expect(series).not_to be_valid
        expect(series.errors[:description]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets is_ongoing to true by default' do
      series = Series.new
      expect(series.is_ongoing).to be true
    end

    it 'sets display_order to 0 by default' do
      series = Series.new
      expect(series.display_order).to eq(0)
    end

    it 'allows is_ongoing to be set to false' do
      series = create(:series, :completed)
      expect(series.is_ongoing).to be false
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.ordered' do
      it 'returns series ordered by display_order ascending' do
        series3 = create(:series, artist: artist, display_order: 2)
        series1 = create(:series, artist: artist, display_order: 0)
        series2 = create(:series, artist: artist, display_order: 1)

        expect(Series.ordered).to eq([series1, series2, series3])
      end

      it 'handles same display_order values' do
        series1 = create(:series, artist: artist, display_order: 0)
        series2 = create(:series, artist: artist, display_order: 0)

        expect(Series.ordered.count).to eq(2)
      end
    end

    describe '.ongoing' do
      it 'returns only ongoing series' do
        ongoing1 = create(:series, artist: artist, is_ongoing: true)
        ongoing2 = create(:series, artist: artist, is_ongoing: true)
        _completed = create(:series, :completed, artist: artist)

        expect(Series.ongoing).to contain_exactly(ongoing1, ongoing2)
      end

      it 'returns empty collection when no ongoing series exist' do
        create(:series, :completed, artist: artist)
        expect(Series.ongoing).to be_empty
      end
    end

    describe '.completed' do
      it 'returns only completed series' do
        completed1 = create(:series, :completed, artist: artist)
        completed2 = create(:series, :completed, artist: artist)
        _ongoing = create(:series, artist: artist, is_ongoing: true)

        expect(Series.completed).to contain_exactly(completed1, completed2)
      end

      it 'returns empty collection when no completed series exist' do
        create(:series, artist: artist, is_ongoing: true)
        expect(Series.completed).to be_empty
      end
    end

    describe 'scope chaining' do
      it 'allows chaining ordered with ongoing' do
        ongoing1 = create(:series, artist: artist, is_ongoing: true, display_order: 1)
        ongoing2 = create(:series, artist: artist, is_ongoing: true, display_order: 0)
        _completed = create(:series, :completed, artist: artist, display_order: 0)

        expect(Series.ongoing.ordered).to eq([ongoing2, ongoing1])
      end

      it 'allows chaining ordered with completed' do
        completed1 = create(:series, :completed, artist: artist, display_order: 1)
        completed2 = create(:series, :completed, artist: artist, display_order: 0)
        _ongoing = create(:series, artist: artist)

        expect(Series.completed.ordered).to eq([completed2, completed1])
      end
    end
  end

  describe 'display_order functionality' do
    let(:artist) { create(:artist) }

    it 'allows custom display_order values' do
      series1 = create(:series, artist: artist, display_order: 5)
      series2 = create(:series, artist: artist, display_order: 10)

      expect(series1.display_order).to eq(5)
      expect(series2.display_order).to eq(10)
    end

    it 'maintains display_order on update' do
      series = create(:series, artist: artist, display_order: 3)
      series.update!(display_order: 7)

      expect(series.reload.display_order).to eq(7)
    end

    it 'allows multiple series with same display_order' do
      series1 = create(:series, artist: artist, display_order: 1)
      series2 = create(:series, artist: artist, display_order: 1)

      expect(series1.display_order).to eq(series2.display_order)
    end
  end

  describe 'factory' do
    it 'creates valid series with default factory' do
      series = build(:series)
      expect(series).to be_valid
    end

    it 'creates completed series' do
      series = build(:series, :completed)
      expect(series).to be_valid
      expect(series.is_ongoing).to be false
      expect(series.year_ended).to be_present
    end

    it 'creates minimal series' do
      series = build(:series, :minimal)
      expect(series).to be_valid
      expect(series.description).to be_nil
      expect(series.year_started).to be_nil
      expect(series.year_ended).to be_nil
    end

    it 'creates series with groups' do
      series = create(:series, :with_groups)
      expect(series.artwork_groups.count).to eq(2)
    end

    it 'creates series with artworks through groups' do
      series = create(:series, :with_artworks)
      expect(series.artworks.count).to eq(3)
    end
  end
end
