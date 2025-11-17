# frozen_string_literal: true

##
# Artist Model
#
# Represents an artist user in the Clay Companion platform.
# Handles authentication via Devise and manages artist profile data.
#
# Key Responsibilities:
# - User authentication (email/password via Devise)
# - Email confirmation
# - Password reset functionality
# - Remember me sessions
# - Profile data management (bio, location, contact info)
# - Portfolio data associations (artworks, series, exhibitions, etc.)
#
# Devise Modules:
# - :database_authenticatable - Email/password authentication
# - :registerable - User registration
# - :recoverable - Password reset via email
# - :rememberable - Persistent sessions
# - :validatable - Email and password validations
# - :confirmable - Email confirmation required
#
class Artist < ApplicationRecord
  # Devise authentication modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  # Associations
  has_many :series, dependent: :destroy
  has_many :artwork_groups, dependent: :destroy
  has_many :artworks, dependent: :destroy
  has_many :exhibitions, dependent: :destroy
  has_many :press_mentions, dependent: :destroy
  has_many :studio_images, dependent: :destroy

  # Active Storage attachments
  has_one_attached :profile_photo

  # Validations
  # Note: Email presence, uniqueness, and format are handled by Devise :validatable
  # We keep format validation for custom error message
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: 'must be a valid email address' },
                    length: { maximum: 255 }
  validates :full_name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 2000 }, allow_blank: true
  validates :artist_statement, length: { maximum: 2000 }, allow_blank: true
  validates :location, length: { maximum: 100 }, allow_blank: true
  validates :contact_phone, length: { maximum: 20 }, allow_blank: true
  
  # Contact email validation (optional, but must be valid format if provided)
  validates :contact_email, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: 'must be a valid email address' },
                            allow_blank: true
  
  # URL validations (optional, but must be valid HTTP/HTTPS URL if provided)
  validates :website_url, format: { with: /\Ahttps?:\/\/.+\z/i, message: 'must be a valid HTTP or HTTPS URL' },
                          allow_blank: true
  validates :instagram_url, format: { with: /\Ahttps?:\/\/.+\z/i, message: 'must be a valid HTTP or HTTPS URL' },
                            allow_blank: true
  validates :facebook_url, format: { with: /\Ahttps?:\/\/.+\z/i, message: 'must be a valid HTTP or HTTPS URL' },
                           allow_blank: true

  # Password complexity validation
  # Note: Devise :validatable handles length (8-128), but we add complexity requirements
  validate :password_complexity, if: :password_required?

  # Profile photo validation (only during profile setup)
  validate :profile_photo_validation, if: :profile_setup_context?

  # Normalize email before validation
  before_validation :normalize_email

  private

  ##
  # Normalize email address before validation
  # Converts to lowercase and strips whitespace
  # Handles nil values gracefully
  #
  # @return [void]
  def normalize_email
    return if email.nil?
    self.email = email.to_s.downcase.strip
  end

  ##
  # Validate password complexity requirements
  # Requires: uppercase, lowercase, number, and special character
  # Length is handled by Devise (8-128 characters)
  #
  # @return [void]
  def password_complexity
    return if password.blank?

    errors.add(:password, 'must contain at least one uppercase letter') unless password.match?(/[A-Z]/)
    errors.add(:password, 'must contain at least one lowercase letter') unless password.match?(/[a-z]/)
    errors.add(:password, 'must contain at least one number') unless password.match?(/[0-9]/)
    errors.add(:password, 'must contain at least one special character') unless password.match?(/[^A-Za-z0-9]/)
  end

  ##
  # Check if password validation is required
  # Only validate password complexity when password is being set (new record or password changed)
  # This works for both signup and password reset flows
  #
  # @return [Boolean] True if password validation is required
  def password_required?
    # For new records, always validate
    return true unless persisted?
    # For existing records, validate if password is being changed
    # Devise sets password and password_confirmation when updating password
    # Only validate if password is actually present (not just token)
    password.present? || password_confirmation.present?
  end

  ##
  # Check if we're in profile setup context
  # Profile photo is required only during profile setup (when profile is incomplete)
  # We check if profile_photo is being set via Active Storage
  #
  # @return [Boolean] True if in profile setup context
  def profile_setup_context?
    # Only validate during profile setup (when profile is incomplete)
    # Check if we're trying to update and profile_photo is not already attached
    return false unless persisted?
    
    begin
      # Only validate if profile_photo is not already attached
      return false if profile_photo.attached?
      
      # Check if profile_photo is actually being set (has a blob that's being uploaded)
      # This prevents validation from running during password resets, etc.
      # We check if there's a new blob being attached (not yet saved)
      profile_photo.blob.present? && !profile_photo.blob.persisted?
    rescue ActiveRecord::StatementInvalid
      # If Active Storage tables don't exist yet, skip validation
      false
    end
  end

  ##
  # Validate profile photo attachment
  # Checks file type (JPG, PNG) and file size (max 5MB)
  # Only validates if profile is incomplete (no photo attached) and a file is being uploaded
  #
  # @return [void]
  def profile_photo_validation
    # Only validate if profile photo is not attached (profile setup context)
    return if profile_photo.attached?
    
    # Check if a file is being uploaded (blob exists after attachment)
    # Note: Active Storage attaches the blob during save, so we check if blob exists
    return unless profile_photo.blob.present?
    
    begin
      # Validate file type
      content_type = profile_photo.blob.content_type
      unless ['image/jpeg', 'image/jpg', 'image/png'].include?(content_type)
        errors.add(:profile_photo, 'must be a JPG or PNG image')
      end
      
      # Validate file size (5MB = 5 * 1024 * 1024 bytes)
      if profile_photo.blob.byte_size > 5.megabytes
        errors.add(:profile_photo, 'must be under 5MB. Please compress and try again.')
      end
    rescue ActiveRecord::StatementInvalid
      # If Active Storage tables don't exist yet, skip validation
      # This can happen during migrations
    end
  end
end
