class Artwork < ApplicationRecord
  # Associations
  belongs_to :artist
  belongs_to :series, optional: true
  belongs_to :artwork_group, optional: true
  has_many :artwork_images, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { maximum: 200 }
  validates :year, presence: true,
                   numericality: {
                     only_integer: true,
                     greater_than_or_equal_to: 1900,
                     less_than_or_equal_to: -> { Time.current.year + 1 }
                   }
  validates :medium, length: { maximum: 200 }, allow_blank: true
  validates :dimensions, length: { maximum: 200 }, allow_blank: true
  validates :description, length: { maximum: 2000 }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes
  scope :featured, -> { where(is_featured: true) }
  scope :for_sale, -> { where(is_for_sale: true, is_sold: false) }
  scope :sold, -> { where(is_sold: true) }
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }

  # Instance Methods
  def primary_image
    artwork_images.find_by(is_primary: true) || artwork_images.order(display_order: :asc, created_at: :asc).first
  end
end
