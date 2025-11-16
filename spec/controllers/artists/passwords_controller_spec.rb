# frozen_string_literal: true

##
# Artists Passwords Controller Spec
#
# Tests password reset functionality with custom redirects.
# Verifies redirects match wireframe requirements:
# - After password reset request → success message
# - After password reset → login page
#
require 'rails_helper'

RSpec.describe Artists::PasswordsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  # Configure Devise scope for tests
  before do
    @request.env['devise.mapping'] = Devise.mappings[:artist]
  end

  describe 'GET #new' do
    it 'renders the password reset request page' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid email' do
      let!(:artist) { create(:artist, email: 'test@example.com', full_name: 'Test Artist') }

      it 'sends reset password email' do
        expect {
          post :create, params: { artist: { email: 'test@example.com' } }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to password reset request confirmation' do
        post :create, params: { artist: { email: 'test@example.com' } }
        expect(response).to redirect_to(password_reset_request_path)
      end

      it 'sets a success flash message' do
        post :create, params: { artist: { email: 'test@example.com' } }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to include('email')
      end
    end

    context 'with invalid email' do
      it 'does not send reset password email' do
        expect {
          post :create, params: { artist: { email: 'nonexistent@example.com' } }
        }.not_to change { ActionMailer::Base.deliveries.count }
      end

      it 'still redirects (security: don\'t reveal if email exists)' do
        post :create, params: { artist: { email: 'nonexistent@example.com' } }
        expect(response).to redirect_to(password_reset_request_path)
      end

      it 'sets a success flash message (security: don\'t reveal if email exists)' do
        post :create, params: { artist: { email: 'nonexistent@example.com' } }
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid token' do
      let(:artist) { create(:artist, email: 'test@example.com') }
      let(:token) { artist.send_reset_password_instructions }

      it 'renders the password reset form' do
        get :edit, params: { reset_password_token: token }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context 'with invalid token' do
      it 'renders the password reset form with error' do
        get :edit, params: { reset_password_token: 'invalid_token' }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context 'with expired token' do
      let(:artist) { create(:artist, email: 'test@example.com') }

      before do
        artist.send_reset_password_instructions
        artist.update(reset_password_sent_at: 7.hours.ago)
      end

      it 'renders the password reset form with error' do
        get :edit, params: { reset_password_token: artist.reset_password_token }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid token and password' do
      let(:artist) { create(:artist, email: 'test@example.com', password: 'OldPassword123!', password_confirmation: 'OldPassword123!', full_name: 'Test Artist') }
      let(:token) do
        # send_reset_password_instructions returns the raw token (not hashed)
        # This is what Devise expects in reset_password_by_token
        artist.send_reset_password_instructions
      end

      it 'updates the password' do
        # In controller specs, path params go in params hash
        # Token should be in both path params and artist params (as form does)
        patch :update, params: {
          reset_password_token: token,
          artist: {
            reset_password_token: token,
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
        # Check if update was successful (redirect indicates success)
        expect(response).to have_http_status(:redirect)
        artist.reload
        expect(artist.valid_password?('NewPassword123!')).to be true
      end

      it 'redirects to login page' do
        patch :update, params: {
          reset_password_token: token,
          artist: {
            reset_password_token: token,
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
        expect(response).to redirect_to(new_artist_session_path)
      end

      it 'sets a success flash message' do
        patch :update, params: {
          reset_password_token: token,
          artist: {
            reset_password_token: token,
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/password|reset|changed/i)
      end
    end

    context 'with invalid token' do
      let!(:artist) { create(:artist, email: 'test@example.com', password: 'OldPassword123!', password_confirmation: 'OldPassword123!', full_name: 'Test Artist') }
      
      it 'does not update the password' do
        original_encrypted = artist.encrypted_password

        patch :update, params: {
          reset_password_token: 'invalid_token',
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(original_encrypted)
      end

      it 'renders the edit form with errors' do
        patch :update, params: {
          reset_password_token: 'invalid_token',
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'NewPassword123!'
          }
        }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with password too short' do
      let(:artist) { create(:artist, email: 'test@example.com') }
      let(:token) { artist.send_reset_password_instructions }

      it 'does not update the password' do
        original_encrypted = artist.encrypted_password
        patch :update, params: {
          reset_password_token: token,
          artist: {
            password: 'Short1!',
            password_confirmation: 'Short1!'
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(original_encrypted)
      end

      it 'renders the edit form with errors' do
        patch :update, params: {
          reset_password_token: token,
          artist: {
            password: 'Short1!',
            password_confirmation: 'Short1!'
          }
        }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with password confirmation mismatch' do
      let(:artist) { create(:artist, email: 'test@example.com') }
      let(:token) { artist.send_reset_password_instructions }

      it 'does not update the password' do
        original_encrypted = artist.encrypted_password
        patch :update, params: {
          reset_password_token: token,
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'Different123!'
          }
        }
        artist.reload
        expect(artist.encrypted_password).to eq(original_encrypted)
      end

      it 'renders the edit form with errors' do
        patch :update, params: {
          reset_password_token: token,
          artist: {
            password: 'NewPassword123!',
            password_confirmation: 'Different123!'
          }
        }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

