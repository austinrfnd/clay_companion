# frozen_string_literal: true

##
# Profile Setup Controller
#
# Handles profile setup for new artists after email verification.
# Allows artists to upload a profile photo and complete their profile information.
#
# Routes:
# - GET /profile_setup → show (profile setup form)
# - PATCH /profile_setup → update (save profile)
#
class ProfileSetupController < ApplicationController
  before_action :authenticate_artist!
  before_action :set_artist

  ##
  # Display the profile setup form
  # Shows form with portrait photo upload, full name, location, and bio fields
  #
  # @return [void]
  def show
    # Artist is already loaded via set_artist
  end

  ##
  # Update the artist profile with profile setup data
  # Validates required fields (profile_photo, full_name) and optional fields (location, bio)
  # Redirects to dashboard on success
  #
  # @return [void]
  def update
    # Check if profile photo is required (not already attached)
    # Reload to ensure we have the latest attachment state
    @artist.reload
    profile_photo_attached = @artist.profile_photo.attached?
    
    if !profile_photo_attached && profile_setup_params[:profile_photo].blank?
      @artist.errors.add(:profile_photo, 'is required')
      render :show, status: :unprocessable_entity
      return
    end

    if @artist.update(profile_setup_params)
      set_flash_message!(:notice, :updated)
      redirect_to dashboard_path
    else
      render :show, status: :unprocessable_entity
    end
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
  # Strong parameters for profile setup
  # Permits: profile_photo, full_name, location, bio
  #
  # @return [ActionController::Parameters] Permitted parameters
  def profile_setup_params
    params.require(:artist).permit(:profile_photo, :full_name, :location, :bio)
  end

  ##
  # Set flash message for successful profile update
  #
  # @param type [Symbol] Flash message type (:notice, :alert, etc.)
  # @param key [Symbol] Flash message key
  # @return [void]
  def set_flash_message!(type, key)
    flash[type] = 'Profile setup complete! Welcome to Clay Companion.'
  end
end
