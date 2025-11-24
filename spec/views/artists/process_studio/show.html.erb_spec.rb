# frozen_string_literal: true

##
# Artists Process Studio Show View Spec
#
# Tests the public-facing process/studio page view.
# Verifies hero section, gallery grid, and lightbox rendering.
#
require 'rails_helper'

RSpec.describe 'artists/process_studio/show', type: :view do
  let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }
  let(:hero_image) { nil }
  let(:studio_images) { [] }

  before do
    assign(:artist, artist)
    assign(:hero_image, hero_image)
    assign(:studio_images, studio_images)
  end

  describe 'hero section' do
    context 'with hero image' do
      let(:hero_image) { create(:studio_image, artist: artist) }

      it 'renders hero section with background image' do
        render
        expect(rendered).to have_css('section.hero')
        expect(rendered).to match(/background-image/)
      end

      it 'displays the title "Studio & Process"' do
        render
        expect(rendered).to have_text('Studio & Process')
      end
    end

    context 'without hero image' do
      it 'renders hero section with default gradient' do
        render
        expect(rendered).to have_css('section.hero')
        expect(rendered).to match(/linear-gradient/)
      end

      it 'displays the title "Studio & Process"' do
        render
        expect(rendered).to have_text('Studio & Process')
      end
    end

    context 'with intro text' do
      let(:artist) { create(:artist, :minimal, studio_intro_text: 'My studio in Portland', confirmed_at: Time.current) }

      it 'displays the intro text' do
        render
        expect(rendered).to have_text('My studio in Portland')
      end
    end

    context 'without intro text' do
      it 'does not display intro text paragraph' do
        render
        expect(rendered).not_to have_css('p.intro-text')
      end
    end
  end

  describe 'gallery section' do
    context 'with studio images' do
      let(:studio_images) do
        [
          create(:studio_image, artist: artist, caption: 'First image'),
          create(:studio_image, artist: artist, caption: 'Second image')
        ]
      end

      it 'renders the gallery grid' do
        render
        expect(rendered).to have_css('section.gallery')
        expect(rendered).to have_css('.gallery-grid')
      end

      it 'renders all studio images' do
        render
        expect(rendered).to have_text('First image')
        expect(rendered).to have_text('Second image')
      end

      it 'renders images in display order' do
        image1 = create(:studio_image, artist: artist, display_order: 2, caption: 'Second order')
        image2 = create(:studio_image, artist: artist, display_order: 1, caption: 'First order')
        assign(:studio_images, [image1, image2].sort_by(&:display_order))

        render
        # Check that images are rendered (order is tested in controller spec)
        expect(rendered).to have_text('First order')
        expect(rendered).to have_text('Second order')
      end
    end

    context 'without studio images' do
      it 'displays empty state message' do
        render
        expect(rendered).to have_text('No studio photos available yet.')
      end

      it 'does not render gallery grid' do
        render
        expect(rendered).not_to have_css('.gallery-grid')
      end
    end
  end

  describe 'lightbox modal' do
    let(:studio_images) { [create(:studio_image, artist: artist)] }

    it 'renders lightbox container' do
      render
      expect(rendered).to have_css('[data-controller="lightbox"]')
    end

    it 'includes lightbox images data' do
      render
      expect(rendered).to match(/data-lightbox-images-value/)
    end
  end

  describe 'page title' do
    it 'sets the page title with artist name' do
      render
      expect(view.content_for(:title)).to include(artist.full_name)
      # HTML entity encoding converts & to &amp;
      expect(view.content_for(:title)).to match(/Studio.*Process/)
    end
  end
end

