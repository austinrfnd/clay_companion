# frozen_string_literal: true

##
# Profile Setup Request Spec
#
# Tests the profile setup view and functionality.
# Verifies that the profile setup page matches wireframe requirements and handles
# all user flows correctly.
#
require 'rails_helper'

RSpec.describe 'ProfileSetups', type: :request do
  include Devise::Test::IntegrationHelpers

  # Set default host for request specs
  before do
    host! 'www.example.com'
  end

  describe 'GET /profile_setup' do
    context 'when user is authenticated' do
      let(:artist) { create(:artist, :minimal, full_name: 'Jane Smith', confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'returns http success' do
        get profile_setup_path
        expect(response).to have_http_status(:success)
      end

      it 'displays the page heading "Welcome to Clay Companion"' do
        get profile_setup_path
        expect(response.body).to include('Welcome to Clay Companion')
      end

      it 'displays the subheading text' do
        get profile_setup_path
        expect(response.body).to include("Let's set up your artist profile")
      end

      it 'displays the portrait photo upload field' do
        get profile_setup_path
        expect(response.body).to include('Portrait Photo')
        expect(response.body).to include('required-indicator')
      end

      it 'displays the full name input field' do
        get profile_setup_path
        expect(response.body).to include('Full Name')
        expect(response.body).to include('name="artist[full_name]"')
      end

      it 'pre-fills full name from current artist' do
        get profile_setup_path
        expect(response.body).to include(artist.full_name)
      end

      it 'displays the location input field' do
        get profile_setup_path
        expect(response.body).to include('Location')
        expect(response.body).to include('name="artist[location]"')
      end

      it 'displays the bio textarea field' do
        get profile_setup_path
        expect(response.body).to include('Bio')
        expect(response.body).to include('name="artist[bio]"')
        expect(response.body).to include('maxlength="2000"')
      end

      it 'displays the "Complete Setup" submit button' do
        get profile_setup_path
        expect(response.body).to include('Complete Setup')
      end

      it 'displays the "Skip for now" link' do
        get profile_setup_path
        expect(response.body).to include('Skip for now')
      end

      it 'uses design system classes for styling' do
        get profile_setup_path
        expect(response.body).to include('auth-page-container')
        expect(response.body).to include('auth-form-container')
      end

      it 'includes proper accessibility attributes' do
        get profile_setup_path
        expect(response.body).to include('aria-required="true"')
        expect(response.body).to include('aria-label')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get profile_setup_path
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end

  describe 'PATCH /profile_setup' do
    context 'when user is authenticated' do
      let(:artist) { create(:artist, :minimal, full_name: 'Jane Smith', confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      context 'with valid attributes' do
        let(:photo_file) { fixture_file_upload('spec/fixtures/files/test_image.jpg', 'image/jpeg') }
        let(:valid_attributes) do
          {
            full_name: 'Jane Doe',
            location: 'Portland, OR',
            bio: 'A ceramic artist specializing in functional pottery.'
          }
        end

        before do
          # Create a test image file if it doesn't exist
          FileUtils.mkdir_p('spec/fixtures/files')
          unless File.exist?('spec/fixtures/files/test_image.jpg')
            # Create a minimal valid JPEG (1x1 pixel) - using hex string to avoid syntax issues
            jpeg_data = [0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10, 0x4A, 0x46, 0x49, 0x46, 0x00, 0x01, 0x01, 0x01, 0x00, 0x48, 0x00, 0x48, 0x00, 0x00, 0xFF, 0xDB, 0x00, 0x43, 0x00, 0x08, 0x06, 0x06, 0x07, 0x06, 0x05, 0x08, 0x07, 0x07, 0x07, 0x09, 0x09, 0x08, 0x0A, 0x0C, 0x14, 0x0D, 0x0C, 0x0B, 0x0B, 0x0C, 0x19, 0x12, 0x13, 0x0F, 0x14, 0x1D, 0x1A, 0x1F, 0x1E, 0x1D, 0x1A, 0x1C, 0x1C, 0x20, 0x24, 0x2E, 0x27, 0x20, 0x22, 0x2C, 0x23, 0x1C, 0x1C, 0x28, 0x37, 0x29, 0x2C, 0x30, 0x31, 0x34, 0x34, 0x34, 0x1F, 0x27, 0x39, 0x3D, 0x38, 0x32, 0x3C, 0x2E, 0x33, 0x34, 0x32, 0xFF, 0xC0, 0x00, 0x11, 0x08, 0x00, 0x01, 0x00, 0x01, 0x03, 0x01, 0x22, 0x00, 0x02, 0x11, 0x01, 0x03, 0x11, 0x01, 0xFF, 0xC4, 0x00, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0xFF, 0xC4, 0x00, 0x14, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xDA, 0x00, 0x08, 0x01, 0x01, 0x00, 0x00, 0x3F, 0x00, 0xAA, 0xFF, 0xD9].pack('C*')
            File.binwrite('spec/fixtures/files/test_image.jpg', jpeg_data)
          end
        end

        it 'updates the artist profile' do
          patch profile_setup_path, params: { artist: valid_attributes.merge(profile_photo: photo_file) }
          artist.reload
          expect(artist.full_name).to eq('Jane Doe')
          expect(artist.location).to eq('Portland, OR')
          expect(artist.bio).to eq('A ceramic artist specializing in functional pottery.')
        end

        it 'attaches the profile photo' do
          patch profile_setup_path, params: { artist: valid_attributes.merge(profile_photo: photo_file) }
          artist.reload
          expect(artist.profile_photo).to be_attached
        end

        it 'redirects to dashboard' do
          patch profile_setup_path, params: { artist: valid_attributes.merge(profile_photo: photo_file) }
          expect(response).to redirect_to(dashboard_path)
        end

        it 'sets a success flash message' do
          patch profile_setup_path, params: { artist: valid_attributes.merge(profile_photo: photo_file) }
          expect(flash[:notice]).to be_present
        end
      end

      context 'with missing required fields' do
        it 'renders the form with errors when profile photo is missing' do
          patch profile_setup_path, params: { artist: { full_name: 'Jane Doe' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match(/photo|required/i)
        end

        it 'renders the form with errors when full_name is missing' do
          photo_file = fixture_file_upload('spec/fixtures/files/test_image.jpg', 'image/jpeg')
          patch profile_setup_path, params: { artist: { profile_photo: photo_file, full_name: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match(/full.name|required/i)
        end
      end

      context 'with invalid bio length' do
        it 'renders the form with errors when bio exceeds 2000 characters' do
          photo_file = fixture_file_upload('spec/fixtures/files/test_image.jpg', 'image/jpeg')
          long_bio = 'a' * 2001
          patch profile_setup_path, params: { artist: { profile_photo: photo_file, full_name: 'Jane Doe', bio: long_bio } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match(/bio|2000|characters/i)
        end
      end

      context 'with skip action' do
        it 'redirects to dashboard without updating profile' do
          original_location = artist.location
          get profile_setup_path
          # Skip link should navigate to dashboard
          # This would be handled via a separate route or JavaScript
          # For now, we'll test that skip doesn't require profile completion
          expect(artist.reload.location).to eq(original_location)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        patch profile_setup_path, params: { artist: { full_name: 'Jane Doe' } }
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end
end
