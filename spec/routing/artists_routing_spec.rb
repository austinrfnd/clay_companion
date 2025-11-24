# frozen_string_literal: true

##
# Artists Public Routes Spec
#
# Tests public-facing artist portfolio routes.
#
require 'rails_helper'

RSpec.describe 'Artists Public Routes', type: :routing do
  describe 'Process/Studio routes' do
    it 'routes GET /artists/:name/process to artists/process_studio#show' do
      expect(get: '/artists/some-artist-id/process').to route_to(
        controller: 'artists/process_studio',
        action: 'show',
        name: 'some-artist-id'
      )
    end

    it 'provides artist_process_studio_path helper' do
      expect(artist_process_studio_path('some-artist-id')).to eq('/artists/some-artist-id/process')
    end
  end
end

