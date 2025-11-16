class PressMention < ApplicationRecord
  # Associations
  belongs_to :artist

  # Validations
  validates :title, presence: true, length: { maximum: 200 }
  validates :publication, presence: true, length: { maximum: 200 }
  validates :author, length: { maximum: 100 }, allow_blank: true
  validates :excerpt, length: { maximum: 1000 }, allow_blank: true
  validates :url, format: { with: /\Ahttps?:\/\/[^\s]+\.[^\s]{2,}\z/, message: 'must be a valid URL' }, allow_blank: true

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
  scope :recent, -> { where.not(published_date: nil).order(published_date: :desc, created_at: :desc) }
end
