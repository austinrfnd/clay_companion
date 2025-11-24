# frozen_string_literal: true

##
# Dashboard Settings Studio Controller
#
# Handles studio settings (hero image selection, intro text, studio images).
# Allows artists to manage their studio page content.
#
# Routes:
# - GET /dashboard/settings/studio → show (studio settings form)
#
class Dashboard::Settings::StudioController < ApplicationController
  before_action :authenticate_artist!
  before_action :set_artist
  before_action :load_studio_images
  before_action :load_hero_image

  ##
  # Display the studio settings form
  # Shows form with hero image selection, intro text, and studio images
  #
  # @return [void]
  def show
    # Artist, studio_images, and hero_image are already loaded via before_actions
  end

  private

  ##
  # Set the current artist for the action
  # Uses current_artist from Devise authentication
  #
  # @return [void]
  def set_artist
    @artist = current_artist
  end

  ##
  # Load studio images for the current artist
  # Orders images by display_order for consistent rendering
  #
  # @return [void]
  def load_studio_images
    @studio_images = @artist.studio_images.ordered
  end

  ##
  # Load the hero image for the current artist
  # Sets @hero_image to the artist's studio_hero_image or nil
  #
  # @return [void]
  def load_hero_image
    @hero_image = @artist.studio_hero_image
  end
end

