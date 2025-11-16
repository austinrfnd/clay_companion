# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtworkGroup, type: :model do
  ##
  # Test Overview
  # This spec tests the ArtworkGroup model which represents optional sub-groupings within a series.
  # It validates associations (artist, series, artworks), required fields, optional series relationship,
  # length constraints, and display ordering.
  #
  # Coverage areas:
  # - Associations (belongs_to artist/series, has_many artworks)
  # - Validations (presence, length)
  # - Optional series relationship
  # - Scopes (ordered)
  # - Display order functionality
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to belong_to(:series).optional }
    it { is_expected.to have_many(:artworks).dependent(:nullify) }

    context 'optional series relationship' do
      it 'allows artwork_group without series' do
        group = build(:artwork_group, :without_series)
        expect(group).to be_valid
        expect(group.series).to be_nil
      end

      it 'allows artwork_group with series' do
        group = build(:artwork_group)
        expect(group).to be_valid
        expect(group.series).to be_present
      end
    end

    context 'dependent nullify behavior for artworks' do
      let(:group) { create(:artwork_group) }

      it 'nullifies artwork_group_id on artworks when group is destroyed' do
        artworks = create_list(:artwork, 3, artwork_group: group, artist: group.artist)
        group.destroy

        artworks.each do |artwork|
          expect(artwork.reload.artwork_group_id).to be_nil
        end
      end

      it 'does not delete artworks when group is destroyed' do
        create_list(:artwork, 3, artwork_group: group, artist: group.artist)
        expect { group.destroy }.not_to change { Artwork.count }
      end
    end
  end

  describe 'validations' do
    subject { build(:artwork_group) }

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(200) }

      it 'accepts title at maximum length' do
        group = build(:artwork_group, title: 'A' * 200)
        expect(group).to be_valid
      end

      it 'rejects title exceeding 200 characters' do
        group = build(:artwork_group, title: 'A' * 201)
        expect(group).not_to be_valid
        expect(group.errors[:title]).to be_present
      end
    end

    describe 'description' do
      it { is_expected.to validate_length_of(:description).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:description) }

      it 'accepts description at maximum length' do
        group = build(:artwork_group, description: 'A' * 2000)
        expect(group).to be_valid
      end

      it 'rejects description exceeding 2000 characters' do
        group = build(:artwork_group, description: 'A' * 2001)
        expect(group).not_to be_valid
        expect(group.errors[:description]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets display_order to 0 by default' do
      group = ArtworkGroup.new
      expect(group.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.ordered' do
      it 'returns artwork_groups ordered by display_order ascending' do
        group3 = create(:artwork_group, artist: artist, display_order: 2)
        group1 = create(:artwork_group, artist: artist, display_order: 0)
        group2 = create(:artwork_group, artist: artist, display_order: 1)

        expect(ArtworkGroup.ordered).to eq([group1, group2, group3])
      end

      it 'handles same display_order values' do
        group1 = create(:artwork_group, artist: artist, display_order: 0)
        group2 = create(:artwork_group, artist: artist, display_order: 0)

        expect(ArtworkGroup.ordered.count).to eq(2)
      end
    end
  end

  describe 'display_order functionality' do
    let(:artist) { create(:artist) }

    it 'allows custom display_order values' do
      group1 = create(:artwork_group, artist: artist, display_order: 5)
      group2 = create(:artwork_group, artist: artist, display_order: 10)

      expect(group1.display_order).to eq(5)
      expect(group2.display_order).to eq(10)
    end

    it 'maintains display_order on update' do
      group = create(:artwork_group, artist: artist, display_order: 3)
      group.update!(display_order: 7)

      expect(group.reload.display_order).to eq(7)
    end

    it 'allows multiple groups with same display_order' do
      group1 = create(:artwork_group, artist: artist, display_order: 1)
      group2 = create(:artwork_group, artist: artist, display_order: 1)

      expect(group1.display_order).to eq(group2.display_order)
    end
  end

  describe 'series and artist consistency' do
    it 'allows group to belong to same artist as series' do
      artist = create(:artist)
      series = create(:series, artist: artist)
      group = build(:artwork_group, artist: artist, series: series)

      expect(group).to be_valid
    end

    it 'allows group to belong to different artist than series' do
      # While not ideal, the schema doesn't enforce this constraint
      artist1 = create(:artist)
      artist2 = create(:artist)
      series = create(:series, artist: artist1)
      group = build(:artwork_group, artist: artist2, series: series)

      expect(group).to be_valid
    end
  end

  describe 'factory' do
    it 'creates valid artwork_group with default factory' do
      group = build(:artwork_group)
      expect(group).to be_valid
      expect(group.series).to be_present
    end

    it 'creates artwork_group without series' do
      group = build(:artwork_group, :without_series)
      expect(group).to be_valid
      expect(group.series).to be_nil
    end

    it 'creates minimal artwork_group' do
      group = build(:artwork_group, :minimal)
      expect(group).to be_valid
      expect(group.description).to be_nil
    end

    it 'creates artwork_group with artworks' do
      group = create(:artwork_group, :with_artworks)
      expect(group.artworks.count).to eq(3)
    end

    it 'ensures factory maintains artist consistency' do
      group = create(:artwork_group)
      expect(group.series.artist_id).to eq(group.artist_id)
    end
  end
end
