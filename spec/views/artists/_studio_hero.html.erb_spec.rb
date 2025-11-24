# frozen_string_literal: true

##
# Studio Hero Partial View Spec
#
# Tests the hero section partial rendering.
# Verifies background image handling, title, and intro text display.
#
require 'rails_helper'

RSpec.describe 'artists/_studio_hero', type: :view do
  let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }
  let(:hero_image) { nil }

  before do
    render partial: 'artists/studio_hero', locals: { artist: artist, hero_image: hero_image }
  end

  describe 'background image' do
    context 'with hero image attached' do
      let(:hero_image) { create(:studio_image, artist: artist) }

      it 'renders hero section with background-image style' do
        expect(rendered).to have_css('section.hero[style*="background-image"]')
      end

      it 'includes background-size and background-position styles' do
        expect(rendered).to match(/background-size: cover/)
        expect(rendered).to match(/background-position: center/)
      end
    end

    context 'without hero image' do
      it 'renders hero section with gradient background' do
        expect(rendered).to have_css('section.hero[style*="linear-gradient"]')
      end
    end
  end

  describe 'hero content' do
    it 'displays the title "Studio & Process"' do
      expect(rendered).to have_css('h1', text: 'Studio & Process')
    end

    it 'renders the hero divider' do
      expect(rendered).to have_css('.hero-divider')
    end

    context 'with intro text' do
      let(:artist) { create(:artist, :minimal, studio_intro_text: 'Come behind the scenes', confirmed_at: Time.current) }

      it 'displays the intro text' do
        expect(rendered).to have_css('p.intro-text', text: 'Come behind the scenes')
      end
    end

    context 'without intro text' do
      let(:artist) { create(:artist, :minimal, studio_intro_text: nil, confirmed_at: Time.current) }

      it 'does not display intro text paragraph' do
        expect(rendered).not_to have_css('p.intro-text')
      end
    end
  end

  describe 'overlay elements' do
    it 'renders white overlay' do
      expect(rendered).to have_css('.absolute.inset-0.bg-white\\/85')
    end

    it 'renders decorative pattern overlay' do
      expect(rendered).to have_css('[style*="background: url"]')
    end
  end

  describe 'responsive classes' do
    it 'includes responsive min-height classes' do
      expect(rendered).to match(/min-h-\[300px\]/)
      expect(rendered).to match(/md:min-h-\[400px\]/)
      expect(rendered).to match(/lg:min-h-\[500px\]/)
    end

    it 'includes responsive padding classes' do
      expect(rendered).to match(/px-6/)
      expect(rendered).to match(/md:px-8/)
    end
  end
end

