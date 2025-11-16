# frozen_string_literal: true

##
# Letter Opener Initializer
#
# Configures letter_opener for development environment.
# In Docker, prevents Launchy errors by catching browser opening attempts.
# Emails are still saved to tmp/letter_opener/ directory.
#
if Rails.env.development?
  # Check if we're running in Docker
  docker_env = ENV['DOCKER_ENV'] || File.exist?('/.dockerenv')
  
  if docker_env
    # Monkey-patch LetterOpener::DeliveryMethod to catch Launchy errors
    # This allows emails to be saved without trying to open browser
    require 'letter_opener'
    
    module LetterOpener
      class DeliveryMethod
        alias_method :original_deliver!, :deliver!
        
        def deliver!(mail)
          # Call original method to save email
          original_deliver!(mail)
        rescue Launchy::CommandNotFoundError, Launchy::Error => e
          # In Docker, we can't open browser, but email is already saved
          # Just log the error and continue
          Rails.logger.info "Letter Opener: Email saved to tmp/letter_opener/ (browser not available in Docker)"
          Rails.logger.debug "Letter Opener error: #{e.message}"
        end
      end
    end
  end
end

