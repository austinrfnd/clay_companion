# frozen_string_literal: true

##
# Dashboard Settings Routes Spec
#
# Tests dashboard settings routes for account, profile, and studio settings.
# Verifies that all settings routes are properly configured.
#
require 'rails_helper'

RSpec.describe 'Dashboard Settings Routes', type: :routing do
  describe 'Settings hub routes' do
    it 'routes GET /dashboard/settings to dashboard/settings/settings#index' do
      expect(get: '/dashboard/settings').to route_to('dashboard/settings/settings#index')
    end

    it 'provides dashboard_settings_root_path helper' do
      expect(dashboard_settings_root_path).to eq('/dashboard/settings')
    end
  end

  describe 'Account settings routes' do
    it 'routes GET /dashboard/settings/account to dashboard/settings/account#show' do
      expect(get: '/dashboard/settings/account').to route_to('dashboard/settings/account#show')
    end

    it 'routes PATCH /dashboard/settings/account to dashboard/settings/account#update' do
      expect(patch: '/dashboard/settings/account').to route_to('dashboard/settings/account#update')
    end

    it 'provides dashboard_settings_account_path helper' do
      expect(dashboard_settings_account_path).to eq('/dashboard/settings/account')
    end
  end

  describe 'Profile settings routes' do
    it 'routes GET /dashboard/settings/profile to dashboard/settings/profile#show' do
      expect(get: '/dashboard/settings/profile').to route_to('dashboard/settings/profile#show')
    end

    it 'routes PATCH /dashboard/settings/profile to dashboard/settings/profile#update' do
      expect(patch: '/dashboard/settings/profile').to route_to('dashboard/settings/profile#update')
    end

    it 'provides dashboard_settings_profile_path helper' do
      expect(dashboard_settings_profile_path).to eq('/dashboard/settings/profile')
    end
  end

  describe 'Studio settings routes' do
    it 'routes GET /dashboard/settings/studio to dashboard/settings/studio#show' do
      expect(get: '/dashboard/settings/studio').to route_to('dashboard/settings/studio#show')
    end

    it 'provides dashboard_settings_studio_path helper' do
      expect(dashboard_settings_studio_path).to eq('/dashboard/settings/studio')
    end
  end

  describe 'API studio routes' do
    let(:artist_id) { '123e4567-e89b-12d3-a456-426614174000' }

    describe 'Studio images routes' do
      it 'routes GET /api/artists/:artist_id/studio-images to api/studio_images#index' do
        expect(get: "/api/artists/#{artist_id}/studio-images").to route_to(
          controller: 'api/studio_images',
          action: 'index',
          artist_id: artist_id
        )
      end

      it 'routes GET /api/artists/:artist_id/studio-images/:id to api/studio_images#show' do
        image_id = '456e7890-e89b-12d3-a456-426614174001'
        expect(get: "/api/artists/#{artist_id}/studio-images/#{image_id}").to route_to(
          controller: 'api/studio_images',
          action: 'show',
          artist_id: artist_id,
          id: image_id
        )
      end

      it 'routes POST /api/artists/:artist_id/studio-images to api/studio_images#create' do
        expect(post: "/api/artists/#{artist_id}/studio-images").to route_to(
          controller: 'api/studio_images',
          action: 'create',
          artist_id: artist_id
        )
      end

      it 'routes PATCH /api/artists/:artist_id/studio-images/:id to api/studio_images#update' do
        image_id = '456e7890-e89b-12d3-a456-426614174001'
        expect(patch: "/api/artists/#{artist_id}/studio-images/#{image_id}").to route_to(
          controller: 'api/studio_images',
          action: 'update',
          artist_id: artist_id,
          id: image_id
        )
      end

      it 'routes DELETE /api/artists/:artist_id/studio-images/:id to api/studio_images#destroy' do
        image_id = '456e7890-e89b-12d3-a456-426614174001'
        expect(delete: "/api/artists/#{artist_id}/studio-images/#{image_id}").to route_to(
          controller: 'api/studio_images',
          action: 'destroy',
          artist_id: artist_id,
          id: image_id
        )
      end
    end

    describe 'Studio page routes' do
      it 'routes GET /api/artists/:artist_id/studio-page to api/studio_page#show' do
        expect(get: "/api/artists/#{artist_id}/studio-page").to route_to(
          controller: 'api/studio_page',
          action: 'show',
          artist_id: artist_id
        )
      end

      it 'routes PATCH /api/artists/:artist_id/studio-page to api/studio_page#update' do
        expect(patch: "/api/artists/#{artist_id}/studio-page").to route_to(
          controller: 'api/studio_page',
          action: 'update',
          artist_id: artist_id
        )
      end
    end
  end
end

