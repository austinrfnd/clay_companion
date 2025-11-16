class Exhibition < ApplicationRecord
  # Constants
  EXHIBITION_TYPES = %w[solo group art_fair museum].freeze

  # Associations
  belongs_to :artist
  has_many :exhibition_images, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }, allow_blank: true
  validates :venue, length: { maximum: 200 }, allow_blank: true
  validates :location, length: { maximum: 200 }, allow_blank: true
  validates :exhibition_type, presence: true,
                              length: { maximum: 20 },
                              inclusion: { in: EXHIBITION_TYPES }
  validates :start_date, presence: true
  validates :curator, length: { maximum: 100 }, allow_blank: true
  validate :end_date_after_start_date

  # Scopes
  scope :ordered, -> { order(display_order: :asc, start_date: :desc) }
  scope :ongoing, -> { where('start_date <= ? AND (end_date IS NULL OR end_date >= ?)', Date.current, Date.current) }
  scope :past, -> { where('end_date < ?', Date.current) }
  scope :upcoming, -> { where('start_date > ?', Date.current) }
  scope :by_type, ->(type) { where(exhibition_type: type) }

  # Instance Methods
  def ongoing?
    start_date <= Date.current && (end_date.nil? || end_date >= Date.current)
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, 'must be on or after start date')
    end
  end
end
