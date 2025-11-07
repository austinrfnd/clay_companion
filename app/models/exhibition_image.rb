class ExhibitionImage < ApplicationRecord
  # Associations
  belongs_to :exhibition

  # Validations
  validates :image_url, presence: true
  validates :alt_text, length: { maximum: 500 }, allow_blank: true
  validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
end
