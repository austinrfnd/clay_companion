# frozen_string_literal: true

##
# Artists Process Studio Controller Spec
#
# Tests the public-facing process/studio page controller.
# Verifies artist lookup, studio images loading, and 404 handling.
#
require 'rails_helper'

RSpec.describe Artists::ProcessStudioController, type: :controller do
  describe 'GET #show' do
    context 'with valid artist' do
      let(:artist) { create(:artist, :minimal, full_name: 'Jane Doe', confirmed_at: Time.current) }
      let(:artist_slug) { artist.id.to_s } # Using ID for now, can switch to slug later

      before do
        # Create some studio images for the artist
        create_list(:studio_image, 3, artist: artist)
      end

      it 'returns http success' do
        get :show, params: { name: artist_slug }
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        get :show, params: { name: artist_slug }
        expect(response).to render_template(:show)
      end

      it 'loads the artist' do
        get :show, params: { name: artist_slug }
        expect(assigns(:artist)).to eq(artist)
      end

      it 'loads studio images for the artist' do
        get :show, params: { name: artist_slug }
        expect(assigns(:studio_images)).to be_present
        expect(assigns(:studio_images).count).to eq(3)
        expect(assigns(:studio_images).first).to be_a(StudioImage)
      end

      it 'loads studio images in display order' do
        # Use a fresh artist for this test to avoid interference from before block
        fresh_artist = create(:artist, :minimal, confirmed_at: Time.current)
        fresh_slug = fresh_artist.id.to_s
        
        # Create images with different display orders
        image1 = create(:studio_image, artist: fresh_artist, display_order: 2)
        image2 = create(:studio_image, artist: fresh_artist, display_order: 1)
        image3 = create(:studio_image, artist: fresh_artist, display_order: 3)
        
        get :show, params: { name: fresh_slug }
        images = assigns(:studio_images)
        expect(images[0].id).to eq(image2.id)
        expect(images[1].id).to eq(image1.id)
        expect(images[2].id).to eq(image3.id)
      end

      context 'when artist has a hero image set' do
        let(:artist) { create(:artist, :minimal, :with_hero_image, confirmed_at: Time.current) }

        it 'loads the hero image' do
          get :show, params: { name: artist_slug }
          expect(assigns(:hero_image)).to eq(artist.studio_hero_image)
        end
      end

      context 'when artist has no hero image' do
        it 'assigns nil for hero image' do
          get :show, params: { name: artist_slug }
          expect(assigns(:hero_image)).to be_nil
        end
      end
    end

    context 'with invalid artist' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :show, params: { name: 'non-existent-artist-id' }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

