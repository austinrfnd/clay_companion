# frozen_string_literal: true

##
# Dashboard Settings Studio Controller Spec
#
# Tests studio settings functionality (hero image selection, intro text, studio images).
# Verifies authentication requirements and data loading.
#
require 'rails_helper'

RSpec.describe Dashboard::Settings::StudioController, type: :controller do
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

      it 'loads studio images for the artist' do
        # Create some studio images for the artist
        create_list(:studio_image, 3, artist: artist)
        
        get :show
        expect(assigns(:studio_images)).to be_present
        expect(assigns(:studio_images).count).to eq(3)
        expect(assigns(:studio_images).first).to be_a(StudioImage)
      end

      it 'loads studio images in display order' do
        # Create images with different display orders
        image1 = create(:studio_image, artist: artist, display_order: 2)
        image2 = create(:studio_image, artist: artist, display_order: 1)
        image3 = create(:studio_image, artist: artist, display_order: 3)
        
        get :show
        images = assigns(:studio_images)
        expect(images[0].id).to eq(image2.id)
        expect(images[1].id).to eq(image1.id)
        expect(images[2].id).to eq(image3.id)
      end

      context 'when artist has a hero image set' do
        let(:artist) { create(:artist, :minimal, :with_hero_image, confirmed_at: Time.current) }

        it 'assigns the hero image' do
          get :show
          expect(assigns(:hero_image)).to eq(artist.studio_hero_image)
        end
      end

      context 'when artist has no hero image' do
        it 'assigns nil for hero image' do
          get :show
          expect(assigns(:hero_image)).to be_nil
        end
      end
    end

    context 'when artist is not authenticated' do
      it 'redirects to login page' do
        get :show
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end
end

