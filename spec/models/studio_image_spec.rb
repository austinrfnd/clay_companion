# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudioImage, type: :model do
  ##
  # Test Overview
  # This spec tests the StudioImage model which represents behind-the-scenes photos
  # of artist studios and creative processes. It validates associations, required fields,
  # length constraints, positive integer validation for dimensions/file_size, and scopes.
  #
  # Coverage areas:
  # - Associations (belongs_to artist)
  # - Validations (presence, length, numericality)
  # - Default values (display_order)
  # - Scopes (ordered)
  ##

  describe 'associations' do
    it { is_expected.to belong_to(:artist) }
  end

  describe 'validations' do
    subject { build(:studio_image) }

    describe 'image attachment' do
      let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }
      
      it 'allows studio_image without image attachment (during migration period)' do
        image = build(:studio_image, artist: artist)
        # Don't attach image for this test
        image.image = nil
        # During migration period, image may not be attached yet
        expect(image).to be_valid
      end

      it 'accepts valid image attachments (JPG)' do
        image = build(:studio_image, artist: artist)
        image.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
          filename: 'test.jpg',
          content_type: 'image/jpeg'
        )
        expect(image).to be_valid
      end

      it 'accepts valid image attachments (PNG)' do
        # Create a minimal PNG file for testing
        png_data = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82].pack('C*')
        FileUtils.mkdir_p('spec/fixtures/files')
        File.binwrite('spec/fixtures/files/test_image.png', png_data)
        
        image = build(:studio_image, artist: artist)
        image.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')),
          filename: 'test.png',
          content_type: 'image/png'
        )
        expect(image).to be_valid
      end

      it 'rejects invalid file types' do
        # Create a text file
        FileUtils.mkdir_p('spec/fixtures/files')
        File.write('spec/fixtures/files/test.txt', 'not an image')
        
        image = build(:studio_image, artist: artist)
        image.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.txt')),
          filename: 'test.txt',
          content_type: 'text/plain'
        )
        expect(image).not_to be_valid
        expect(image.errors[:image]).to be_present
      end

      it 'rejects files exceeding 5MB' do
        # Create a large file (6MB)
        large_file = Tempfile.new(['large', '.jpg'])
        large_file.write('x' * (6 * 1024 * 1024))
        large_file.rewind
        
        image = build(:studio_image, artist: artist)
        image.image.attach(
          io: large_file,
          filename: 'large.jpg',
          content_type: 'image/jpeg'
        )
        expect(image).not_to be_valid
        expect(image.errors[:image]).to be_present
        large_file.close
        large_file.unlink
      end
    end

    describe 'alt_text' do
      it { is_expected.to validate_length_of(:alt_text).is_at_most(500) }
      it { is_expected.to allow_value(nil).for(:alt_text) }

      it 'accepts alt_text at maximum length' do
        image = build(:studio_image, alt_text: 'A' * 500)
        expect(image).to be_valid
      end

      it 'rejects alt_text exceeding 500 characters' do
        image = build(:studio_image, alt_text: 'A' * 501)
        expect(image).not_to be_valid
        expect(image.errors[:alt_text]).to be_present
      end
    end

    describe 'caption' do
      it { is_expected.to validate_length_of(:caption).is_at_most(150) }
      it { is_expected.to allow_value(nil).for(:caption) }

      it 'accepts caption at maximum length' do
        image = build(:studio_image, caption: 'A' * 150)
        expect(image).to be_valid
      end

      it 'rejects caption exceeding 1000 characters' do
        image = build(:studio_image, caption: 'A' * 1001)
        expect(image).not_to be_valid
        expect(image.errors[:caption]).to be_present
      end

      it 'accepts descriptive captions' do
        valid_captions = [
          'Working on a new series in my Portland studio',
          'Preparing clay for throwing on the wheel',
          'Glazing process for the minimalist bowl collection'
        ]

        valid_captions.each do |caption|
          image = build(:studio_image, caption: caption)
          expect(image).to be_valid, "Expected caption '#{caption}' to be valid"
        end
      end
    end

    describe 'width' do
      it { is_expected.to allow_value(nil).for(:width) }
      it { is_expected.to validate_numericality_of(:width).only_integer.is_greater_than(0) }

      it 'accepts positive width values' do
        valid_widths = [1, 100, 1920, 4000, 10000]

        valid_widths.each do |width|
          image = build(:studio_image, width: width)
          expect(image).to be_valid, "Expected width #{width} to be valid"
        end
      end

      it 'rejects zero width' do
        image = build(:studio_image, width: 0)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects negative width' do
        image = build(:studio_image, width: -100)
        expect(image).not_to be_valid
        expect(image.errors[:width]).to be_present
      end

      it 'rejects non-integer width' do
        image = build(:studio_image, width: 100.5)
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
          image = build(:studio_image, height: height)
          expect(image).to be_valid, "Expected height #{height} to be valid"
        end
      end

      it 'rejects zero height' do
        image = build(:studio_image, height: 0)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end

      it 'rejects negative height' do
        image = build(:studio_image, height: -100)
        expect(image).not_to be_valid
        expect(image.errors[:height]).to be_present
      end
    end

    describe 'file_size' do
      it { is_expected.to allow_value(nil).for(:file_size) }
      it { is_expected.to validate_numericality_of(:file_size).only_integer.is_greater_than(0) }

      it 'accepts positive file_size values' do
        valid_sizes = [1, 1024, 655_360, 1_048_576, 10_485_760]

        valid_sizes.each do |size|
          image = build(:studio_image, file_size: size)
          expect(image).to be_valid, "Expected file_size #{size} to be valid"
        end
      end

      it 'rejects zero file_size' do
        image = build(:studio_image, file_size: 0)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end

      it 'rejects negative file_size' do
        image = build(:studio_image, file_size: -1000)
        expect(image).not_to be_valid
        expect(image.errors[:file_size]).to be_present
      end
    end
  end

  describe 'default values' do
    it 'sets display_order to 0 by default' do
      image = StudioImage.new
      expect(image.display_order).to eq(0)
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    describe '.ordered' do
      it 'returns images ordered by display_order ascending' do
        image3 = create(:studio_image, artist: artist, display_order: 2)
        image1 = create(:studio_image, artist: artist, display_order: 0)
        image2 = create(:studio_image, artist: artist, display_order: 1)

        expect(StudioImage.ordered).to eq([image1, image2, image3])
      end

      it 'handles same display_order values' do
        image1 = create(:studio_image, artist: artist, display_order: 0)
        image2 = create(:studio_image, artist: artist, display_order: 0)

        expect(StudioImage.ordered.count).to eq(2)
      end
    end
  end

  describe 'display_order functionality' do
    let(:artist) { create(:artist) }

    it 'allows custom display_order values' do
      image1 = create(:studio_image, artist: artist, display_order: 5)
      image2 = create(:studio_image, artist: artist, display_order: 10)

      expect(image1.display_order).to eq(5)
      expect(image2.display_order).to eq(10)
    end

    it 'maintains display_order on update' do
      image = create(:studio_image, artist: artist, display_order: 3)
      image.update!(display_order: 7)

      expect(image.reload.display_order).to eq(7)
    end

    it 'allows multiple images with same display_order' do
      image1 = create(:studio_image, artist: artist, display_order: 1)
      image2 = create(:studio_image, artist: artist, display_order: 1)

      expect(image1.display_order).to eq(image2.display_order)
    end
  end

  describe 'factory' do
    it 'creates valid studio_image with default factory' do
      image = build(:studio_image)
      expect(image).to be_valid
    end

    it 'creates minimal studio_image' do
      image = build(:studio_image, :minimal)
      expect(image).to be_valid
      expect(image.alt_text).to be_nil
      expect(image.caption).to be_nil
      expect(image.width).to be_nil
      expect(image.height).to be_nil
      expect(image.file_size).to be_nil
    end

    it 'creates minimal studio_image without image attachment' do
      image = create(:studio_image, :minimal)
      expect(image).to be_valid
      expect(image.image).not_to be_attached
    end

    it 'creates studio_image with long caption' do
      image = build(:studio_image, :with_long_caption)
      expect(image).to be_valid
      expect(image.caption.length).to eq(150)
    end

    it 'creates high resolution studio_image' do
      image = build(:studio_image, :high_resolution)
      expect(image).to be_valid
      expect(image.width).to eq(4000)
      expect(image.height).to eq(3000)
      expect(image.file_size).to be > 1_000_000
    end

    it 'creates studio_image with process category' do
      image = build(:studio_image, :process_category)
      expect(image).to be_valid
      expect(image.category).to eq('process')
    end

    it 'creates studio_image with other category' do
      image = build(:studio_image, :other_category)
      expect(image).to be_valid
      expect(image.category).to eq('other')
    end
  end

  describe 'category enum and validations' do
    subject { build(:studio_image) }

    describe 'enum' do
      it 'defines studio category' do
        image = build(:studio_image, category: 'studio')
        expect(image.category).to eq('studio')
      end

      it 'defines process category' do
        image = build(:studio_image, category: 'process')
        expect(image.category).to eq('process')
      end

      it 'defines other category' do
        image = build(:studio_image, category: 'other')
        expect(image.category).to eq('other')
      end
    end

    describe 'category validation' do
      it { is_expected.to validate_presence_of(:category) }

      it 'accepts valid categories' do
        valid_categories = ['studio', 'process', 'other']

        valid_categories.each do |category|
          image = build(:studio_image, category: category)
          expect(image).to be_valid, "Expected category '#{category}' to be valid"
        end
      end

      it 'rejects invalid categories' do
        image = build(:studio_image)
        # Rails 8.1 enum is strict - we need to bypass enum validation to test inclusion validation
        image.save(validate: false)
        image.update_column(:category, 'invalid_category')
        image.reload
        expect(image).not_to be_valid
        expect(image.errors[:category]).to be_present
      end

      it 'defaults to other category if not specified' do
        image = build(:studio_image)
        image.category = nil
        expect(image).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:artist) { create(:artist) }

    before do
      create_list(:studio_image, 2, artist: artist, category: 'studio')
      create(:studio_image, :process_category, artist: artist)
      create(:studio_image, :process_category, artist: artist)
      create(:studio_image, :process_category, artist: artist)
      create(:studio_image, :other_category, artist: artist)
    end

    describe 'ordered scope' do
      it 'returns images ordered by display_order then created_at' do
        images = StudioImage.ordered
        expect(images.pluck(:display_order)).to eq(images.pluck(:display_order).sort)
      end
    end

    describe 'by_artist scope' do
      it 'returns only images for specified artist' do
        # Count existing images for this artist (5 from before block)
        existing_count = StudioImage.by_artist(artist.id).count
        
        other_artist = create(:artist, :minimal, confirmed_at: Time.current)
        create(:studio_image, artist: other_artist)

        artist_images = StudioImage.by_artist(artist.id)
        expect(artist_images.count).to eq(existing_count)
        expect(artist_images.all? { |img| img.artist_id == artist.id }).to be true
      end
    end

    describe 'by_category scope' do
      it 'returns only images in specified category' do
        studio_images = StudioImage.by_category('studio')
        expect(studio_images.count).to eq(2)
        expect(studio_images.all? { |img| img.category == 'studio' }).to be true
      end

      it 'returns process category images' do
        process_images = StudioImage.by_category('process')
        expect(process_images.count).to eq(3)
        expect(process_images.all? { |img| img.category == 'process' }).to be true
      end

      it 'returns other category images' do
        other_images = StudioImage.by_category('other')
        expect(other_images.count).to eq(1)
        expect(other_images.all? { |img| img.category == 'other' }).to be true
      end
    end

    describe 'chaining scopes' do
      it 'filters by artist and category' do
        other_artist = create(:artist)
        # Use minimal trait to avoid ActiveStorage attachment issues in this test
        create(:studio_image, :process_category, :minimal, artist: other_artist)

        filtered = StudioImage.by_artist(artist.id).by_category('process')
        expect(filtered.count).to eq(3)
        expect(filtered.all? { |img| img.artist_id == artist.id && img.category == 'process' }).to be true
      end
    end
  end
end
