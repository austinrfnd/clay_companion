class ArtworkImage < ApplicationRecord
  # Associations
  belongs_to :artwork

  # Validations
  validates :image_url, presence: true
  validates :alt_text, length: { maximum: 500 }, allow_blank: true
  validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
  scope :primary, -> { where(is_primary: true) }

  # Instance Methods
  def set_as_primary
    transaction do
      # Unset any existing primary images for this artwork
      artwork.artwork_images.where.not(id: id).update_all(is_primary: false)
      # Set this image as primary
      update!(is_primary: true)
    end
  end
end
