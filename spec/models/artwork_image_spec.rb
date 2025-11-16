# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtworkImage, type: :model do
  ##
  # Test Overview
  # This spec tests the ArtworkImage model which represents multiple images per artwork.
  # It validates associations, required fields, length constraints, positive integer validation
  # for dimensions, scopes for ordering/filtering, and the set_as_primary method to ensure
  # only one primary image per artwork.
  #
  # Coverage areas:
  # - Associations (belongs_to artwork)
  # - Validations (presence, length, numericality)
  # - Default values (is_primary, display_order)
  # - Scopes (ordered, primary)
  # - Methods (set_as_primary)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artwork) }
  end

  describe 'validations' do
    subject { build(:artwork_image) }

    describe 'image_url' do
      it { is_expected.to validate_presence_of(:image_url) }

      it 'accepts valid image URLs' do
        valid_urls = [
          'https://example.com/image.jpg',
          'https://s3.amazonaws.com/bucket/image.png',
          'https://cdn.example.com/images/artwork_123.webp',
          'http://localhost:3000/test.jpg'
        ]

        valid_urls.each do |url|
          image = build(:artwork_image, image_url: url)
          expect(image).to be_valid, "Expected '#{url}' to be valid"
        end
      end

      it 'rejects empty image_url' do
        image = build(:artwork_image, image_url: '')
        expect(image).not_to be_valid
        expect(image.errors[:image_url]).to be_present
      end
    end

    describe 'alt_text' do
      it { is_expected.to validate_length_of(:alt_text).is_at_most(500) }
      it { is_expected.to allow_value(nil).for(:alt_text) }

      it 'accepts alt_text at maximum length' do
        image = build(:artwork_image, alt_text: 'A' * 500)
        expect(image).to be_valid
      end

      it 'rejects alt_text exceeding 500 characters' do
        image = build(:artwork_image, alt_text: 'A' * 501)
        expect(image).not_to be_valid
        expect(image.errors[:alt_text]).to be_present
      end
    end

    describe 'width' do
      it { is_expected.to allow_value(nil).for(:width) }
      it { is_expected.to validate_numericality_of(:width).only_integer.is_greater_than(0) }

      it 'accepts positive width values' do
        valid_widths = [1, 100, 1920, 4000, 10000]

        valid_widths.each do |width|
          image = build(:artwork_image, width: width)
          expect(image).to be_valid, "Expected width #{width} to be valid"
        end
      end

      it 'rejects zero width' do
        image = build(:artwork_image, width: 0)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects negative width' do
        image = build(:artwork_image, width: -100)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects non-integer width' do
        image = build(:artwork_image, width: 100.5)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end
    end

    describe 'height' do
      it { is_expected.to allow_value(nil).for(:height) }
      it { is_expected.to validate_numericality_of(:height).only_integer.is_greater_than(0) }

      it 'accepts positive height values' do
        valid_heights = [1, 100, 1080, 3000, 10000]

        valid_heights.each do |height|
          image = build(:artwork_image, height: height)
          expect(image).to be_valid, "Expected height #{height} to be valid"
        end
      end

      it 'rejects zero height' do
        image = build(:artwork_image, height: 0)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end

      it 'rejects negative height' do
        image = build(:artwork_image, height: -100)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end
    end

    describe 'file_size' do
      it { is_expected.to allow_value(nil).for(:file_size) }
      it { is_expected.to validate_numericality_of(:file_size).only_integer.is_greater_than(0) }

      it 'accepts positive file_size values' do
        valid_sizes = [1, 1024, 524_288, 1_048_576, 10_485_760]

        valid_sizes.each do |size|
          image = build(:artwork_image, file_size: size)
          expect(image).to be_valid, "Expected file_size #{size} to be valid"
        end
      end

      it 'rejects zero file_size' do
        image = build(:artwork_image, file_size: 0)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end

      it 'rejects negative file_size' do
        image = build(:artwork_image, file_size: -1000)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets is_primary to false by default' do
      image = ArtworkImage.new
      expect(image.is_primary).to be false
    end

    it 'sets display_order to 0 by default' do
      image = ArtworkImage.new
      expect(image.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artwork) { create(:artwork) }

    describe '.ordered' do
      it 'returns images ordered by display_order ascending' do
        image3 = create(:artwork_image, artwork: artwork, display_order: 2)
        image1 = create(:artwork_image, artwork: artwork, display_order: 0)
        image2 = create(:artwork_image, artwork: artwork, display_order: 1)

        expect(ArtworkImage.ordered).to eq([image1, image2, image3])
      end

      it 'handles same display_order values' do
        image1 = create(:artwork_image, artwork: artwork, display_order: 0)
        image2 = create(:artwork_image, artwork: artwork, display_order: 0)

        expect(ArtworkImage.ordered.count).to eq(2)
      end
    end

    describe '.primary' do
      it 'returns only primary images' do
        primary = create(:artwork_image, :primary, artwork: artwork)
        _not_primary = create(:artwork_image, artwork: artwork, is_primary: false)

        expect(ArtworkImage.primary).to contain_exactly(primary)
      end

      it 'returns empty collection when no primary images exist' do
        create(:artwork_image, artwork: artwork, is_primary: false)
        expect(ArtworkImage.primary).to be_empty
      end

      it 'returns multiple primary images if they exist (edge case)' do
        # This tests the scope behavior, though set_as_primary should prevent this
        primary1 = create(:artwork_image, :primary, artwork: artwork)
        primary2 = create(:artwork_image, :primary, artwork: artwork)

        expect(ArtworkImage.primary).to contain_exactly(primary1, primary2)
      end
    end
  end

  describe '#set_as_primary' do
    let(:artwork) { create(:artwork) }

    context 'when no primary image exists' do
      it 'sets the image as primary' do
        image = create(:artwork_image, artwork: artwork, is_primary: false)
        image.set_as_primary

        expect(image.reload.is_primary).to be true
      end
    end

    context 'when another image is already primary' do
      it 'unsets the previous primary and sets the new one' do
        old_primary = create(:artwork_image, :primary, artwork: artwork)
        new_primary = create(:artwork_image, artwork: artwork, is_primary: false)

        new_primary.set_as_primary

        expect(old_primary.reload.is_primary).to be false
        expect(new_primary.reload.is_primary).to be true
      end

      it 'only affects images from the same artwork' do
        other_artwork = create(:artwork)
        other_primary = create(:artwork_image, :primary, artwork: other_artwork)

        image = create(:artwork_image, artwork: artwork, is_primary: false)
        image.set_as_primary

        expect(image.reload.is_primary).to be true
        expect(other_primary.reload.is_primary).to be true
      end
    end

    context 'when called on already primary image' do
      it 'remains primary' do
        image = create(:artwork_image, :primary, artwork: artwork)
        image.set_as_primary

        expect(image.reload.is_primary).to be true
      end

      it 'does not affect other images' do
        primary = create(:artwork_image, :primary, artwork: artwork)
        other = create(:artwork_image, artwork: artwork, is_primary: false)

        primary.set_as_primary

        expect(primary.reload.is_primary).to be true
        expect(other.reload.is_primary).to be false
      end
    end

    context 'with multiple images' do
      it 'ensures only one primary image per artwork' do
        image1 = create(:artwork_image, :primary, artwork: artwork)
        image2 = create(:artwork_image, artwork: artwork)
        image3 = create(:artwork_image, artwork: artwork)

        image2.set_as_primary

        expect(image1.reload.is_primary).to be false
        expect(image2.reload.is_primary).to be true
        expect(image3.reload.is_primary).to be false
      end

      it 'handles switching primary multiple times' do
        images = create_list(:artwork_image, 4, artwork: artwork)
        images[0].set_as_primary
        images[2].set_as_primary
        images[1].set_as_primary

        images.each(&:reload)
        expect(images.map(&:is_primary)).to eq([false, true, false, false])
      end
    end
  end

  describe 'factory' do
    it 'creates valid artwork_image with default factory' do
      image = build(:artwork_image)
      expect(image).to be_valid
    end

    it 'creates primary artwork_image' do
      image = build(:artwork_image, :primary)
      expect(image).to be_valid
      expect(image.is_primary).to be true
    end

    it 'creates minimal artwork_image' do
      image = build(:artwork_image, :minimal)
      expect(image).to be_valid
      expect(image.alt_text).to be_nil
      expect(image.width).to be_nil
      expect(image.height).to be_nil
      expect(image.file_size).to be_nil
    end

    it 'creates high resolution artwork_image' do
      image = build(:artwork_image, :high_resolution)
      expect(image).to be_valid
      expect(image.width).to eq(4000)
      expect(image.height).to eq(3000)
      expect(image.file_size).to be > 1_000_000
    end
  end
end
