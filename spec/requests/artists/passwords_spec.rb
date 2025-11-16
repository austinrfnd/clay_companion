# frozen_string_literal: true

##
# Artists Passwords Request Spec
#
# Tests the password reset views and functionality.
# Verifies that the password reset pages match wireframe requirements and handle
# all user flows correctly.
#
require 'rails_helper'

RSpec.describe 'Artists Passwords', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /password/reset' do
    context 'when user is not authenticated' do
      it 'renders the password reset request page successfully' do
        get password_reset_request_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading "Reset Your Password"' do
        get password_reset_request_path
        expect(response.body).to include('Reset Your Password')
      end

      it 'displays the subheading text' do
        get password_reset_request_path
        expect(response.body).to include("Enter your email and we'll send you reset instructions")
      end

      it 'displays the email input field' do
        get password_reset_request_path
        expect(response.body).to include('Email Address')
        expect(response.body).to include('type="email"')
        expect(response.body).to include('placeholder="artist@example.com"')
      end

      it 'displays the "Send Reset Instructions" submit button' do
        get password_reset_request_path
        expect(response.body).to include('Send Reset Instructions')
        expect(response.body).to include('type="submit"')
      end

      it 'displays the "Sign in" link' do
        get password_reset_request_path
        expect(response.body).to include('Remember your password?')
        expect(response.body).to include('Sign in')
        expect(response.body).to include(new_artist_session_path)
      end

      it 'has proper form structure with correct action' do
        get password_reset_request_path
        expect(response.body).to include('action=')
        expect(response.body).to include('method="post"')
      end

      it 'includes proper accessibility attributes' do
        get password_reset_request_path
        expect(response.body).to include('aria-label')
        expect(response.body).to include('for=')
      end

      it 'uses design system classes for styling' do
        get password_reset_request_path
        expect(response.body).to include('auth-form-container')
      end
    end

    context 'when user is already authenticated' do
      let(:artist) { create(:artist, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'redirects to dashboard' do
        get password_reset_request_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe 'POST /password/reset' do
    context 'with valid email' do
      let!(:artist) do
        create(:artist, email: 'artist@example.com', password: 'Password123!', full_name: 'Test Artist')
      end

      it 'sends reset password email' do
        expect do
          post password_reset_request_path, params: { artist: { email: 'artist@example.com' } }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to password reset request confirmation' do
        post password_reset_request_path, params: { artist: { email: 'artist@example.com' } }
        expect(response).to redirect_to(password_reset_request_path)
      end

      it 'sets a success flash message' do
        post password_reset_request_path, params: { artist: { email: 'artist@example.com' } }
        follow_redirect!
        expect(response.body).to match(/sent|email|instructions/i)
      end
    end

    context 'with invalid email' do
      it 'does not send reset password email' do
        expect do
          post password_reset_request_path, params: { artist: { email: 'invalid@example.com' } }
        end.not_to change { ActionMailer::Base.deliveries.count }
      end

      it 'still redirects (security: don\'t reveal if email exists)' do
        post password_reset_request_path, params: { artist: { email: 'invalid@example.com' } }
        expect(response).to redirect_to(password_reset_request_path)
      end

      it 'sets a success flash message (security: don\'t reveal if email exists)' do
        post password_reset_request_path, params: { artist: { email: 'invalid@example.com' } }
        follow_redirect!
        expect(response.body).to match(/sent|email|instructions/i)
      end
    end

    context 'with missing email' do
      it 'displays validation error' do
        post password_reset_request_path, params: { artist: { email: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /password/reset/:token' do
    let(:artist) { create(:artist, email: 'artist@example.com', password: 'Password123!', full_name: 'Test Artist') }

    context 'with valid token' do
      before do
        @token = artist.send_reset_password_instructions
      end

      it 'renders the password reset form' do
        get password_reset_edit_path(@token)
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading "Create New Password"' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('Create New Password')
      end

      it 'displays the subheading text' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('Enter your new password below')
      end

      it 'displays the new password input field' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('New Password')
        expect(response.body).to include('type="password"')
      end

      it 'displays the password strength indicator' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('password-strength-indicator')
        expect(response.body).to include('Password Strength:')
      end

      it 'displays the password requirements checklist' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('password-requirements')
        expect(response.body).to include('8-30 characters')
      end

      it 'displays the confirm password input field' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('Confirm New Password')
        expect(response.body).to include('password_confirmation')
      end

      it 'displays the password visibility toggle buttons' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('data-controller="password-toggle"')
        expect(response.body).to include('aria-label="Toggle password visibility"')
      end

      it 'displays the "Reset Password" submit button' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('Reset Password')
        expect(response.body).to include('type="submit"')
      end

      it 'includes proper accessibility attributes' do
        get password_reset_edit_path(@token)
        expect(response.body).to include('aria-label')
        expect(response.body).to include('for=')
      end
    end

    context 'with invalid token' do
      it 'renders the password reset form with error' do
        get password_reset_edit_path('invalid_token')
        expect(response).to have_http_status(:success)
        expect(response.body).to match(/invalid|expired|error/i)
      end
    end

    context 'with expired token' do
      before do
        @token = artist.send_reset_password_instructions
        # Expire the token by setting reset_password_sent_at to more than 1 hour ago
        artist.update_column(:reset_password_sent_at, 2.hours.ago)
      end

      it 'renders the password reset form with error' do
        get password_reset_edit_path(@token)
        expect(response).to have_http_status(:success)
        expect(response.body).to match(/invalid|expired|error/i)
      end
    end
  end

  describe 'PATCH /password/reset/:token' do
    let(:artist) { create(:artist, email: 'artist@example.com', password: 'OldPassword123!', password_confirmation: 'OldPassword123!', full_name: 'Test Artist') }

    context 'with valid token and password' do
      before do
        @token = artist.send_reset_password_instructions
      end

      it 'updates the password' do
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!',
            reset_password_token: @token
          }
        }
        artist.reload
        expect(artist.valid_password?('NewPassword123!')).to be true
      end

      it 'redirects to login page' do
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!',
            reset_password_token: @token
          }
        }
        expect(response).to redirect_to(new_artist_session_path)
      end

      it 'sets a success flash message' do
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!',
            reset_password_token: @token
          }
        }
        follow_redirect!
        expect(response.body).to match(/reset|success|password/i)
      end
    end

    context 'with password too short' do
      before do
        artist.send_reset_password_instructions
        @token = artist.reset_password_token
      end

      it 'does not update the password' do
        old_password = artist.encrypted_password
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'Short1!',
            password_confirmation: 'Short1!',
            reset_password_token: @token
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(old_password)
      end

      it 'renders the edit form with errors' do
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'Short1!',
            password_confirmation: 'Short1!',
            reset_password_token: @token
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error-message')
      end
    end

    context 'with password confirmation mismatch' do
      before do
        artist.send_reset_password_instructions
        @token = artist.reset_password_token
      end

      it 'does not update the password' do
        old_password = artist.encrypted_password
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'DifferentPassword123!',
            reset_password_token: @token
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(old_password)
      end

      it 'renders the edit form with errors' do
        patch password_reset_edit_path(@token), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'DifferentPassword123!',
            reset_password_token: @token
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('error-message')
      end
    end

    context 'with invalid token' do
      it 'does not update the password' do
        old_password = artist.encrypted_password
        patch password_reset_edit_path('invalid_token'), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!',
            reset_password_token: 'invalid_token'
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(old_password)
      end

      it 'renders the edit form with errors' do
        patch password_reset_edit_path('invalid_token'), params: {
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!',
            reset_password_token: 'invalid_token'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/invalid|expired|error/i)
      end
    end
  end
end

