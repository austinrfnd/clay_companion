# frozen_string_literal: true

##
# Artists Sessions Controller Spec
#
# Tests login and logout functionality with custom redirects.
# Verifies redirects match wireframe requirements:
# - After login → profile setup (if incomplete) or dashboard
# - After logout → login page
#
require 'rails_helper'

RSpec.describe Artists::SessionsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  # Configure Devise scope for tests
  before do
    @request.env['devise.mapping'] = Devise.mappings[:artist]
  end

  describe 'GET #new' do
    context 'when user is not authenticated' do
      it 'renders the login page' do
        get :new
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    context 'when user is already authenticated' do
      let(:artist) { create(:artist, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'redirects to dashboard' do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe 'POST #create' do
    let(:artist) { create(:artist, email: 'test@example.com', password: 'Password123!', confirmed_at: Time.current) }

    context 'with valid credentials' do
      context 'when profile is complete' do
        before do
          artist.update(full_name: 'Test Artist', location: 'Portland, OR')
        end

        it 'signs in the artist' do
          post :create, params: { artist: { email: 'test@example.com', password: 'Password123!' } }
          expect(controller.current_artist).to eq(artist)
        end

        it 'redirects to dashboard' do
          post :create, params: { artist: { email: 'test@example.com', password: 'Password123!' } }
          expect(response).to redirect_to(dashboard_path)
        end

        it 'sets a success flash message' do
          post :create, params: { artist: { email: 'test@example.com', password: 'Password123!' } }
          expect(flash[:notice]).to be_present
        end
      end

      context 'when profile is incomplete' do
        before do
          # Profile is incomplete if full_name is blank (but model validation prevents nil)
          # So we'll test with an empty string after bypassing validation
          artist.update_column(:full_name, '')
        end

        it 'signs in the artist' do
          post :create, params: { artist: { email: 'test@example.com', password: 'Password123!' } }
          expect(controller.current_artist).to eq(artist)
        end

        it 'redirects to profile setup' do
          post :create, params: { artist: { email: 'test@example.com', password: 'Password123!' } }
          expect(response).to redirect_to(profile_setup_path)
        end
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the artist' do
        post :create, params: { artist: { email: 'test@example.com', password: 'WrongPassword!' } }
        expect(controller.current_artist).to be_nil
      end

      it 'renders the login page with error' do
        post :create, params: { artist: { email: 'test@example.com', password: 'WrongPassword!' } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'sets an error flash message' do
        post :create, params: { artist: { email: 'test@example.com', password: 'WrongPassword!' } }
        expect(flash[:alert]).to be_present
      end
    end

    context 'with unconfirmed email' do
      let(:unconfirmed_artist) { create(:artist, email: 'unconfirmed@example.com', password: 'Password123!', confirmed_at: nil) }

      it 'does not sign in the artist' do
        post :create, params: { artist: { email: 'unconfirmed@example.com', password: 'Password123!' } }
        expect(controller.current_artist).to be_nil
      end

      it 'renders the login page with error' do
        post :create, params: { artist: { email: 'unconfirmed@example.com', password: 'Password123!' } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'sets an error flash message about unconfirmed email' do
        post :create, params: { artist: { email: 'unconfirmed@example.com', password: 'Password123!' } }
        expect(flash[:alert]).to be_present
        # Devise's default message is "Invalid Email or password." for security
        # We'll customize this in the controller if needed
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:artist) { create(:artist, confirmed_at: Time.current) }

    before do
      sign_in artist
    end

    it 'signs out the artist' do
      delete :destroy
      expect(controller.current_artist).to be_nil
    end

    it 'redirects to login page' do
      delete :destroy
      expect(response).to redirect_to(new_artist_session_path)
    end

    it 'sets a success flash message' do
      delete :destroy
      expect(flash[:notice]).to be_present
    end
  end
end

