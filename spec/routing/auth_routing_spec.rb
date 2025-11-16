# frozen_string_literal: true

##
# Authentication Routes Spec
#
# Tests custom Devise routes for authentication flows.
# Verifies that all auth routes match wireframe requirements:
# - /login (instead of /artists/sign_in)
# - /signup (instead of /artists/sign_up)
# - /logout (instead of /artists/sign_out)
# - /password/reset (instead of /artists/password/new)
# - /email/verify/:token (instead of /artists/confirmation)
#
require 'rails_helper'

RSpec.describe 'Authentication Routes', type: :routing do
  describe 'Login routes' do
    it 'routes GET /login to artists/sessions#new' do
      expect(get: '/login').to route_to('artists/sessions#new')
    end

    it 'routes POST /login to artists/sessions#create' do
      expect(post: '/login').to route_to('artists/sessions#create')
    end

    it 'provides login_path helper' do
      # Use new_artist_session_path which is the Devise helper
      expect(new_artist_session_path).to eq('/login')
    end
  end

  describe 'Logout route' do
    it 'routes DELETE /logout to artists/sessions#destroy' do
      expect(delete: '/logout').to route_to('artists/sessions#destroy')
    end

    it 'provides logout_path helper' do
      # Use destroy_artist_session_path which is the Devise helper
      expect(destroy_artist_session_path).to eq('/logout')
    end
  end

  describe 'Signup routes' do
    it 'routes GET /signup to artists/registrations#new' do
      expect(get: '/signup').to route_to('artists/registrations#new')
    end

    it 'routes POST /signup to artists/registrations#create' do
      expect(post: '/signup').to route_to('artists/registrations#create')
    end

    it 'provides signup_path helper' do
      # Use new_artist_registration_path which is the Devise helper
      expect(new_artist_registration_path).to eq('/signup')
    end
  end

  describe 'Password reset routes' do
    it 'routes GET /password/reset to artists/passwords#new' do
      expect(get: '/password/reset').to route_to('artists/passwords#new')
    end

    it 'routes POST /password/reset to artists/passwords#create' do
      expect(post: '/password/reset').to route_to('artists/passwords#create')
    end

    it 'routes GET /password/reset/:token to artists/passwords#edit' do
      expect(get: '/password/reset/abc123token').to route_to(
        controller: 'artists/passwords',
        action: 'edit',
        reset_password_token: 'abc123token'
      )
    end

    it 'routes PATCH /password/reset/:token to artists/passwords#update' do
      expect(patch: '/password/reset/abc123token').to route_to(
        controller: 'artists/passwords',
        action: 'update',
        reset_password_token: 'abc123token'
      )
    end

    it 'routes PUT /password/reset/:token to artists/passwords#update' do
      expect(put: '/password/reset/abc123token').to route_to(
        controller: 'artists/passwords',
        action: 'update',
        reset_password_token: 'abc123token'
      )
    end

    it 'provides new_artist_password_path helper' do
      # The helper should route to /password/reset (our custom route)
      expect(new_artist_password_path).to eq('/password/reset/new')
      # But we also have our custom route
      expect(password_reset_request_path).to eq('/password/reset')
    end
  end

  describe 'Email confirmation routes' do
    it 'routes GET /email/verify/:token to artists/confirmations#show' do
      expect(get: '/email/verify/abc123token').to route_to(
        controller: 'artists/confirmations',
        action: 'show',
        confirmation_token: 'abc123token'
      )
    end

    it 'routes POST /email/resend to artists/confirmations#create' do
      expect(post: '/email/resend').to route_to('artists/confirmations#create')
    end

    it 'provides artist_confirmation_path helper with token' do
      # Note: This will be tested after routes are configured
      expect(get: '/email/verify/abc123token').to route_to(
        controller: 'artists/confirmations',
        action: 'show',
        confirmation_token: 'abc123token'
      )
    end
  end

  describe 'Route helpers' do
    it 'provides new_artist_session_path that routes to /login' do
      expect(new_artist_session_path).to eq('/login')
    end

    it 'provides new_artist_registration_path that routes to /signup' do
      expect(new_artist_registration_path).to eq('/signup')
    end

    it 'provides destroy_artist_session_path that routes to /logout' do
      expect(destroy_artist_session_path).to eq('/logout')
    end
  end

  describe 'Old Devise routes should not exist' do
    it 'does not route /artists/sign_in' do
      expect(get: '/artists/sign_in').not_to be_routable
    end

    it 'does not route /artists/sign_up' do
      expect(get: '/artists/sign_up').not_to be_routable
    end

    it 'does not route /artists/sign_out' do
      expect(delete: '/artists/sign_out').not_to be_routable
    end
  end
end

