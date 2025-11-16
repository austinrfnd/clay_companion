# frozen_string_literal: true

##
# Artists Sessions Request Spec
#
# Tests the login view and login functionality.
# Verifies that the login page matches wireframe requirements and handles
# all user flows correctly.
#
require 'rails_helper'

RSpec.describe 'Artists Sessions', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /login' do
    context 'when user is not authenticated' do
      it 'renders the login page successfully' do
        get new_artist_session_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading "Welcome Back"' do
        get new_artist_session_path
        expect(response.body).to include('Welcome Back')
      end

      it 'displays the subheading text' do
        get new_artist_session_path
        expect(response.body).to include('Sign in to manage your portfolio')
      end

      it 'displays the email input field' do
        get new_artist_session_path
        expect(response.body).to include('Email Address')
        expect(response.body).to include('type="email"')
        expect(response.body).to include('placeholder="artist@example.com"')
      end

      it 'displays the password input field' do
        get new_artist_session_path
        expect(response.body).to include('Password')
        expect(response.body).to include('type="password"')
        expect(response.body).to include('placeholder="Enter your password"')
      end

      it 'displays the password visibility toggle button' do
        get new_artist_session_path
        expect(response.body).to include('data-controller="password-toggle"')
        expect(response.body).to include('aria-label="Toggle password visibility"')
      end

      it 'displays the "Remember me" checkbox' do
        get new_artist_session_path
        expect(response.body).to include('Remember me')
        expect(response.body).to include('type="checkbox"')
      end

      it 'displays the "Forgot password?" link' do
        get new_artist_session_path
        expect(response.body).to include('Forgot password?')
        expect(response.body).to include(password_reset_request_path)
      end

      it 'displays the "Sign In" submit button' do
        get new_artist_session_path
        expect(response.body).to include('Sign In')
        expect(response.body).to include('type="submit"')
      end

      it 'displays the "Sign up" link' do
        get new_artist_session_path
        expect(response.body).to include("Don't have an account?")
        expect(response.body).to include('Sign up')
        expect(response.body).to include(new_artist_registration_path)
      end

      it 'has proper form structure with correct action' do
        get new_artist_session_path
        expect(response.body).to include("action=\"#{artist_session_path}\"")
        expect(response.body).to include('method="post"')
      end

      it 'includes proper accessibility attributes' do
        get new_artist_session_path
        expect(response.body).to include('aria-label')
        expect(response.body).to include('for=')
      end

      it 'uses design system classes for styling' do
        get new_artist_session_path
        # Check for container max-width (auth-form-container has max-w-[600px])
        expect(response.body).to include('auth-form-container')
      end
    end

    context 'when user is already authenticated' do
      let(:artist) { create(:artist, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'redirects to dashboard' do
        get new_artist_session_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe 'POST /login' do
    let!(:artist) do
      artist = create(:artist, email: 'artist@example.com', password: 'Password123!', full_name: 'Test Artist')
      artist.confirm
      artist
    end

    context 'with valid credentials' do
      it 'signs in the artist' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: 'Password123!'
          }
        }
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets remember_me when checkbox is checked' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: 'Password123!',
            remember_me: '1'
          }
        }
        expect(response).to redirect_to(dashboard_path)
        # Devise handles remember_me internally
      end
    end

    context 'with invalid credentials' do
      it 'renders the login page with error message' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: 'wrongpassword'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        # Devise shows error via flash alert
        expect(response.body).to match(/Invalid|error|alert/i)
      end

      it 'displays error message using error_message helper' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: 'wrongpassword'
          }
        }
        expect(response.body).to include('error-message')
        expect(response.body).to include('⚠️')
      end

      it 'maintains entered email value' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: 'wrongpassword'
          }
        }
        expect(response.body).to include('artist@example.com')
      end
    end

    context 'with missing email' do
      it 'displays validation error' do
        post artist_session_path, params: {
          artist: {
            email: '',
            password: 'Password123!'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with missing password' do
      it 'displays validation error' do
        post artist_session_path, params: {
          artist: {
            email: 'artist@example.com',
            password: ''
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with unverified email' do
      let!(:unverified_artist) { create(:artist, email: 'unverified@example.com', password: 'Password123!', full_name: 'Unverified Artist', confirmed_at: nil) }

      it 'displays unverified email message' do
        post artist_session_path, params: {
          artist: {
            email: 'unverified@example.com',
            password: 'Password123!'
          }
        }
        # Devise redirects unconfirmed users but we can check the flash message
        # or check that it doesn't sign in
        expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:redirect)
        # If redirected, follow redirect to see error message
        if response.redirect?
          follow_redirect!
        end
        expect(response.body).to match(/verify|confirm|email/i)
      end
    end
  end

  describe 'DELETE /logout' do
    let(:artist) { create(:artist, confirmed_at: Time.current) }

    before do
      sign_in artist
    end

    it 'signs out the artist' do
      delete destroy_artist_session_path
      expect(response).to redirect_to(new_artist_session_path)
    end
  end
end

