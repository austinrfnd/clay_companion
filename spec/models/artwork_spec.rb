# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artwork, type: :model do
  ##
  # Test Overview
  # This spec tests the Artwork model which represents individual ceramic pieces.
  # It validates associations, required fields, length/format/numericality constraints,
  # price validation, year range validation, scopes for filtering, and the primary_image method.
  #
  # Coverage areas:
  # - Associations (belongs_to artist/artwork_group, has_many artwork_images)
  # - Validations (presence, length, numericality, year range, price)
  # - Default values (boolean flags, display_order)
  # - Scopes (featured, for_sale, sold, ordered)
  # - Methods (primary_image)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
    it { is_expected.to belong_to(:artwork_group).optional }
    it { is_expected.to have_many(:artwork_images).dependent(:destroy) }

    context 'optional artwork_group relationship' do
      it 'allows artwork without artwork_group' do
        artwork = build(:artwork, artwork_group: nil)
        expect(artwork).to be_valid
        expect(artwork.artwork_group).to be_nil
      end

      it 'allows artwork with artwork_group' do
        artwork = build(:artwork, :in_group)
        expect(artwork).to be_valid
        expect(artwork.artwork_group).to be_present
      end
    end

    context 'dependent destroy behavior for images' do
      let(:artwork) { create(:artwork) }

      it 'destroys associated artwork_images when artwork is destroyed' do
        create_list(:artwork_image, 3, artwork: artwork)
        expect { artwork.destroy }.to change { ArtworkImage.count }.by(-3)
      end
    end
  end

  describe 'validations' do
    subject { build(:artwork) }

    describe 'title' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_length_of(:title).is_at_most(200) }

      it 'accepts title at maximum length' do
        artwork = build(:artwork, title: 'A' * 200)
        expect(artwork).to be_valid
      end

      it 'rejects title exceeding 200 characters' do
        artwork = build(:artwork, title: 'A' * 201)
        expect(artwork).not_to be_valid
        expect(artwork.errors[:title]).to be_present
      end
    end

    describe 'year' do
      it { is_expected.to validate_presence_of(:year) }
      it { is_expected.to validate_numericality_of(:year).only_integer }

      context 'year range validation' do
        let(:current_year) { Date.current.year }

        it 'accepts year of 1900' do
          artwork = build(:artwork, year: 1900)
          expect(artwork).to be_valid
        end

        it 'accepts current year' do
          artwork = build(:artwork, year: current_year)
          expect(artwork).to be_valid
        end

        it 'accepts next year (for upcoming works)' do
          artwork = build(:artwork, year: current_year + 1)
          expect(artwork).to be_valid
        end

        it 'rejects year before 1900' do
          artwork = build(:artwork, year: 1899)
          expect(artwork).not_to be_valid
          expect(artwork.errors[:year]).to be_present
        end

        it 'rejects year more than one year in future' do
          artwork = build(:artwork, year: current_year + 2)
          expect(artwork).not_to be_valid
          expect(artwork.errors[:year]).to be_present
        end
      end
    end

    describe 'medium' do
      it { is_expected.to validate_length_of(:medium).is_at_most(200) }
      it { is_expected.to allow_value(nil).for(:medium) }

      it 'accepts medium at maximum length' do
        artwork = build(:artwork, medium: 'A' * 200)
        expect(artwork).to be_valid
      end

      it 'rejects medium exceeding 200 characters' do
        artwork = build(:artwork, medium: 'A' * 201)
        expect(artwork).not_to be_valid
        expect(artwork.errors[:medium]).to be_present
      end
    end

    describe 'dimensions' do
      it { is_expected.to validate_length_of(:dimensions).is_at_most(200) }
      it { is_expected.to allow_value(nil).for(:dimensions) }

      it 'accepts various dimension formats' do
        valid_dimensions = [
          '10 × 8 × 6 in',
          '25.4 × 20.3 × 15.2 cm',
          'H: 10", W: 8", D: 6"',
          'Diameter: 12 in, Height: 8 in'
        ]

        valid_dimensions.each do |dimension|
          artwork = build(:artwork, dimensions: dimension)
          expect(artwork).to be_valid, "Expected '#{dimension}' to be valid"
        end
      end

      it 'rejects dimensions exceeding 200 characters' do
        artwork = build(:artwork, dimensions: 'A' * 201)
        expect(artwork).not_to be_valid
        expect(artwork.errors[:dimensions]).to be_present
      end
    end

    describe 'description' do
      it { is_expected.to validate_length_of(:description).is_at_most(2000) }
      it { is_expected.to allow_value(nil).for(:description) }

      it 'accepts description at maximum length' do
        artwork = build(:artwork, description: 'A' * 2000)
        expect(artwork).to be_valid
      end

      it 'rejects description exceeding 2000 characters' do
        artwork = build(:artwork, description: 'A' * 2001)
        expect(artwork).not_to be_valid
        expect(artwork.errors[:description]).to be_present
      end
    end

    describe 'price' do
      it { is_expected.to allow_value(nil).for(:price) }
      it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

      it 'accepts valid price values' do
        valid_prices = [0, 0.01, 100.00, 9999.99, 999999.99]

        valid_prices.each do |price|
          artwork = build(:artwork, price: price)
          expect(artwork).to be_valid, "Expected price #{price} to be valid"
        end
      end

      it 'rejects negative prices' do
        artwork = build(:artwork, price: -0.01)
        expect(artwork).not_to be_valid
        expect(artwork.errors[:price]).to be_present
      end

      it 'accepts nil price for works not for sale' do
        artwork = build(:artwork, :not_for_sale)
        expect(artwork).to be_valid
        expect(artwork.price).to be_nil
      end
    end
  end

  describe 'default values' do
    it 'sets is_sold to false by default' do
      artwork = Artwork.new
      expect(artwork.is_sold).to be false
    end

    it 'sets is_for_sale to false by default' do
      artwork = Artwork.new
      expect(artwork.is_for_sale).to be false
    end

    it 'sets is_featured to false by default' do
      artwork = Artwork.new
      expect(artwork.is_featured).to be false
    end

    it 'sets display_order to 0 by default' do
      artwork = Artwork.new
      expect(artwork.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.featured' do
      it 'returns only featured artworks' do
        featured1 = create(:artwork, :featured, artist: artist)
        featured2 = create(:artwork, :featured, artist: artist)
        _not_featured = create(:artwork, artist: artist, is_featured: false)

        expect(Artwork.featured).to contain_exactly(featured1, featured2)
      end

      it 'returns empty collection when no featured artworks exist' do
        create(:artwork, artist: artist, is_featured: false)
        expect(Artwork.featured).to be_empty
      end
    end

    describe '.for_sale' do
      it 'returns only artworks for sale' do
        for_sale1 = create(:artwork, :for_sale, artist: artist)
        for_sale2 = create(:artwork, :for_sale, artist: artist)
        _not_for_sale = create(:artwork, :not_for_sale, artist: artist)

        expect(Artwork.for_sale).to contain_exactly(for_sale1, for_sale2)
      end

      it 'excludes sold artworks even if marked for sale' do
        _sold = create(:artwork, :sold, artist: artist)
        for_sale = create(:artwork, :for_sale, artist: artist)

        expect(Artwork.for_sale).to contain_exactly(for_sale)
      end
    end

    describe '.sold' do
      it 'returns only sold artworks' do
        sold1 = create(:artwork, :sold, artist: artist)
        sold2 = create(:artwork, :sold, artist: artist)
        _not_sold = create(:artwork, artist: artist, is_sold: false)

        expect(Artwork.sold).to contain_exactly(sold1, sold2)
      end

      it 'returns empty collection when no sold artworks exist' do
        create(:artwork, artist: artist, is_sold: false)
        expect(Artwork.sold).to be_empty
      end
    end

    describe '.ordered' do
      it 'returns artworks ordered by display_order ascending' do
        artwork3 = create(:artwork, artist: artist, display_order: 2)
        artwork1 = create(:artwork, artist: artist, display_order: 0)
        artwork2 = create(:artwork, artist: artist, display_order: 1)

        expect(Artwork.ordered).to eq([artwork1, artwork2, artwork3])
      end

      it 'handles same display_order values' do
        artwork1 = create(:artwork, artist: artist, display_order: 0)
        artwork2 = create(:artwork, artist: artist, display_order: 0)

        expect(Artwork.ordered.count).to eq(2)
      end
    end

    describe 'scope chaining' do
      it 'allows chaining featured with ordered' do
        featured1 = create(:artwork, :featured, artist: artist, display_order: 1)
        featured2 = create(:artwork, :featured, artist: artist, display_order: 0)
        _not_featured = create(:artwork, artist: artist, display_order: 0)

        expect(Artwork.featured.ordered).to eq([featured2, featured1])
      end

      it 'allows chaining for_sale with ordered' do
        for_sale1 = create(:artwork, :for_sale, artist: artist, display_order: 1)
        for_sale2 = create(:artwork, :for_sale, artist: artist, display_order: 0)
        _not_for_sale = create(:artwork, artist: artist)

        expect(Artwork.for_sale.ordered).to eq([for_sale2, for_sale1])
      end
    end
  end

  describe '#primary_image' do
    let(:artwork) { create(:artwork) }

    context 'when artwork has a primary image' do
      it 'returns the image marked as primary' do
        _other_image = create(:artwork_image, artwork: artwork, is_primary: false)
        primary = create(:artwork_image, :primary, artwork: artwork)

        expect(artwork.primary_image).to eq(primary)
      end
    end

    context 'when artwork has no primary image' do
      it 'returns the first image by display_order' do
        image2 = create(:artwork_image, artwork: artwork, display_order: 1)
        image1 = create(:artwork_image, artwork: artwork, display_order: 0)

        expect(artwork.primary_image).to eq(image1)
      end
    end

    context 'when artwork has no images' do
      it 'returns nil' do
        expect(artwork.primary_image).to be_nil
      end
    end

    context 'edge cases' do
      it 'prefers primary image over display_order' do
        first_by_order = create(:artwork_image, artwork: artwork, display_order: 0, is_primary: false)
        primary = create(:artwork_image, :primary, artwork: artwork, display_order: 5)

        expect(artwork.primary_image).to eq(primary)
      end

      it 'handles multiple images with same display_order' do
        image1 = create(:artwork_image, artwork: artwork, display_order: 0)
        _image2 = create(:artwork_image, artwork: artwork, display_order: 0)

        # Should return first one found (either is acceptable)
        expect(artwork.primary_image).to be_present
        expect([image1.id]).to include(artwork.primary_image.id).or include(_image2.id)
      end
    end
  end

  describe 'factory' do
    it 'creates valid artwork with default factory' do
      artwork = build(:artwork)
      expect(artwork).to be_valid
    end

    it 'creates featured artwork' do
      artwork = build(:artwork, :featured)
      expect(artwork).to be_valid
      expect(artwork.is_featured).to be true
    end

    it 'creates sold artwork' do
      artwork = build(:artwork, :sold)
      expect(artwork).to be_valid
      expect(artwork.is_sold).to be true
      expect(artwork.is_for_sale).to be false
    end

    it 'creates artwork for sale' do
      artwork = build(:artwork, :for_sale)
      expect(artwork).to be_valid
      expect(artwork.is_for_sale).to be true
      expect(artwork.price).to be_present
    end

    it 'creates minimal artwork' do
      artwork = build(:artwork, :minimal)
      expect(artwork).to be_valid
      expect(artwork.medium).to be_nil
      expect(artwork.dimensions).to be_nil
      expect(artwork.description).to be_nil
      expect(artwork.price).to be_nil
    end

    it 'creates artwork with images' do
      artwork = create(:artwork, :with_images)
      expect(artwork.artwork_images.count).to eq(3)
    end

    it 'creates artwork with primary image' do
      artwork = create(:artwork, :with_primary_image)
      expect(artwork.primary_image).to be_present
      expect(artwork.primary_image.is_primary).to be true
    end

    it 'creates artwork in group' do
      artwork = build(:artwork, :in_group)
      expect(artwork).to be_valid
      expect(artwork.artwork_group).to be_present
    end
  end
end
