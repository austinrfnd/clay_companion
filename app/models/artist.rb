class Artist < ApplicationRecord
  # Associations
  has_many :series, dependent: :destroy
  has_many :artwork_groups, dependent: :destroy
  has_many :artworks, dependent: :destroy
  has_many :exhibitions, dependent: :destroy
  has_many :press_mentions, dependent: :destroy
  has_many :studio_images, dependent: :destroy

  # Validations
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: 'must be a valid email address' },
                    length: { maximum: 255 }
  validates :full_name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 2000 }, allow_blank: true
  validates :artist_statement, length: { maximum: 2000 }, allow_blank: true
  validates :location, length: { maximum: 100 }, allow_blank: true
  validates :contact_phone, length: { maximum: 20 }, allow_blank: true

  # Normalize email before validation
  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
