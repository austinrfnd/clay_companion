# frozen_string_literal: true

##
# Shared Examples for Image Models
#
# These shared examples provide reusable test cases for models that represent images
# with common attributes like image_url, alt_text, width, height, file_size, and display_order.
#
# Usage:
#   RSpec.describe ArtworkImage, type: :model do
#     it_behaves_like 'an image model'
#   end
##

RSpec.shared_examples 'an image model' do
  describe 'common image validations' do
    subject { build(described_class.model_name.element.to_sym) }

    it 'validates presence of image_url' do
      expect(subject).to validate_presence_of(:image_url)
    end

    it 'validates length of alt_text' do
      expect(subject).to validate_length_of(:alt_text).is_at_most(500)
    end

    it 'allows nil alt_text' do
      expect(subject).to allow_value(nil).for(:alt_text)
    end

    it 'validates positive width if present' do
      expect(subject).to validate_numericality_of(:width)
        .only_integer
        .is_greater_than(0)
        .allow_nil
    end

    it 'validates positive height if present' do
      expect(subject).to validate_numericality_of(:height)
        .only_integer
        .is_greater_than(0)
        .allow_nil
    end

    it 'validates positive file_size if present' do
      expect(subject).to validate_numericality_of(:file_size)
        .only_integer
        .is_greater_than(0)
        .allow_nil
    end
  end

  describe 'common image default values' do
    it 'sets display_order to 0 by default' do
      image = described_class.new
      expect(image.display_order).to eq(0)
    end
  end

  describe 'common image scopes' do
    describe '.ordered' do
      it 'orders by display_order ascending' do
        factory_name = described_class.model_name.element.to_sym
        parent_association = described_class.reflect_on_all_associations(:belongs_to).first
        parent = create(parent_association.name)

        image3 = create(factory_name, parent_association.name => parent, display_order: 2)
        image1 = create(factory_name, parent_association.name => parent, display_order: 0)
        image2 = create(factory_name, parent_association.name => parent, display_order: 1)

        expect(described_class.ordered).to eq([image1, image2, image3])
      end
    end
  end
end

RSpec.shared_examples 'a model with display_order' do
  let(:factory_name) { described_class.model_name.element.to_sym }

  it 'allows custom display_order values' do
    record1 = create(factory_name, display_order: 5)
    record2 = create(factory_name, display_order: 10)

    expect(record1.display_order).to eq(5)
    expect(record2.display_order).to eq(10)
  end

  it 'maintains display_order on update' do
    record = create(factory_name, display_order: 3)
    record.update!(display_order: 7)

    expect(record.reload.display_order).to eq(7)
  end

  it 'allows multiple records with same display_order' do
    record1 = create(factory_name, display_order: 1)
    record2 = create(factory_name, display_order: 1)

    expect(record1.display_order).to eq(record2.display_order)
  end
end
