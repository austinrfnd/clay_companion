# frozen_string_literal: true

##
# Capybara Configuration
#
# Configures Capybara for feature/integration testing.
# Uses headless Chrome driver for Docker compatibility.
#
require 'capybara/rspec'
require 'selenium-webdriver'

# Configure Capybara
Capybara.configure do |config|
  config.default_driver = :rack_test
  config.javascript_driver = :selenium_chrome_headless
  config.default_max_wait_time = 5
  config.server_port = 3001
end

# Configure Selenium for headless Chrome
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# For non-JavaScript tests, use rack_test (faster)
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, respect_data_method: true, debug: false)
end

