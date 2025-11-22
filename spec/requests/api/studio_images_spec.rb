# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::StudioImages', type: :request do
  ##
  # Test Overview
  # This spec tests the API endpoints for studio images management.
  # Covers:
  # - GET /api/artists/:artist_id/studio-images (public list)
  # - GET /api/artists/:artist_id/studio-images/:id (public show)
  # - POST /api/artists/:artist_id/studio-images (create - authenticated)
  # - PATCH /api/artists/:artist_id/studio-images/:id (update - authenticated)
  # - DELETE /api/artists/:artist_id/studio-images/:id (destroy - authenticated)
  # - Authorization checks
  # - Validation error handling
  ##

  let(:artist) { create(:artist) }
  let(:other_artist) { create(:artist) }
  let(:studio_image) { create(:studio_image, artist: artist) }

  describe 'GET /api/artists/:artist_id/studio-images' do
    context 'with studio images' do
      before { create_list(:studio_image, 3, artist: artist) }

      it 'returns all studio images for an artist' do
        get "/api/artists/#{artist.id}/studio-images"

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['images'].count).to eq(3)
      end

      it 'returns images with correct structure' do
        get "/api/artists/#{artist.id}/studio-images"

        body = JSON.parse(response.body)
        image = body['images'].first

        expect(image).to have_key('id')
        expect(image).to have_key('caption')
        expect(image).to have_key('category')
        expect(image).to have_key('display_order')
        expect(image).to have_key('image_url')
      end

      it 'returns correct total count' do
        get "/api/artists/#{artist.id}/studio-images"

        body = JSON.parse(response.body)
        expect(body['total']).to eq(3)
      end

      it 'returns images in display order' do
        image1 = create(:studio_image, artist: artist, display_order: 2)
        image2 = create(:studio_image, artist: artist, display_order: 1)
        image3 = create(:studio_image, artist: artist, display_order: 3)

        get "/api/artists/#{artist.id}/studio-images"

        body = JSON.parse(response.body)
        ids = body['images'].map { |img| img['id'] }

        expect(ids).to eq([image2.id, image1.id, image3.id])
      end
    end

    context 'without studio images' do
      it 'returns empty array' do
        get "/api/artists/#{artist.id}/studio-images"

        body = JSON.parse(response.body)
        expect(body['images']).to eq([])
        expect(body['total']).to eq(0)
      end
    end
  end

  describe 'GET /api/artists/:artist_id/studio-images/:id' do
    it 'returns a single studio image' do
      get "/api/artists/#{artist.id}/studio-images/#{studio_image.id}"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      expect(body['id']).to eq(studio_image.id)
      expect(body['caption']).to eq(studio_image.caption)
      expect(body['category']).to eq(studio_image.category)
    end

    it 'returns not found for non-existent image' do
      fake_id = SecureRandom.uuid

      get "/api/artists/#{artist.id}/studio-images/#{fake_id}"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/artists/:artist_id/studio-images' do
    let(:image_params) do
      {
        studio_image: {
          caption: 'My new studio photo',
          category: 'studio',
          alt_text: 'A photo of my ceramic studio'
        }
      }
    end

    context 'when authenticated as the artist' do
      before do
        sign_in artist
      end

      it 'creates a new studio image' do
        expect {
          post "/api/artists/#{artist.id}/studio-images", params: image_params
        }.to change { StudioImage.count }.by(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns created image with correct data' do
        post "/api/artists/#{artist.id}/studio-images", params: image_params

        body = JSON.parse(response.body)
        expect(body['caption']).to eq('My new studio photo')
        expect(body['category']).to eq('studio')
        expect(body['message']).to eq('Image uploaded successfully')
      end

      it 'assigns correct display_order' do
        existing_image = create(:studio_image, artist: artist, display_order: 5)

        post "/api/artists/#{artist.id}/studio-images", params: image_params

        body = JSON.parse(response.body)
        expect(body['display_order']).to eq(6)
      end

      it 'rejects invalid category' do
        invalid_params = image_params.deep_merge(
          studio_image: { category: 'invalid' }
        )

        post "/api/artists/#{artist.id}/studio-images", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors']).to be_present
      end

      it 'rejects caption exceeding max length' do
        long_caption_params = image_params.deep_merge(
          studio_image: { caption: 'A' * 151 }
        )

        post "/api/artists/#{artist.id}/studio-images", params: long_caption_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        post "/api/artists/#{artist.id}/studio-images", params: image_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /api/artists/:artist_id/studio-images/:id' do
    let(:update_params) do
      {
        studio_image: {
          caption: 'Updated caption',
          category: 'process',
          display_order: 10
        }
      }
    end

    context 'when authenticated as the artist' do
      before { sign_in artist }

      it 'updates the studio image' do
        patch "/api/artists/#{artist.id}/studio-images/#{studio_image.id}", params: update_params

        expect(response).to have_http_status(:ok)
        studio_image.reload

        expect(studio_image.caption).to eq('Updated caption')
        expect(studio_image.category).to eq('process')
        expect(studio_image.display_order).to eq(10)
      end

      it 'returns updated image data' do
        patch "/api/artists/#{artist.id}/studio-images/#{studio_image.id}", params: update_params

        body = JSON.parse(response.body)
        expect(body['caption']).to eq('Updated caption')
        expect(body['category']).to eq('process')
        expect(body['message']).to eq('Image updated successfully')
      end

      it 'validates category on update' do
        invalid_update = {
          studio_image: { category: 'invalid' }
        }

        patch "/api/artists/#{artist.id}/studio-images/#{studio_image.id}", params: invalid_update

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when authenticated as a different artist' do
      before { sign_in other_artist }

      it 'returns not found' do
        patch "/api/artists/#{artist.id}/studio-images/#{studio_image.id}", params: update_params

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        patch "/api/artists/#{artist.id}/studio-images/#{studio_image.id}", params: update_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/artists/:artist_id/studio-images/:id' do
    context 'when authenticated as the artist' do
      before { sign_in artist }

      it 'deletes the studio image' do
        image = create(:studio_image, artist: artist)

        expect {
          delete "/api/artists/#{artist.id}/studio-images/#{image.id}"
        }.to change { StudioImage.count }.by(-1)

        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        delete "/api/artists/#{artist.id}/studio-images/#{studio_image.id}"

        body = JSON.parse(response.body)
        expect(body['message']).to eq('Image deleted successfully')
      end

      context 'when image is set as hero image' do
        before do
          artist.update(studio_hero_image_id: studio_image.id)
        end

        it 'clears hero image reference' do
          delete "/api/artists/#{artist.id}/studio-images/#{studio_image.id}"

          artist.reload
          expect(artist.studio_hero_image_id).to be_nil
        end
      end
    end

    context 'when authenticated as a different artist' do
      before { sign_in other_artist }

      it 'returns not found' do
        delete "/api/artists/#{artist.id}/studio-images/#{studio_image.id}"

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        delete "/api/artists/#{artist.id}/studio-images/#{studio_image.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
