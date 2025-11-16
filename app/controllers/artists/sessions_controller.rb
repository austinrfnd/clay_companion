# frozen_string_literal: true

##
# Artists Sessions Controller
#
# Handles artist login and logout functionality.
# Customizes Devise sessions controller for custom routes and redirects.
#
# Routes:
# - GET /login → new (login form)
# - POST /login → create (authenticate)
# - DELETE /logout → destroy (sign out)
#
class Artists::SessionsController < Devise::SessionsController
  include ProfileCompleteness

  # Redirect authenticated users away from login page
  before_action :redirect_if_authenticated, only: [:new]

  protected

  ##
  # Redirect after successful sign in
  # Redirects to profile setup if profile is incomplete, otherwise to dashboard
  #
  # @return [String] Path to redirect to
  def after_sign_in_path_for(resource)
    if profile_incomplete?(resource)
      profile_setup_path
    else
      dashboard_path
    end
  end

  ##
  # Redirect after sign out
  # Always redirects to login page
  #
  # @return [String] Path to login page
  def after_sign_out_path_for(_resource_or_scope)
    new_artist_session_path
  end

  private

  ##
  # Redirect to dashboard if user is already authenticated
  # Prevents authenticated users from accessing login page
  def redirect_if_authenticated
    redirect_to dashboard_path if artist_signed_in?
  end
end
