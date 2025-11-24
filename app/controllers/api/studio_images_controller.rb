# frozen_string_literal: true

module Api
  ##
  # API Controller for Studio Images
  #
  # Handles CRUD operations for studio images and related metadata.
  # Requires authentication for dashboard operations (upload, update, delete).
  # Public read-only endpoints for portfolio display.
  #
  class StudioImagesController < ApplicationController
    before_action :set_artist
    before_action :authenticate_artist_for_api!, except: [:index, :show]
    before_action :set_studio_image, only: [:show, :update, :destroy]
    before_action :authorize_artist!, only: [:update, :destroy]
    
    # Handle authentication failures for API - return JSON instead of redirect
    def authenticate_artist_for_api!
      unless artist_signed_in?
        render json: { error: 'Unauthorized' }, status: :unauthorized
        return
      end
    end

    # GET /api/artists/:artist_id/studio-images
    # Fetch all studio images for an artist (public endpoint)
    #
    # @param artist_id [String] Artist UUID
    # @return [JSON] Array of studio images with metadata
    def index
      @studio_images = @artist.studio_images.ordered

      render json: {
        images: @studio_images.map { |img| serialize_studio_image(img) },
        total: @studio_images.count
      }
    end

    # GET /api/artists/:artist_id/studio-images/:id
    # Fetch a single studio image (public endpoint)
    #
    # @param artist_id [String] Artist UUID
    # @param id [String] StudioImage UUID
    # @return [JSON] Studio image with full metadata
    def show
      render json: serialize_studio_image(@studio_image)
    end

    # POST /api/artists/:artist_id/studio-images
    # Upload a new studio image (dashboard only)
    #
    # @param artist_id [String] Artist UUID
    # @param file [File] Image file (multipart)
    # @param caption [String] Image caption (optional, max 150 chars)
    # @param category [String] Image category - studio|process|other (default: other)
    # @return [JSON] Created studio image with metadata
    def create
      authorize_artist_for_create!
      
      # Validate category before building to avoid ArgumentError from enum
      params_hash = studio_image_params.to_h
      if params_hash[:category].present? && !StudioImage.categories.key?(params_hash[:category])
        @studio_image = @artist.studio_images.build
        @studio_image.errors.add(:category, 'is not a valid category')
        return render json: {
          errors: @studio_image.errors.full_messages
        }, status: :unprocessable_entity
      end
      
      @studio_image = @artist.studio_images.build(studio_image_params)
      @studio_image.display_order = @artist.studio_images.maximum(:display_order).to_i + 1

      if @studio_image.save
        render json: {
          id: @studio_image.id,
          caption: @studio_image.caption,
          category: @studio_image.category,
          display_order: @studio_image.display_order,
          image_url: @studio_image.image.attached? ? rails_blob_url(@studio_image.image) : nil,
          message: 'Image uploaded successfully'
        }, status: :created
      else
        render json: {
          errors: @studio_image.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    # PATCH /api/artists/:artist_id/studio-images/:id
    # Update studio image metadata (dashboard only)
    #
    # @param artist_id [String] Artist UUID
    # @param id [String] StudioImage UUID
    # @param caption [String] Updated caption (optional)
    # @param category [String] Updated category (optional)
    # @param display_order [Integer] Updated display order (optional)
    # @return [JSON] Updated studio image
    def update
      # Validate category before updating to avoid ArgumentError from enum
      update_params_hash = studio_image_update_params.to_h
      if update_params_hash[:category].present? && !StudioImage.categories.key?(update_params_hash[:category])
        @studio_image.errors.add(:category, 'is not a valid category')
        return render json: {
          errors: @studio_image.errors.full_messages
        }, status: :unprocessable_entity
      end
      
      if @studio_image.update(studio_image_update_params)
        render json: {
          id: @studio_image.id,
          caption: @studio_image.caption,
          category: @studio_image.category,
          display_order: @studio_image.display_order,
          image_url: @studio_image.image.attached? ? rails_blob_url(@studio_image.image) : nil,
          message: 'Image updated successfully'
        }
      else
        render json: {
          errors: @studio_image.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    # DELETE /api/artists/:artist_id/studio-images/:id
    # Delete a studio image (dashboard only)
    #
    # @param artist_id [String] Artist UUID
    # @param id [String] StudioImage UUID
    # @return [JSON] Success message
    def destroy
      # If this image is set as the hero image, clear it
      @artist.update(studio_hero_image_id: nil) if @artist.studio_hero_image_id == @studio_image.id

      # Purge the image attachment before destroying to avoid ActiveStorage issues
      @studio_image.image.purge if @studio_image.image.attached?
      
      if @studio_image.destroy
        render json: { message: 'Image deleted successfully' }, status: :ok
      else
        render json: {
          errors: ['Unable to delete image']
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
    # Set the studio image based on route parameters
    #
    # @return [StudioImage] The requested studio image
    def set_studio_image
      @studio_image = StudioImage.find(params[:id])
    end

    ##
    # Authorize that current artist owns the artist in the route
    #
    # @return [void]
    # @raise [ActiveRecord::RecordNotFound] If artist doesn't match
    def authorize_artist_for_create!
      raise ActiveRecord::RecordNotFound unless @artist.id == current_artist.id
    end

    ##
    # Authorize that current artist owns the studio image
    #
    # @return [void]
    # @raise [ActiveRecord::RecordNotFound] If artist doesn't own the image
    def authorize_artist!
      raise ActiveRecord::RecordNotFound unless @studio_image.artist_id == current_artist.id
    end

    ##
    # Permitted parameters for creating a studio image
    #
    # @return [ActionController::Parameters] Permitted params
    def studio_image_params
      params.require(:studio_image).permit(:image, :caption, :category, :alt_text)
    end

    ##
    # Permitted parameters for updating a studio image
    #
    # @return [ActionController::Parameters] Permitted params
    def studio_image_update_params
      params.require(:studio_image).permit(:caption, :category, :display_order, :alt_text)
    end

    ##
    # Serialize a studio image for JSON response
    #
    # @param image [StudioImage] The studio image to serialize
    # @return [Hash] Serialized image data
    def serialize_studio_image(image)
      {
        id: image.id,
        caption: image.caption,
        category: image.category,
        display_order: image.display_order,
        image_url: image.image.attached? ? rails_blob_url(image.image) : nil,
        alt_text: image.alt_text,
        created_at: image.created_at,
        updated_at: image.updated_at
      }
    end
  end
end
