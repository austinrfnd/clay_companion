# frozen_string_literal: true

##
# Devise Test Support
#
# Configures Devise for RSpec tests to ensure proper mapping setup.
#
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Ensure Devise mappings are available for controller specs
  # Routes need to be loaded/evaluated before mappings are available
  config.before(:each, type: :controller) do
    # Force routes to be evaluated if they haven't been yet
    # This is important for Rails 8.1+ with lazy route loading
    Rails.application.routes.url_helpers if Rails.application.routes.respond_to?(:url_helpers)
    
    # Access Devise mappings - try both symbol and string keys
    mapping = Devise.mappings[:artist] || Devise.mappings['artist']
    
    if mapping
      @request.env['devise.mapping'] = mapping
    else
      # If mapping is still nil, try to find it by path
      # This can happen if routes haven't been fully initialized
      begin
        # Try to access a Devise route to force initialization
        Rails.application.routes.url_for(controller: 'artists/sessions', action: 'new') rescue nil
        mapping = Devise.mappings[:artist] || Devise.mappings['artist']
        @request.env['devise.mapping'] = mapping if mapping
      rescue
        # If all else fails, the mapping will be nil and the test will fail with a clear error
        @request.env['devise.mapping'] = nil
      end
    end
  end

  # Ensure Devise mappings are available for request specs
  # Request specs go through the full Rails stack, so routes should be loaded
  # But we still need to ensure mappings are initialized
  config.before(:each, type: :request) do
    # Force routes to be evaluated if they haven't been yet
    Rails.application.routes.url_helpers if Rails.application.routes.respond_to?(:url_helpers)
    
    # Try to access a Devise route to force initialization
    begin
      Rails.application.routes.url_for(controller: 'artists/sessions', action: 'new') rescue nil
    rescue
      # Routes might not be fully loaded yet, that's okay
    end
  end
end

