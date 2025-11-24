# frozen_string_literal: true

##
# Studio Image Card Partial View Spec
#
# Tests the image card partial rendering.
# Verifies thumbnail, category badge, caption, and grid positioning.
#
require 'rails_helper'

RSpec.describe 'artists/_studio_image_card', type: :view do
  let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }
  let(:image) { create(:studio_image, artist: artist, category: 'studio', caption: 'Test caption') }
  let(:index) { 0 }

  before do
    render partial: 'artists/studio_image_card', locals: { image: image, index: index }
  end

  describe 'image rendering' do
    context 'with attached image' do
      it 'renders the image tag' do
        expect(rendered).to have_css('img')
      end

      it 'includes alt text from caption or alt_text' do
        expect(rendered).to have_css('img[alt*="Test caption"]')
      end
    end

    context 'without attached image' do
      let(:image) { create(:studio_image, :minimal, artist: artist) }

      it 'renders placeholder with SVG icon' do
        expect(rendered).to have_css('svg')
        expect(rendered).to have_text('Studio Photo')
      end
    end
  end

  describe 'category badge' do
    context 'with studio category' do
      let(:image) { create(:studio_image, artist: artist, category: 'studio') }

      it 'displays "Studio" badge' do
        expect(rendered).to have_css('.image-badge', text: 'Studio')
      end

      it 'applies studio badge styling' do
        expect(rendered).to have_css('.image-badge.text-celadon-dark')
      end
    end

    context 'with process category' do
      let(:image) { create(:studio_image, artist: artist, category: 'process') }

      it 'displays "Process" badge' do
        expect(rendered).to have_css('.image-badge', text: 'Process')
      end

      it 'applies process badge styling' do
        expect(rendered).to have_css('.image-badge.text-celadon')
      end
    end

    context 'with other category' do
      let(:image) { create(:studio_image, artist: artist, category: 'other') }

      it 'displays "Other" badge' do
        expect(rendered).to have_css('.image-badge', text: 'Other')
      end

      it 'applies other badge styling' do
        expect(rendered).to have_css('.image-badge.text-slate')
      end
    end
  end

  describe 'caption' do
    context 'with caption' do
      it 'displays the caption' do
        expect(rendered).to have_css('p.image-caption', text: 'Test caption')
      end
    end

    context 'without caption' do
      let(:image) { create(:studio_image, artist: artist, caption: nil) }

      it 'does not display caption paragraph' do
        expect(rendered).not_to have_css('p.image-caption')
      end
    end
  end

  describe 'grid positioning' do
    context 'first three images (index 0-2)' do
      let(:index) { 1 }

      it 'applies 4-column span for desktop' do
        expect(rendered).to match(/md:col-span-4/)
      end

      it 'applies single column for mobile' do
        expect(rendered).to match(/col-span-1/)
      end
    end

    context 'fourth image (index 3)' do
      let(:index) { 3 }

      it 'applies 6-column span with row-span for desktop' do
        expect(rendered).to match(/md:col-span-6/)
        expect(rendered).to match(/md:row-span-2/)
      end
    end

    context 'fifth and sixth images (index 4-5)' do
      let(:index) { 4 }

      it 'applies 6-column span for desktop' do
        expect(rendered).to match(/md:col-span-6/)
      end
    end

    context 'seventh image and beyond (index 6+)' do
      let(:index) { 7 }

      it 'applies 4-column span for desktop' do
        expect(rendered).to match(/md:col-span-4/)
      end
    end
  end

  describe 'lightbox integration' do
    it 'includes lightbox data attributes' do
      expect(rendered).to have_css('[data-lightbox-target="item"]')
      expect(rendered).to match(/data-image-id/)
      expect(rendered).to match(/data-image-url/)
      expect(rendered).to match(/data-image-caption/)
    end

    it 'includes click action for lightbox' do
      expect(rendered).to match(/data-action.*lightbox#openImage/)
    end
  end

  describe 'hover effects' do
    it 'includes hover transform classes' do
      expect(rendered).to match(/hover:-translate-y-2/)
      expect(rendered).to match(/hover:shadow-xl/)
    end
  end
end

