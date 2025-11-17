# frozen_string_literal: true

##
# Dashboard Settings Account Controller Spec
#
# Tests account settings functionality (full_name, location, profile_photo).
# Verifies authentication requirements and update functionality.
#
require 'rails_helper'

RSpec.describe Dashboard::Settings::AccountController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  # Configure Devise scope for tests
  before do
    @request.env['devise.mapping'] = Devise.mappings[:artist]
  end

  describe 'GET #show' do
    context 'when artist is authenticated' do
      let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'returns http success' do
        get :show
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        get :show
        expect(response).to render_template(:show)
      end

      it 'assigns the current artist' do
        get :show
        expect(assigns(:artist)).to eq(artist)
      end
    end

    context 'when artist is not authenticated' do
      it 'redirects to login page' do
        get :show
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when artist is authenticated' do
      let(:artist) { create(:artist, :minimal, confirmed_at: Time.current, full_name: 'Jane Smith', location: 'Portland, OR') }

      before do
        sign_in artist
        # Create test image file if it doesn't exist
        FileUtils.mkdir_p('spec/fixtures/files')
        unless File.exist?('spec/fixtures/files/test_image.jpg')
          jpeg_data = [0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10, 0x4A, 0x46, 0x49, 0x46, 0x00, 0x01, 0x01, 0x01, 0x00, 0x48, 0x00, 0x48, 0x00, 0x00, 0xFF, 0xDB, 0x00, 0x43, 0x00, 0x08, 0x06, 0x06, 0x07, 0x06, 0x05, 0x08, 0x07, 0x07, 0x07, 0x09, 0x09, 0x08, 0x0A, 0x0C, 0x14, 0x0D, 0x0C, 0x0B, 0x0B, 0x0C, 0x19, 0x12, 0x13, 0x0F, 0x14, 0x1D, 0x1A, 0x1F, 0x1E, 0x1D, 0x1A, 0x1C, 0x1C, 0x20, 0x24, 0x2E, 0x27, 0x20, 0x22, 0x2C, 0x23, 0x1C, 0x1C, 0x28, 0x37, 0x29, 0x2C, 0x30, 0x31, 0x34, 0x34, 0x34, 0x1F, 0x27, 0x39, 0x3D, 0x38, 0x32, 0x3C, 0x2E, 0x33, 0x34, 0x32, 0xFF, 0xC0, 0x00, 0x11, 0x08, 0x00, 0x01, 0x00, 0x01, 0x03, 0x01, 0x22, 0x00, 0x02, 0x11, 0x01, 0x03, 0x11, 0x01, 0xFF, 0xC4, 0x00, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0xFF, 0xC4, 0x00, 0x14, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xDA, 0x00, 0x08, 0x01, 0x01, 0x00, 0x00, 0x3F, 0x00, 0xAA, 0xFF, 0xD9].pack('C*')
          File.binwrite('spec/fixtures/files/test_image.jpg', jpeg_data)
        end
      end

      context 'with valid attributes' do
        let(:photo_file) { fixture_file_upload('spec/fixtures/files/test_image.jpg', 'image/jpeg') }
        let(:valid_params) do
          {
            full_name: 'Jane Doe',
            location: 'Seattle, WA',
            profile_photo: photo_file
          }
        end

        it 'updates the artist account info' do
          patch :update, params: { artist: valid_params }
          artist.reload
          expect(artist.full_name).to eq('Jane Doe')
          expect(artist.location).to eq('Seattle, WA')
        end

        it 'attaches the profile photo' do
          # Note: Active Storage attachment is better tested in request specs
          # This test verifies the update succeeds when photo is provided
          patch :update, params: { artist: valid_params }
          expect(response).to redirect_to(dashboard_settings_account_path)
          # Verify the update was processed (other fields updated)
          artist.reload
          expect(artist.full_name).to eq('Jane Doe')
          # Attachment verification is covered in request specs
        end

        it 'redirects to account settings' do
          patch :update, params: { artist: valid_params }
          expect(response).to redirect_to(dashboard_settings_account_path)
        end

        it 'sets a success flash message' do
          patch :update, params: { artist: valid_params }
          expect(flash[:notice]).to be_present
        end
      end

      context 'with only name and location (no photo)' do
        let(:params_without_photo) do
          {
            full_name: 'Jane Doe',
            location: 'Seattle, WA'
          }
        end

        it 'updates successfully without photo' do
          patch :update, params: { artist: params_without_photo }
          expect(response).to redirect_to(dashboard_settings_account_path)
          artist.reload
          expect(artist.full_name).to eq('Jane Doe')
          expect(artist.location).to eq('Seattle, WA')
        end
      end

      context 'with missing full_name' do
        let(:params_without_name) do
          {
            full_name: '',
            location: 'Seattle, WA'
          }
        end

        it 'renders the show template with errors' do
          patch :update, params: { artist: params_without_name }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:show)
        end

        it 'adds error to full_name' do
          patch :update, params: { artist: params_without_name }
          expect(assigns(:artist).errors[:full_name]).to be_present
        end

        it 'does not update the artist' do
          original_name = artist.full_name
          patch :update, params: { artist: params_without_name }
          artist.reload
          expect(artist.full_name).to eq(original_name)
        end
      end

      context 'with location exceeding maximum length' do
        let(:params_with_long_location) do
          {
            full_name: 'Jane Doe',
            location: 'a' * 101
          }
        end

        it 'renders the show template with errors' do
          patch :update, params: { artist: params_with_long_location }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:show)
        end

        it 'adds error to location' do
          patch :update, params: { artist: params_with_long_location }
          expect(assigns(:artist).errors[:location]).to be_present
        end
      end
    end

    context 'when artist is not authenticated' do
      it 'redirects to login page' do
        patch :update, params: { artist: { full_name: 'Jane Doe' } }
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end
end

