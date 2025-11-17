# frozen_string_literal: true

##
# Studio Image Model
#
# Represents behind-the-scenes photos of artist studios and creative processes.
# Uses Active Storage for image attachments.
#
class StudioImage < ApplicationRecord
  # Associations
  belongs_to :artist

  # Active Storage attachments
  has_one_attached :image

  # Validations
  # Note: image_url validation removed - using Active Storage attachment instead
  # During migration period, image_url may still exist but is not required
  validates :alt_text, length: { maximum: 500 }, allow_blank: true
  validates :caption, length: { maximum: 1000 }, allow_blank: true
  validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Image attachment validation
  validate :image_attachment_validation, if: -> { image.attached? }

  # Scopes
  scope :ordered, -> { order(display_order: :asc, created_at: :asc) }

  private

  ##
  # Validate image attachment
  # Checks file type (JPG, PNG) and file size (max 5MB)
  #
  # @return [void]
  def image_attachment_validation
    return unless image.attached?

    begin
      # Validate file type
      content_type = image.blob.content_type
      unless ['image/jpeg', 'image/jpg', 'image/png'].include?(content_type)
        errors.add(:image, 'must be a JPG or PNG image')
      end

      # Validate file size (5MB = 5 * 1024 * 1024 bytes)
      if image.blob.byte_size > 5.megabytes
        errors.add(:image, 'must be under 5MB. Please compress and try again.')
      end
    rescue ActiveRecord::StatementInvalid
      # If Active Storage tables don't exist yet, skip validation
      # This can happen during migrations
    end
  end
end
