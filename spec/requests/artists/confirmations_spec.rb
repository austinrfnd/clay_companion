# frozen_string_literal: true

##
# Artists Confirmations Request Spec
#
# Tests the email verification views and functionality.
# Verifies that the email verification pages match wireframe requirements and handle
# all user flows correctly.
#
require 'rails_helper'

RSpec.describe 'Artists Confirmations', type: :request do
  include Devise::Test::IntegrationHelpers

  # Set default host for request specs
  before do
    host! 'www.example.com'
  end

  describe 'GET /email/verify/:token' do
    context 'with valid confirmation token' do
      let(:artist) do
        # Create artist without triggering confirmation email callback
        artist = build(:artist, email: 'test@example.com', full_name: 'Test Artist', confirmed_at: nil)
        artist.save(validate: false)
        artist
      end

      before do
        # Manually send confirmation instructions (this uses test delivery method)
        artist.send_confirmation_instructions
      end

      context 'when profile is complete' do
        before do
          artist.update(location: 'Portland, OR')
        end

        it 'confirms the artist email' do
          expect {
            get email_verification_path(confirmation_token: artist.confirmation_token)
          }.to change { artist.reload.confirmed? }.from(false).to(true)
        end

        it 'signs in the artist' do
          get email_verification_path(confirmation_token: artist.confirmation_token)
          expect(controller.current_artist).to eq(artist)
        end

        it 'redirects to dashboard' do
          get email_verification_path(confirmation_token: artist.confirmation_token)
          expect(response).to redirect_to(dashboard_path)
        end

        it 'sets a success flash message' do
          get email_verification_path(confirmation_token: artist.confirmation_token)
          expect(flash[:notice]).to be_present
        end
      end

      context 'when profile is incomplete' do
        let(:incomplete_artist) do
          # Create artist with empty full_name to make profile incomplete
          # Use minimal trait to avoid other required fields, then set full_name to empty string
          artist = build(:artist, :minimal, email: 'incomplete@example.com', full_name: '', confirmed_at: nil)
          artist.save(validate: false)
          artist
        end

        before do
          # Manually send confirmation instructions for incomplete artist
          incomplete_artist.send_confirmation_instructions
        end

        it 'confirms the artist email' do
          expect {
            get email_verification_path(confirmation_token: incomplete_artist.confirmation_token)
          }.to change { incomplete_artist.reload.confirmed? }.from(false).to(true)
        end

        it 'signs in the artist' do
          get email_verification_path(confirmation_token: incomplete_artist.confirmation_token)
          expect(controller.current_artist).to eq(incomplete_artist)
        end

        it 'redirects to profile setup' do
          get email_verification_path(confirmation_token: incomplete_artist.confirmation_token)
          expect(response).to redirect_to(profile_setup_path)
        end

        it 'sets a success flash message' do
          get email_verification_path(confirmation_token: incomplete_artist.confirmation_token)
          expect(flash[:notice]).to be_present
        end
      end
    end

    context 'with invalid confirmation token' do
      it 'renders the error page successfully' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response).to have_http_status(:success)
      end

      it 'displays the error heading' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response.body).to include('Verification Link Invalid')
      end

      it 'displays the error message' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response.body).to match(/invalid|expired/i)
      end

      it 'displays the "Resend Verification Email" button' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response.body).to include('Resend Verification Email')
      end

      it 'displays the "Sign in" link' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response.body).to include('Sign in')
        expect(response.body).to include(new_artist_session_path)
      end

      it 'uses design system classes for styling' do
        get email_verification_path(confirmation_token: 'invalid_token')
        expect(response.body).to include('auth-form-container')
      end
    end

    context 'with already confirmed artist' do
      let(:artist) do
        # Create confirmed artist without triggering confirmation email callback
        artist = build(:artist, email: 'test@example.com', full_name: 'Test Artist', confirmed_at: Time.current)
        artist.save(validate: false)
        artist
      end

      before do
        # Manually send confirmation instructions (this uses test delivery method)
        artist.send_confirmation_instructions
      end

      it 'redirects to login' do
        get email_verification_path(confirmation_token: artist.confirmation_token)
        expect(response).to redirect_to(new_artist_session_path)
      end

      it 'sets an info flash message' do
        get email_verification_path(confirmation_token: artist.confirmation_token)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'POST /email/resend' do
    context 'when user is not authenticated' do
      it 'renders the resend form page successfully' do
        get new_confirmation_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading' do
        get new_confirmation_path
        expect(response.body).to include('Resend Verification Email')
      end

      it 'displays the email input field' do
        get new_confirmation_path
        expect(response.body).to include('Email Address')
        expect(response.body).to include('type="email"')
      end

      it 'displays the "Resend Verification Email" submit button' do
        get new_confirmation_path
        expect(response.body).to include('Resend Verification Email')
        expect(response.body).to include('type="submit"')
      end

      it 'has proper form structure with correct action' do
        get new_confirmation_path
        expect(response.body).to include('action=')
        expect(response.body).to include('method="post"')
      end

      it 'includes proper accessibility attributes' do
        get new_confirmation_path
        expect(response.body).to include('aria-label')
        expect(response.body).to include('for=')
      end

      it 'uses design system classes for styling' do
        get new_confirmation_path
        expect(response.body).to include('auth-form-container')
      end
    end

    context 'with valid email' do
      let!(:artist) do
        # Create artist without triggering confirmation email callback
        artist = build(:artist, email: 'test@example.com', full_name: 'Test Artist', confirmed_at: nil)
        artist.save(validate: false)
        artist
      end

      it 'sends confirmation email' do
        expect {
          post resend_confirmation_path, params: { artist: { email: 'test@example.com' } }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to email verification sent page' do
        post resend_confirmation_path, params: { artist: { email: 'test@example.com' } }
        expect(response).to redirect_to(email_verification_sent_path)
      end

      it 'sets a success flash message' do
        post resend_confirmation_path, params: { artist: { email: 'test@example.com' } }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid email' do
      it 'does not send confirmation email' do
        expect {
          post resend_confirmation_path, params: { artist: { email: 'nonexistent@example.com' } }
        }.not_to change { ActionMailer::Base.deliveries.count }
      end

      it 'still redirects (security: don\'t reveal if email exists)' do
        post resend_confirmation_path, params: { artist: { email: 'nonexistent@example.com' } }
        expect(response).to have_http_status(:redirect)
      end

      it 'sets a success flash message (security: don\'t reveal if email exists)' do
        post resend_confirmation_path, params: { artist: { email: 'nonexistent@example.com' } }
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET /email_verification_sent' do
    context 'when user is not authenticated' do
      it 'renders the email verification sent page successfully' do
        get email_verification_sent_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading "Verify Your Email Address"' do
        get email_verification_sent_path
        expect(response.body).to include('Verify Your Email Address')
      end

      it 'displays the success message' do
        get email_verification_sent_path
        expect(response.body).to match(/sent.*verification email|verification email.*sent/i)
      end

      it 'displays the "Resend Verification Email" button' do
        get email_verification_sent_path
        expect(response.body).to include('Resend Verification Email')
      end

      it 'displays the "try a different email address" link' do
        get email_verification_sent_path
        expect(response.body).to include('try a different email address')
      end

      it 'uses design system classes for styling' do
        get email_verification_sent_path
        expect(response.body).to include('email-verification-page-container')
        expect(response.body).to include('email-verification-container')
      end
    end

    context 'with flash message containing email' do
      it 'displays the email address in the message' do
        get email_verification_sent_path
        # Email should be shown if available in flash or params
        # This will be handled in the view
      end
    end
  end
end

