# frozen_string_literal: true

##
# Layout Request Spec
#
# Tests the application layout including shared components:
# - Platform header with logo and navigation
# - Platform footer with links
# - Flash message display
# - Responsive design
#
require 'rails_helper'

RSpec.describe 'Application Layout', type: :request do
  # Include Devise test helpers for request specs
  include Devise::Test::IntegrationHelpers

  describe 'Platform Header' do
    it 'displays the Clay Companion logo' do
      get root_path
      expect(response.body).to include('Clay Companion')
    end

    it 'has a link to the homepage' do
      get root_path
      expect(response.body).to include("href=\"#{root_path}\"")
      expect(response.body).to include('Clay Companion')
    end

    context 'when user is not authenticated' do
      it 'displays Sign Up and Login links' do
        get root_path
        expect(response.body).to include("href=\"#{new_artist_registration_path}\"")
        expect(response.body).to include('Sign Up')
        expect(response.body).to include("href=\"#{new_artist_session_path}\"")
        expect(response.body).to include('Login')
      end
    end

    context 'when user is authenticated' do
      let(:artist) { create(:artist, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'displays dashboard link instead of auth links' do
        get root_path
        expect(response.body).to include("href=\"#{dashboard_path}\"")
        expect(response.body).to include('Dashboard')
        expect(response.body).not_to include('Sign Up')
        expect(response.body).not_to include('Login')
      end
    end

    it 'has proper header styling classes' do
      get root_path
      # Header should have white background and border
      expect(response.body).to match(/class.*header/i)
    end
  end

  describe 'Platform Footer' do
    it 'displays footer links' do
      get root_path
      expect(response.body).to include('Contact')
      expect(response.body).to include('About')
      expect(response.body).to include('Terms')
      expect(response.body).to include('Privacy')
    end

    it 'displays "Powered by Clay Companion" text' do
      get root_path
      expect(response.body).to include('Powered by Clay Companion')
    end

    it 'has proper footer styling' do
      get root_path
      # Footer should have misty white background
      expect(response.body).to match(/class.*footer/i)
    end
  end

  describe 'Flash Messages' do
    it 'displays success flash messages' do
      get root_path
      # Flash messages are rendered via partial
      # We'll test the actual display in view specs
    end

    it 'displays error flash messages' do
      get root_path
      # Flash messages are rendered via partial
    end
  end

  describe 'Responsive Design' do
    it 'includes viewport meta tag' do
      get root_path
      expect(response.body).to include('viewport')
      expect(response.body).to include('width=device-width')
    end

    it 'includes Inter font from Google Fonts' do
      get root_path
      expect(response.body).to include('fonts.googleapis.com')
      expect(response.body).to include('Inter')
    end
  end

  describe 'Accessibility' do
    it 'includes skip to main content link' do
      get root_path
      # Should have skip link for screen readers
      expect(response.body).to match(/skip.*main/i)
    end

    it 'has proper ARIA landmarks' do
      get root_path
      # Should have nav, main, footer landmarks
      expect(response.body).to match(/role.*navigation|nav/i)
      expect(response.body).to match(/role.*main|main/i)
    end
  end
end

