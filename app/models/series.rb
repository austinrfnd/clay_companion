class Series < ApplicationRecord
  # Associations
  belongs_to :artist
  has_many :artwork_groups, dependent: :destroy
  has_many :artworks, through: :artwork_groups

  # Validations
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }, allow_blank: true

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
  scope :ongoing, -> { where(is_ongoing: true) }
  scope :completed, -> { where(is_ongoing: false) }
end
