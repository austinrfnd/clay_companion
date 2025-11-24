# frozen_string_literal: true

##
# Artists Process Studio Controller
#
# Public-facing controller for the process/studio page.
# Displays behind-the-scenes photos and studio content for visitors.
#
# Routes:
# - GET /artists/:name/process → show (public process/studio page)
#
module Artists
  class ProcessStudioController < ApplicationController
    before_action :set_artist
    before_action :load_studio_images
    before_action :load_hero_image

    ##
    # Display the public process/studio page
    # Shows hero section with background image and intro text,
    # followed by gallery grid of studio images
    #
    # @return [void]
    def show
      # Artist, studio_images, and hero_image are already loaded via before_actions
    end

    private

    ##
    # Set the artist based on route parameter
    # Uses :name parameter (currently artist ID, can be enhanced to use slug)
    #
    # @return [void]
    # @raise [ActiveRecord::RecordNotFound] If artist not found
    def set_artist
      # For MVP, :name is the artist ID (UUID)
      # Future enhancement: add slug field and find by slug
      @artist = Artist.find(params[:name])
    end

    ##
    # Load studio images for the artist
    # Orders images by display_order for consistent rendering
    #
    # @return [void]
    def load_studio_images
      @studio_images = @artist.studio_images.ordered
    end

    ##
    # Load the hero image for the artist
    # Sets @hero_image to the artist's studio_hero_image or nil
    #
    # @return [void]
    def load_hero_image
      @hero_image = @artist.studio_hero_image
    end
  end
end

