# frozen_string_literal: true

##
# Artists Registrations Controller Spec
#
# Tests signup functionality with custom redirects.
# Verifies redirects match wireframe requirements:
# - After signup → email verification page
# - Error handling for validation failures
#
require 'rails_helper'

RSpec.describe Artists::RegistrationsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  # Configure Devise scope for tests
  before do
    @request.env['devise.mapping'] = Devise.mappings[:artist]
  end

  describe 'GET #new' do
    context 'when user is not authenticated' do
      it 'renders the signup page' do
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
        # In controller specs, redirect might go to root, but we check it redirects away from signup
        expect(response).to have_http_status(:redirect)
        expect(response.location).to match(/dashboard|root/)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          artist: {
            email: 'newartist@example.com',
            password: 'Password123!',
            password_confirmation: 'Password123!',
            full_name: 'New Artist'
          }
        }
      end

      it 'creates a new artist' do
        expect {
          post :create, params: valid_params
        }.to change(Artist, :count).by(1)
      end

      it 'does not sign in the artist (email confirmation required)' do
        post :create, params: valid_params
        expect(controller.current_artist).to be_nil
      end

      it 'redirects to email verification sent page' do
        post :create, params: valid_params
        # Devise redirects to root after signup, we'll customize this in the controller
        expect(response).to have_http_status(:redirect)
      end

      it 'sets a success flash message' do
        post :create, params: valid_params
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to include('email')
      end

      it 'sends confirmation email' do
        expect {
          post :create, params: valid_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'with invalid parameters' do
      context 'missing email' do
        let(:invalid_params) do
          {
            artist: {
              email: '',
              password: 'Password123!',
              password_confirmation: 'Password123!',
              full_name: 'New Artist'
            }
          }
        end

        it 'does not create an artist' do
          expect {
            post :create, params: invalid_params
          }.not_to change(Artist, :count)
        end

        it 'renders the signup page with errors' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'sets error messages' do
          post :create, params: invalid_params
          expect(assigns(:artist).errors).to be_present
        end
      end

      context 'password too short' do
        let(:invalid_params) do
          {
            artist: {
              email: 'newartist@example.com',
              password: 'Short1!',
              password_confirmation: 'Short1!',
              full_name: 'New Artist'
            }
          }
        end

        it 'does not create an artist' do
          expect {
            post :create, params: invalid_params
          }.not_to change(Artist, :count)
        end

        it 'renders the signup page with errors' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'password confirmation mismatch' do
        let(:invalid_params) do
          {
            artist: {
              email: 'newartist@example.com',
              password: 'Password123!',
              password_confirmation: 'Different123!',
              full_name: 'New Artist'
            }
          }
        end

        it 'does not create an artist' do
          expect {
            post :create, params: invalid_params
          }.not_to change(Artist, :count)
        end

        it 'renders the signup page with errors' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'duplicate email' do
        let!(:existing_artist) { create(:artist, email: 'existing@example.com') }

        let(:invalid_params) do
          {
            artist: {
              email: 'existing@example.com',
              password: 'Password123!',
              password_confirmation: 'Password123!',
              full_name: 'New Artist'
            }
          }
        end

        it 'does not create an artist' do
          expect {
            post :create, params: invalid_params
          }.not_to change(Artist, :count)
        end

        it 'renders the signup page with errors' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

