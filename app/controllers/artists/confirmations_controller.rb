# frozen_string_literal: true

##
# Artists Confirmations Controller
#
# Handles email confirmation functionality for artists.
# Customizes Devise confirmations controller for custom routes and redirects.
#
# Routes:
# - GET /email/verify/:token → show (confirm email)
# - POST /email/resend → create (resend confirmation email)
#
class Artists::ConfirmationsController < Devise::ConfirmationsController
  include ProfileCompleteness

  ##
  # Override show to handle invalid tokens and already confirmed artists
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      # Successfully confirmed
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      # Invalid token or already confirmed
      if resource.persisted? && resource.confirmed?
        # Already confirmed - set info message
        set_flash_message!(:notice, :already_confirmed)
        respond_with_navigational(resource) { redirect_to new_artist_session_path }
      else
        # Invalid token - render error view
        # Don't set flash message here - we'll show error in the view itself
        # to avoid duplicate error display (flash_messages partial + view content)
        respond_with_navigational(resource.errors, status: :ok) do
          render :show, status: :ok
        end
      end
    end
  end

  ##
  # Override create to handle invalid emails (security: don't reveal if email exists)
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    # Always redirect with success message, even if email doesn't exist
    # This prevents email enumeration attacks
    if successfully_sent?(resource)
      set_flash_message!(:notice, :send_instructions)
    else
      # Even if email doesn't exist, show success message for security
      set_flash_message!(:notice, :send_instructions)
    end

    respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
  end

  protected

  ##
  # Redirect after successfully confirming email
  # Signs in the artist and redirects to profile setup if incomplete, otherwise dashboard
  #
  # @param resource_name [Symbol] The resource name (e.g., :artist)
  # @param resource [Artist] The confirmed artist
  # @return [String] Path to redirect to
  def after_confirmation_path_for(resource_name, resource)
    # Sign in the artist after confirmation
    sign_in(resource_name, resource)

    # Redirect based on profile completeness
    if profile_incomplete?(resource)
      profile_setup_path
    else
      dashboard_path
    end
  end

  ##
  # Redirect after resending confirmation instructions
  # Redirects to email verification sent page
  #
  # @param resource_name [Symbol] The resource name (e.g., :artist)
  # @return [String] Path to email verification sent page
  def after_resending_confirmation_instructions_path_for(_resource_name)
    email_verification_sent_path
  end
end
