# frozen_string_literal: true

##
# Artists Process Studio System Spec
#
# End-to-end integration tests for public-facing process/studio page.
# Tests page display, lightbox navigation, and responsive layouts.
#
require 'rails_helper'

RSpec.describe 'Artists Process Studio Page', type: :system do
  let(:artist) { create(:artist, :minimal, confirmed_at: Time.current) }
  let(:artist_id) { artist.id.to_s }

  before do
    Capybara.app_host = 'http://www.example.com'
    Capybara.default_host = 'http://www.example.com'
  end

  describe 'Public Page Display' do
    context 'with studio images' do
      let!(:image1) { create(:studio_image, artist: artist, caption: 'Studio workspace', category: 'studio') }
      let!(:image2) { create(:studio_image, artist: artist, caption: 'Throwing on wheel', category: 'process') }

      before do
        visit artist_process_studio_path(artist_id)
      end

      it 'displays the hero section' do
        expect(page).to have_content('Studio & Process')
        expect(page).to have_css('section.hero')
      end

      it 'displays the gallery grid' do
        expect(page).to have_css('.gallery-grid')
      end

      it 'displays all studio images' do
        expect(page).to have_content('Studio workspace')
        expect(page).to have_content('Throwing on wheel')
      end

      it 'displays category badges' do
        expect(page).to have_content('Studio')
        expect(page).to have_content('Process')
      end
    end

    context 'without studio images' do
      before do
        visit artist_process_studio_path(artist_id)
      end

      it 'displays empty state message' do
        expect(page).to have_content('No studio photos available yet')
      end
    end

    context 'with hero image' do
      let!(:hero_image) { create(:studio_image, artist: artist) }

      before do
        artist.update(studio_hero_image_id: hero_image.id)
        visit artist_process_studio_path(artist_id)
      end

      it 'displays hero section with background image' do
        expect(page).to have_css('section.hero[style*="background-image"]')
      end
    end

    context 'with intro text' do
      let(:artist) { create(:artist, :minimal, studio_intro_text: 'My studio in Portland', confirmed_at: Time.current) }

      before do
        visit artist_process_studio_path(artist_id)
      end

      it 'displays the intro text' do
        expect(page).to have_content('My studio in Portland')
      end
    end
  end

  describe 'Lightbox Navigation', js: true do
    let!(:image1) { create(:studio_image, artist: artist, caption: 'First image') }
    let!(:image2) { create(:studio_image, artist: artist, caption: 'Second image') }
    let!(:image3) { create(:studio_image, artist: artist, caption: 'Third image') }

    before do
      visit artist_process_studio_path(artist_id)
    end

    it 'opens lightbox when clicking an image' do
      # Click first image card
      first_image_card = page.find('[data-lightbox-target="item"]', match: :first)
      first_image_card.click

      # Verify lightbox is visible (Capybara waits automatically)
      expect(page).to have_css('.lightbox.flex', visible: true)
    end

    it 'displays image caption in lightbox' do
      first_image_card = page.find('[data-lightbox-target="item"]', match: :first)
      first_image_card.click

      # Capybara waits automatically for content
      expect(page).to have_content('First image')
    end

    it 'navigates to next image with next button' do
      first_image_card = page.find('[data-lightbox-target="item"]', match: :first)
      first_image_card.click

      # Click next button
      next_button = page.find('.lightbox-next')
      next_button.click

      # Verify second image caption is displayed (Capybara waits automatically)
      expect(page).to have_content('Second image')
    end

    it 'navigates to previous image with previous button' do
      # Click second image to start
      image_cards = page.all('[data-lightbox-target="item"]')
      image_cards[1].click

      # Click previous button
      prev_button = page.find('.lightbox-prev')
      prev_button.click

      # Verify first image caption is displayed (Capybara waits automatically)
      expect(page).to have_content('First image')
    end

    it 'closes lightbox with close button' do
      first_image_card = page.find('[data-lightbox-target="item"]', match: :first)
      first_image_card.click

      # Click close button
      close_button = page.find('.lightbox-close')
      close_button.click

      # Verify lightbox is hidden (Capybara waits automatically)
      expect(page).not_to have_css('.lightbox.flex', visible: true)
    end

    it 'closes lightbox with ESC key' do
      first_image_card = page.find('[data-lightbox-target="item"]', match: :first)
      first_image_card.click

      # Press ESC key
      page.send_keys(:escape)

      # Verify lightbox is hidden (Capybara waits automatically)
      expect(page).not_to have_css('.lightbox.flex', visible: true)
    end
  end

  describe 'Responsive Layout' do
    let!(:images) { create_list(:studio_image, 5, artist: artist) }

    before do
      visit artist_process_studio_path(artist_id)
    end

    context 'mobile viewport (320px)' do
      before do
        page.driver.browser.manage.window.resize_to(320, 568) if page.driver.browser.respond_to?(:manage)
      end

      it 'displays single column layout' do
        expect(page).to have_css('.grid-cols-1')
      end
    end

    context 'tablet viewport (768px)' do
      before do
        page.driver.browser.manage.window.resize_to(768, 1024) if page.driver.browser.respond_to?(:manage)
      end

      it 'displays 8-column grid layout' do
        expect(page).to have_css('.md\\:grid-cols-8')
      end
    end

    context 'desktop viewport (1400px)' do
      before do
        page.driver.browser.manage.window.resize_to(1400, 900) if page.driver.browser.respond_to?(:manage)
      end

      it 'displays 12-column grid layout' do
        expect(page).to have_css('.lg\\:grid-cols-12')
      end
    end
  end
end

