# frozen_string_literal: true

##
# Artists Registrations Controller
#
# Handles artist signup and registration functionality.
# Customizes Devise registrations controller for custom routes and redirects.
#
# Routes:
# - GET /signup → new (signup form)
# - POST /signup → create (register new artist)
#
class Artists::RegistrationsController < Devise::RegistrationsController
  # Redirect authenticated users away from signup page
  # Use prepend to ensure it runs before Devise's logic
  prepend_before_action :redirect_if_authenticated, only: [:new]
  before_action :configure_sign_up_params, only: [:create]

  protected

  ##
  # Redirect after successful sign up
  # Since email confirmation is required, user is not signed in yet
  # Redirects to email verification sent page with email parameter
  #
  # @param resource [Artist] The newly created artist
  # @return [String] Path to redirect to
  def after_sign_up_path_for(resource)
    email_verification_sent_path(email: resource.email)
  end

  ##
  # Redirect after sign up for inactive (unconfirmed) accounts
  # This is called when email confirmation is required
  # Redirects to email verification sent page with email parameter
  #
  # @param resource [Artist] The newly created artist
  # @return [String] Path to redirect to
  def after_inactive_sign_up_path_for(resource)
    email_verification_sent_path(email: resource.email)
  end

  private

  ##
  # Configure permitted parameters for sign up
  # Allows full_name to be submitted during registration
  #
  # @return [void]
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  ##
  # Redirect to dashboard if user is already authenticated
  # Prevents authenticated users from accessing signup page
  def redirect_if_authenticated
    if artist_signed_in?
      redirect_to dashboard_path
      return
    end
  end
end
