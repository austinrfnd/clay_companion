# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExhibitionImage, type: :model do
  ##
  # Test Overview
  # This spec tests the ExhibitionImage model which represents images for exhibitions.
  # It validates associations, required fields, length constraints, positive integer validation
  # for dimensions/file_size, and scopes for ordering.
  #
  # Coverage areas:
  # - Associations (belongs_to exhibition)
  # - Validations (presence, length, numericality)
  # - Default values (display_order)
  # - Scopes (ordered)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:exhibition) }
  end

  describe 'validations' do
    subject { build(:exhibition_image) }

    describe 'image_url' do
      it { is_expected.to validate_presence_of(:image_url) }

      it 'accepts valid image URLs' do
        valid_urls = [
          'https://example.com/exhibition.jpg',
          'https://s3.amazonaws.com/bucket/exhibition_image.png',
          'https://cdn.example.com/images/exhibition_123.webp',
          'http://localhost:3000/test.jpg'
        ]

        valid_urls.each do |url|
          image = build(:exhibition_image, image_url: url)
          expect(image).to be_valid, "Expected '#{url}' to be valid"
        end
      end

      it 'rejects empty image_url' do
        image = build(:exhibition_image, image_url: '')
        expect(image).not_to be_valid
        expect(image.errors[:image_url]).to be_present
      end
    end

    describe 'alt_text' do
      it { is_expected.to validate_length_of(:alt_text).is_at_most(500) }
      it { is_expected.to allow_value(nil).for(:alt_text) }

      it 'accepts alt_text at maximum length' do
        image = build(:exhibition_image, alt_text: 'A' * 500)
        expect(image).to be_valid
      end

      it 'rejects alt_text exceeding 500 characters' do
        image = build(:exhibition_image, alt_text: 'A' * 501)
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
          image = build(:exhibition_image, width: width)
          expect(image).to be_valid, "Expected width #{width} to be valid"
        end
      end

      it 'rejects zero width' do
        image = build(:exhibition_image, width: 0)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects negative width' do
        image = build(:exhibition_image, width: -100)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects non-integer width' do
        image = build(:exhibition_image, width: 100.5)
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
          image = build(:exhibition_image, height: height)
          expect(image).to be_valid, "Expected height #{height} to be valid"
        end
      end

      it 'rejects zero height' do
        image = build(:exhibition_image, height: 0)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end

      it 'rejects negative height' do
        image = build(:exhibition_image, height: -100)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end
    end

    describe 'file_size' do
      it { is_expected.to allow_value(nil).for(:file_size) }
      it { is_expected.to validate_numericality_of(:file_size).only_integer.is_greater_than(0) }

      it 'accepts positive file_size values' do
        valid_sizes = [1, 1024, 786_432, 1_048_576, 10_485_760]

        valid_sizes.each do |size|
          image = build(:exhibition_image, file_size: size)
          expect(image).to be_valid, "Expected file_size #{size} to be valid"
        end
      end

      it 'rejects zero file_size' do
        image = build(:exhibition_image, file_size: 0)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end

      it 'rejects negative file_size' do
        image = build(:exhibition_image, file_size: -1000)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets display_order to 0 by default' do
      image = ExhibitionImage.new
      expect(image.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:exhibition) { create(:exhibition) }

    describe '.ordered' do
      it 'returns images ordered by display_order ascending' do
        image3 = create(:exhibition_image, exhibition: exhibition, display_order: 2)
        image1 = create(:exhibition_image, exhibition: exhibition, display_order: 0)
        image2 = create(:exhibition_image, exhibition: exhibition, display_order: 1)

        expect(ExhibitionImage.ordered).to eq([image1, image2, image3])
      end

      it 'handles same display_order values' do
        image1 = create(:exhibition_image, exhibition: exhibition, display_order: 0)
        image2 = create(:exhibition_image, exhibition: exhibition, display_order: 0)

        expect(ExhibitionImage.ordered.count).to eq(2)
      end
    end
  end

  describe 'display_order functionality' do
    let(:exhibition) { create(:exhibition) }

    it 'allows custom display_order values' do
      image1 = create(:exhibition_image, exhibition: exhibition, display_order: 5)
      image2 = create(:exhibition_image, exhibition: exhibition, display_order: 10)

      expect(image1.display_order).to eq(5)
      expect(image2.display_order).to eq(10)
    end

    it 'maintains display_order on update' do
      image = create(:exhibition_image, exhibition: exhibition, display_order: 3)
      image.update!(display_order: 7)

      expect(image.reload.display_order).to eq(7)
    end

    it 'allows multiple images with same display_order' do
      image1 = create(:exhibition_image, exhibition: exhibition, display_order: 1)
      image2 = create(:exhibition_image, exhibition: exhibition, display_order: 1)

      expect(image1.display_order).to eq(image2.display_order)
    end
  end

  describe 'factory' do
    it 'creates valid exhibition_image with default factory' do
      image = build(:exhibition_image)
      expect(image).to be_valid
    end

    it 'creates minimal exhibition_image' do
      image = build(:exhibition_image, :minimal)
      expect(image).to be_valid
      expect(image.alt_text).to be_nil
      expect(image.width).to be_nil
      expect(image.height).to be_nil
      expect(image.file_size).to be_nil
    end

    it 'creates high resolution exhibition_image' do
      image = build(:exhibition_image, :high_resolution)
      expect(image).to be_valid
      expect(image.width).to eq(4000)
      expect(image.height).to eq(3000)
      expect(image.file_size).to be > 1_000_000
    end
  end
end
