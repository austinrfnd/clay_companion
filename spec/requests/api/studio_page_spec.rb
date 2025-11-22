# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::StudioPage', type: :request do
  ##
  # Test Overview
  # This spec tests the API endpoints for studio page (hero section) data management.
  # Covers:
  # - GET /api/artists/:artist_id/studio-page (public - fetch hero data)
  # - PATCH /api/artists/:artist_id/studio-page (authenticated - update hero data)
  # - Validation and authorization
  ##

  let(:artist) { create(:artist) }
  let(:other_artist) { create(:artist) }

  describe 'GET /api/artists/:artist_id/studio-page' do
    context 'with studio intro text' do
      before do
        artist.update(studio_intro_text: 'Come behind the scenes and see my work.')
      end

      it 'returns studio page hero data' do
        get "/api/artists/#{artist.id}/studio-page"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        expect(body).to have_key('hero')
        expect(body['hero']).to have_key('intro_text')
        expect(body['hero']).to have_key('title')
      end

      it 'returns correct intro text' do
        get "/api/artists/#{artist.id}/studio-page"

        body = JSON.parse(response.body)
        expect(body['hero']['intro_text']).to eq('Come behind the scenes and see my work.')
      end

      it 'returns title' do
        get "/api/artists/#{artist.id}/studio-page"

        body = JSON.parse(response.body)
        expect(body['hero']['title']).to eq('Studio & Process')
      end
    end

    context 'with hero image selected' do
      before do
        hero_image = create(:studio_image, artist: artist)
        artist.update(studio_hero_image_id: hero_image.id)
      end

      it 'returns background image URL' do
        get "/api/artists/#{artist.id}/studio-page"

        body = JSON.parse(response.body)
        expect(body['hero']).to have_key('background_image_url')
        expect(body['hero']['background_image_url']).to be_present
      end
    end

    context 'without hero image' do
      it 'returns nil for background_image_url' do
        artist.update(studio_hero_image_id: nil)

        get "/api/artists/#{artist.id}/studio-page"

        body = JSON.parse(response.body)
        expect(body['hero']['background_image_url']).to be_nil
      end
    end

    context 'without studio intro text' do
      it 'returns nil for intro_text' do
        artist.update(studio_intro_text: nil)

        get "/api/artists/#{artist.id}/studio-page"

        body = JSON.parse(response.body)
        expect(body['hero']['intro_text']).to be_nil
      end
    end
  end

  describe 'PATCH /api/artists/:artist_id/studio-page' do
    let(:update_params) do
      {
        studio_page: {
          studio_intro_text: 'Updated studio intro text here.'
        }
      }
    end

    context 'when authenticated as the artist' do
      before { sign_in artist }

      it 'updates studio intro text' do
        patch "/api/artists/#{artist.id}/studio-page", params: update_params

        expect(response).to have_http_status(:ok)
        artist.reload

        expect(artist.studio_intro_text).to eq('Updated studio intro text here.')
      end

      it 'returns updated studio page data' do
        patch "/api/artists/#{artist.id}/studio-page", params: update_params

        body = JSON.parse(response.body)
        expect(body['studio_intro_text']).to eq('Updated studio intro text here.')
        expect(body['message']).to eq('Studio page updated successfully')
      end

      it 'validates intro text length' do
        long_text = 'A' * 601
        invalid_params = {
          studio_page: { studio_intro_text: long_text }
        }

        patch "/api/artists/#{artist.id}/studio-page", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors']).to be_present
      end

      context 'when updating hero image' do
        let(:studio_image) { create(:studio_image, artist: artist) }

        it 'updates hero image reference' do
          hero_params = {
            studio_page: {
              studio_hero_image_id: studio_image.id
            }
          }

          patch "/api/artists/#{artist.id}/studio-page", params: hero_params

          expect(response).to have_http_status(:ok)
          artist.reload

          expect(artist.studio_hero_image_id).to eq(studio_image.id)
        end

        it 'returns new background image URL' do
          hero_params = {
            studio_page: {
              studio_hero_image_id: studio_image.id
            }
          }

          patch "/api/artists/#{artist.id}/studio-page", params: hero_params

          body = JSON.parse(response.body)
          expect(body['background_image_url']).to be_present
        end

        it 'rejects hero image from different artist' do
          other_image = create(:studio_image, artist: other_artist)
          invalid_params = {
            studio_page: {
              studio_hero_image_id: other_image.id
            }
          }

          patch "/api/artists/#{artist.id}/studio-page", params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['errors']).to include('Hero image does not belong to this artist')
        end
      end

      context 'when clearing hero image' do
        before do
          hero_image = create(:studio_image, artist: artist)
          artist.update(studio_hero_image_id: hero_image.id)
        end

        it 'allows setting hero image to nil' do
          clear_params = {
            studio_page: {
              studio_hero_image_id: nil
            }
          }

          patch "/api/artists/#{artist.id}/studio-page", params: clear_params

          artist.reload
          expect(artist.studio_hero_image_id).to be_nil
        end
      end

      context 'when updating both intro text and hero image' do
        let(:studio_image) { create(:studio_image, artist: artist) }

        it 'updates both fields' do
          both_params = {
            studio_page: {
              studio_intro_text: 'New intro',
              studio_hero_image_id: studio_image.id
            }
          }

          patch "/api/artists/#{artist.id}/studio-page", params: both_params

          artist.reload
          expect(artist.studio_intro_text).to eq('New intro')
          expect(artist.studio_hero_image_id).to eq(studio_image.id)
        end
      end
    end

    context 'when authenticated as a different artist' do
      before { sign_in other_artist }

      it 'does not update the artist\'s studio page' do
        original_text = artist.studio_intro_text

        patch "/api/artists/#{artist.id}/studio-page", params: update_params

        artist.reload
        expect(artist.studio_intro_text).to eq(original_text)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        patch "/api/artists/#{artist.id}/studio-page", params: update_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
