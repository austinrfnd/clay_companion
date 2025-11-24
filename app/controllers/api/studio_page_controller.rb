# frozen_string_literal: true

module Api
  ##
  # API Controller for Studio Page
  #
  # Handles studio page hero section data (intro text and hero image).
  # Requires authentication for updates (dashboard only).
  # Public read-only endpoint for portfolio display.
  #
  class StudioPageController < ApplicationController
    before_action :set_artist
    before_action :authenticate_artist_for_api!, only: [:update]
    
    # Handle authentication failures for API - return JSON instead of redirect
    def authenticate_artist_for_api!
      unless artist_signed_in?
        render json: { error: 'Unauthorized' }, status: :unauthorized
        return
      end
    end

    # GET /api/artists/:artist_id/studio-page
    # Fetch studio page hero data (public endpoint)
    #
    # @param artist_id [String] Artist UUID
    # @return [JSON] Studio page hero data (intro_text, background_image_url, title)
    def show
      hero_image_url = @artist.studio_hero_image&.image&.attached? ? rails_blob_url(@artist.studio_hero_image.image) : nil

      render json: {
        hero: {
          intro_text: @artist.studio_intro_text,
          background_image_url: hero_image_url,
          title: 'Studio & Process'
        }
      }
    end

    # PATCH /api/artists/:artist_id/studio-page
    # Update studio page hero data (dashboard only)
    #
    # @param artist_id [String] Artist UUID
    # @param intro_text [String] Studio intro text (optional, max 600 chars)
    # @param hero_image_id [String] StudioImage UUID to set as hero (optional, nil to clear)
    # @return [JSON] Updated studio page data
    def update
      authorize_artist!

      update_params = studio_page_params
      
      # Validate hero_image_id if provided
      if update_params[:hero_image_id].present?
        hero_image = StudioImage.find_by(id: update_params[:hero_image_id], artist_id: @artist.id)
        unless hero_image
          return render json: {
            errors: ['Hero image not found or does not belong to this artist']
          }, status: :unprocessable_entity
        end
        update_params[:studio_hero_image_id] = hero_image.id
      # Also check studio_hero_image_id if provided directly (after hero_image_id check)
      elsif update_params[:studio_hero_image_id].present?
        hero_image = StudioImage.find_by(id: update_params[:studio_hero_image_id], artist_id: @artist.id)
        unless hero_image
          return render json: {
            errors: ['Hero image not found or does not belong to this artist']
          }, status: :unprocessable_entity
        end
      elsif update_params.key?(:hero_image_id) && update_params[:hero_image_id].nil?
        # Explicitly clearing hero image
        update_params[:studio_hero_image_id] = nil
      end
      
      update_params.delete(:hero_image_id)

      if @artist.update(update_params)
        hero_image_url = @artist.studio_hero_image&.image&.attached? ? rails_blob_url(@artist.studio_hero_image.image) : nil

        render json: {
          studio_intro_text: @artist.studio_intro_text,
          background_image_url: hero_image_url,
          hero: {
            intro_text: @artist.studio_intro_text,
            background_image_url: hero_image_url,
            title: 'Studio & Process'
          },
          message: 'Studio page updated successfully'
        }
      else
        render json: {
          errors: @artist.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    private

    ##
    # Set the artist based on route parameter
    #
    # @return [Artist] The requested artist
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    ##
    # Authorize that current artist owns the studio page
    #
    # @return [void]
    # @raise [ActiveRecord::RecordNotFound] If artist doesn't own the page
    def authorize_artist!
      raise ActiveRecord::RecordNotFound unless @artist.id == current_artist.id
    end

    ##
    # Permitted parameters for updating studio page
    #
    # @return [ActionController::Parameters] Permitted params
    def studio_page_params
      params.require(:studio_page).permit(:studio_intro_text, :intro_text, :hero_image_id, :studio_hero_image_id).tap do |permitted|
        # Map intro_text to studio_intro_text if provided
        if permitted.key?(:intro_text) && !permitted.key?(:studio_intro_text)
          permitted[:studio_intro_text] = permitted.delete(:intro_text)
        end
        # Map studio_hero_image_id to hero_image_id for processing
        if permitted.key?(:studio_hero_image_id) && !permitted.key?(:hero_image_id)
          permitted[:hero_image_id] = permitted.delete(:studio_hero_image_id)
        end
      end
    end
  end
end

