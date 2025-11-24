# frozen_string_literal: true

##
# Dashboard Settings Controller
#
# Handles the settings hub index page that displays the settings navigation
# and placeholder content for future dashboard widgets.
#
# Routes:
# - GET /dashboard/settings → index (settings hub)
#
class Dashboard::Settings::SettingsController < ApplicationController
  before_action :authenticate_artist!

  ##
  # Display the settings hub with persistent sidebar navigation
  # Shows placeholder content for future dashboard widgets
  #
  # @return [void]
  def index
    # Placeholder for future dashboard content
    # Stats, notifications, activity feed, etc.
  end
end


