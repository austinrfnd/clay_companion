# frozen_string_literal: true

##
# Rake task to migrate studio_images from image_url to Active Storage
#
# Usage:
#   rails migrate_studio_images:to_active_storage
#
# This task:
# - Fetches all StudioImage records with image_url values
# - Downloads images from URLs (if accessible)
# - Attaches to Active Storage using image.attach
# - Handles errors gracefully (skips if URL inaccessible)
# - Logs progress and errors
#
namespace :migrate_studio_images do
  desc 'Migrate studio_images from image_url to Active Storage attachments'
  task to_active_storage: :environment do
    require 'net/http'
    require 'uri'
    require 'open-uri'

    puts "Starting migration of studio_images to Active Storage..."
    puts "=" * 60

    total = StudioImage.where.not(image_url: [nil, '']).count
    puts "Found #{total} studio_images with image_url to migrate"
    puts ""

    success_count = 0
    error_count = 0
    skipped_count = 0

    StudioImage.where.not(image_url: [nil, '']).find_each do |studio_image|
      next if studio_image.image.attached? # Skip if already migrated

      begin
        url = studio_image.image_url
        puts "Processing StudioImage ##{studio_image.id}: #{url}"

        # Download image from URL
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)

        unless response.is_a?(Net::HTTPSuccess)
          puts "  ⚠️  Failed to download: HTTP #{response.code}"
          error_count += 1
          next
        end

        # Determine filename from URL or use default
        filename = File.basename(uri.path)
        filename = 'studio_image.jpg' if filename.empty? || !filename.match?(/\.(jpg|jpeg|png)$/i)

        # Determine content type
        content_type = response.content_type || 'image/jpeg'
        unless ['image/jpeg', 'image/jpg', 'image/png'].include?(content_type)
          puts "  ⚠️  Invalid content type: #{content_type}"
          error_count += 1
          next
        end

        # Attach to Active Storage
        studio_image.image.attach(
          io: StringIO.new(response.body),
          filename: filename,
          content_type: content_type
        )

        puts "  ✅ Successfully attached image"
        success_count += 1

      rescue URI::InvalidURIError => e
        puts "  ⚠️  Invalid URL: #{e.message}"
        error_count += 1
      rescue StandardError => e
        puts "  ⚠️  Error: #{e.class} - #{e.message}"
        error_count += 1
      end
    end

    puts ""
    puts "=" * 60
    puts "Migration complete!"
    puts "  ✅ Successfully migrated: #{success_count}"
    puts "  ⚠️  Errors: #{error_count}"
    puts "  ⏭️  Skipped (already migrated): #{skipped_count}"
    puts ""
    puts "Next steps:"
    puts "  1. Verify migrated images in Active Storage"
    puts "  2. Run: rails generate migration RemoveImageUrlFromStudioImages"
    puts "  3. Remove image_url column after verification"
  end
end

