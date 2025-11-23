# frozen_string_literal: true

##
# Dashboard Settings Account Controller
#
# Handles account settings (full_name, location, profile_photo).
# Allows artists to update their basic account information.
#
# Routes:
# - GET /dashboard/settings/account → show (account form)
# - PATCH /dashboard/settings/account → update (save account info)
#
class Dashboard::Settings::AccountController < ApplicationController
  before_action :authenticate_artist!
  before_action :set_artist

  ##
  # Display the account settings form
  # Shows form with full_name, location, and profile_photo fields
  #
  # @return [void]
  def show
    # Artist is already loaded via set_artist
  end

  ##
  # Update the artist account information
  # Validates required fields (full_name) and optional fields (location, profile_photo)
  # Redirects to account settings on success
  #
  # @return [void]
  def update
    if @artist.update(account_params)
      set_flash_message!(:notice, :updated)
      redirect_to dashboard_settings_account_path
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
  # Strong parameters for account settings
  # Permits: full_name, location, profile_photo
  #
  # @return [ActionController::Parameters] Permitted parameters
  def account_params
    params.require(:artist).permit(:full_name, :location, :profile_photo)
  end

  ##
  # Set flash message for successful account update
  #
  # @param type [Symbol] Flash message type (:notice, :alert, etc.)
  # @param key [Symbol] Translation key
  # @return [void]
  def set_flash_message!(type, key)
    flash[type] = I18n.t("dashboard.settings.account.#{key}", default: 'Account updated successfully.')
  end
end


