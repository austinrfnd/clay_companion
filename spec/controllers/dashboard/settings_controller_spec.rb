# frozen_string_literal: true

##
# Dashboard Settings Controller Spec
#
# Tests the settings hub index page with authentication requirements.
#
require 'rails_helper'

RSpec.describe Dashboard::Settings::SettingsController, type: :controller do
  # Include Devise test helpers
  include Devise::Test::ControllerHelpers

  # Configure Devise scope for tests
  before do
    @request.env['devise.mapping'] = Devise.mappings[:artist]
  end

  describe 'GET #index' do
    context 'when artist is authenticated' do
      let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }

      before do
        sign_in artist
      end

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when artist is not authenticated' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_artist_session_path)
      end
    end
  end
end

