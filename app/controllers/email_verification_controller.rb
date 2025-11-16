# frozen_string_literal: true

##
# Email Verification Controller
#
# Handles the email verification sent page display.
# Shows confirmation that verification email has been sent after signup.
#
class EmailVerificationController < ApplicationController
  ##
  # Display the email verification sent page
  # Shows success message and resend options
  #
  # @return [void]
  def sent
    # Email can come from params or session
    @email = params[:email] || session[:signup_email]
  end
end
