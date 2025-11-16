# frozen_string_literal: true

##
# Artists Passwords Controller
#
# Handles password reset functionality for artists.
# Customizes Devise passwords controller for custom routes and redirects.
#
# Routes:
# - GET /password/reset → new (request reset form)
# - POST /password/reset → create (send reset email)
# - GET /password/reset/:token → edit (reset form with token)
# - PATCH/PUT /password/reset/:token → update (reset password)
#
class Artists::PasswordsController < Devise::PasswordsController
  ##
  # Redirect authenticated users away from password reset pages
  # Use prepend to ensure it runs before Devise's logic
  prepend_before_action :redirect_if_authenticated, only: [:new]

  ##
  # Override edit to check for expired tokens
  def edit
    super
    # Check if token is expired after Devise loads the resource
    # Devise loads the resource based on the token, so we need to check if it's expired
    if resource.persisted?
      if resource.reset_password_sent_at.present? && resource.reset_password_sent_at < 1.hour.ago
        resource.errors.add(:base, :expired, message: "This password reset link is invalid or has expired. Please request a new one.")
      elsif resource.reset_password_sent_at.blank?
        # If sent_at is blank, token might be invalid
        resource.errors.add(:base, :invalid, message: "This password reset link is invalid or has expired. Please request a new one.")
      end
    elsif resource.errors.empty?
      # If resource is not persisted and there are no errors, token might be invalid/expired
      resource.errors.add(:base, :invalid, message: "This password reset link is invalid or has expired. Please request a new one.")
    end
  end

  ##
  # Override create to handle invalid emails (security: don't reveal if email exists)
  def create
    # Validate email presence first
    if resource_params[:email].blank?
      self.resource = resource_class.new
      resource.errors.add(:email, :blank)
      render :new, status: :unprocessable_entity
      return
    end

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    # Always redirect with success message, even if email doesn't exist
    # This prevents email enumeration attacks
    if successfully_sent?(resource)
      set_flash_message!(:notice, :send_instructions)
    else
      # Even if email doesn't exist, show success message for security
      set_flash_message!(:notice, :send_instructions)
    end

    respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
  end

  protected

  ##
  # Redirect authenticated users to dashboard
  # Prevents authenticated users from accessing password reset pages
  def redirect_if_authenticated
    redirect_to dashboard_path if artist_signed_in?
  end

  ##
  # Redirect after successfully resetting password
  # Redirects to login page with success message
  #
  # @param resource [Artist] The artist who reset their password
  # @return [String] Path to login page
  def after_resetting_password_path_for(_resource)
    new_artist_session_path
  end

  ##
  # Redirect after sending reset password instructions
  # Redirects back to password reset request page with success message
  #
  # @param resource_name [Symbol] The resource name (e.g., :artist)
  # @return [String] Path to password reset request page
  def after_sending_reset_password_instructions_path_for(_resource_name)
    password_reset_request_path
  end
end
