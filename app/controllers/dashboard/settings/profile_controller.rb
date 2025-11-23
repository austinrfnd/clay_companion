# frozen_string_literal: true

##
# Dashboard Settings Profile Controller
#
# Handles profile settings (bio, artist_statement, education, awards, social links, contact info).
# Allows artists to update their public profile content.
#
# Routes:
# - GET /dashboard/settings/profile → show (profile form)
# - PATCH /dashboard/settings/profile → update (save profile)
#
class Dashboard::Settings::ProfileController < ApplicationController
  before_action :authenticate_artist!
  before_action :set_artist

  ##
  # Display the profile settings form
  # Shows form with bio, artist_statement, education, awards, social links, and contact info
  #
  # @return [void]
  def show
    # Artist is already loaded via set_artist
  end

  ##
  # Update the artist profile information
  # Validates fields and handles JSON fields (education, awards, other_links)
  # Redirects to profile settings on success
  #
  # @return [void]
  def update
    if @artist.update(profile_params)
      set_flash_message!(:notice, :updated)
      redirect_to dashboard_settings_profile_path
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
  # Strong parameters for profile settings
  # Permits: bio, artist_statement, contact_email, contact_phone,
  # website_url, instagram_url, facebook_url, education, awards, other_links
  # Note: Does NOT permit account fields (full_name, location, profile_photo)
  #
  # @return [ActionController::Parameters] Permitted parameters
  def profile_params
    params.require(:artist).permit(
      :bio, :artist_statement,
      :contact_email, :contact_phone,
      :website_url, :instagram_url, :facebook_url,
      education: [:institution, :degree, :year],
      awards: [:title, :organization, :year],
      other_links: [:label, :url]
    )
  end

  ##
  # Set flash message for successful profile update
  #
  # @param type [Symbol] Flash message type (:notice, :alert, etc.)
  # @param key [Symbol] Translation key
  # @return [void]
  def set_flash_message!(type, key)
    flash[type] = I18n.t("dashboard.settings.profile.#{key}", default: 'Profile updated successfully.')
  end
end


