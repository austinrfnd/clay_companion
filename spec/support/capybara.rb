# frozen_string_literal: true

##
# Capybara Configuration
#
# Configures Capybara for feature/integration testing.
# Uses Cuprite (Chrome DevTools Protocol) for fast JavaScript testing.
#
require 'capybara/rspec'
require 'capybara/cuprite'

# Configure Capybara
Capybara.configure do |config|
  config.default_driver = :rack_test
  config.javascript_driver = :cuprite
  config.default_max_wait_time = 5
  config.server_port = 3001
end

# Configure Cuprite for headless Chrome (faster than Selenium)
Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1400, 1400],
    browser_options: {
      'no-sandbox' => nil,
      'disable-dev-shm-usage' => nil,
      'disable-gpu' => nil
    },
    headless: true,
    js_errors: true,  # Raise JavaScript errors in tests
    slowmo: 0  # Optional: slow down operations for debugging (set to > 0)
  )
end

# For non-JavaScript tests, use rack_test (faster)
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, respect_data_method: true, debug: false)
end

