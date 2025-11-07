class ArtworkGroup < ApplicationRecord
  # Associations
  belongs_to :artist
  belongs_to :series, optional: true
  has_many :artworks, dependent: :nullify

  # Validations
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }, allow_blank: true

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
end
