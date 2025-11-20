# frozen_string_literal: true

##
# Dashboard Settings Profile Controller Spec
#
# Tests profile settings functionality (bio, artist_statement, education, awards, social links, contact info).
# Verifies authentication requirements and update functionality with JSON fields.
#
require 'rails_helper'

RSpec.describe Dashboard::Settings::ProfileController, type: :controller do
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
      let(:artist) { create(:artist, :minimal, confirmed_at: Time.current, bio: 'Original bio', artist_statement: 'Original statement') }

      before do
        sign_in artist
      end

      context 'with valid attributes' do
        let(:valid_params) do
          {
            bio: 'Updated biography text',
            artist_statement: 'Updated artist statement',
            contact_email: 'contact@example.com',
            contact_phone: '+1-503-555-1234',
            website_url: 'https://example.com',
            instagram_url: 'https://instagram.com/artist',
            facebook_url: 'https://facebook.com/artist',
            education: [
              { institution: 'RISD', degree: 'MFA Ceramics', year: '2015' }
            ],
            awards: [
              { title: 'Award Title', organization: 'Organization Name', year: '2020' }
            ],
            other_links: [
              { label: 'Etsy', url: 'https://etsy.com/shop/artist' }
            ]
          }
        end

        it 'updates the artist profile' do
          patch :update, params: { artist: valid_params }
          artist.reload
          expect(artist.bio).to eq('Updated biography text')
          expect(artist.artist_statement).to eq('Updated artist statement')
          expect(artist.contact_email).to eq('contact@example.com')
        end

        it 'updates education JSON field' do
          patch :update, params: { artist: valid_params }
          artist.reload
          expect(artist.education).to be_an(Array)
          expect(artist.education.first['institution']).to eq('RISD')
        end

        it 'updates awards JSON field' do
          patch :update, params: { artist: valid_params }
          artist.reload
          expect(artist.awards).to be_an(Array)
          expect(artist.awards.first['title']).to eq('Award Title')
        end

        it 'updates other_links JSON field' do
          patch :update, params: { artist: valid_params }
          artist.reload
          expect(artist.other_links).to be_an(Array)
          expect(artist.other_links.first['label']).to eq('Etsy')
        end

        it 'redirects to profile settings' do
          patch :update, params: { artist: valid_params }
          expect(response).to redirect_to(dashboard_settings_profile_path)
        end

        it 'sets a success flash message' do
          patch :update, params: { artist: valid_params }
          expect(flash[:notice]).to be_present
        end
      end

      context 'with bio exceeding maximum length' do
        let(:params_with_long_bio) do
          {
            bio: 'a' * 2001,
            artist_statement: 'Valid statement'
          }
        end

        it 'renders the show template with errors' do
          patch :update, params: { artist: params_with_long_bio }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:show)
        end

        it 'adds error to bio' do
          patch :update, params: { artist: params_with_long_bio }
          expect(assigns(:artist).errors[:bio]).to be_present
        end
      end

      context 'with invalid URL format' do
        let(:params_with_invalid_url) do
          {
            bio: 'Valid bio',
            website_url: 'not-a-valid-url'
          }
        end

        it 'renders the show template with errors' do
          patch :update, params: { artist: params_with_invalid_url }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:show)
        end

        it 'adds error to website_url' do
          patch :update, params: { artist: params_with_invalid_url }
          expect(assigns(:artist).errors[:website_url]).to be_present
        end
      end

      context 'with empty education array' do
        let(:params_with_empty_education) do
          {
            bio: 'Valid bio',
            education: []
          }
        end

        it 'updates successfully' do
          patch :update, params: { artist: params_with_empty_education }
          expect(response).to redirect_to(dashboard_settings_profile_path)
          artist.reload
          expect(artist.education).to eq([])
        end
      end

      context 'with partial profile data' do
        let(:params_minimal) do
          {
            bio: 'Just a bio',
            artist_statement: nil,
            contact_email: nil
          }
        end

        it 'updates successfully with only provided fields' do
          patch :update, params: { artist: params_minimal }
          expect(response).to redirect_to(dashboard_settings_profile_path)
          artist.reload
          expect(artist.bio).to eq('Just a bio')
          # artist_statement may be empty string if blank param is sent
          expect(artist.artist_statement).to be_blank
        end
      end
    end

    context 'when artist is not authenticated' do
      it 'redirects to login page' do
        patch :update, params: { artist: { bio: 'New bio' } }
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end
end

