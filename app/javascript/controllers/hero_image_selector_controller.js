/**
 * Hero Image Selector Controller
 *
 * Handles hero image selection for studio settings page.
 * Updates hero image via API when radio button is selected.
 * Clears hero image when "use default background" checkbox is checked.
 *
 * Usage:
 *   <input
 *     type="radio"
 *     data-controller="hero-image-selector"
 *     data-action="change->hero-image-selector#select"
 *     data-hero-image-selector-artist-id-value="<%= @artist.id %>"
 *     data-hero-image-selector-image-id-value="<%= image.id %>"
 *   />
 *
 *   <input
 *     type="checkbox"
 *     data-controller="hero-image-selector"
 *     data-action="change->hero-image-selector#clear"
 *     data-hero-image-selector-artist-id-value="<%= @artist.id %>"
 *   />
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    artistId: String,
    imageId: String
  }

  /**
   * Selects an image as the hero image
   * Called when a radio button is selected
   */
  select(event) {
    if (!event.target.checked) return

    const artistId = this.artistIdValue
    const imageId = this.imageIdValue

    // Uncheck the "use default background" checkbox
    const defaultBackgroundCheckbox = document.getElementById('use_default_background')
    if (defaultBackgroundCheckbox) {
      defaultBackgroundCheckbox.checked = false
    }

    this.updateHeroImage(artistId, imageId)
  }

  /**
   * Clears the hero image (uses default background)
   * Called when "use default background" checkbox is checked
   */
  clear(event) {
    if (!event.target.checked) return

    const artistId = this.artistIdValue

    // Uncheck all radio buttons
    document.querySelectorAll('input[type="radio"][name="studio_hero_image_id"]').forEach(radio => {
      radio.checked = false
    })

    this.updateHeroImage(artistId, null)
  }

  /**
   * Updates hero image via API
   * @param {string} artistId - Artist UUID
   * @param {string|null} imageId - StudioImage UUID or null to clear
   */
  async updateHeroImage(artistId, imageId) {
    const url = `/api/artists/${artistId}/studio-page`
    const body = {
      studio_page: {
        hero_image_id: imageId
      }
    }

    try {
      const response = await fetch(url, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify(body)
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.errors?.join(', ') || 'Failed to update hero image')
      }

      const data = await response.json()
      
      // Update preview if hero image URL changed
      this.updatePreview(data.background_image_url)

      // Show success feedback (optional - could use flash message)
      console.log('Hero image updated successfully')
    } catch (error) {
      console.error('Error updating hero image:', error)
      alert('Failed to update hero image. Please try again.')
    }
  }

  /**
   * Updates the hero image preview
   * @param {string|null} imageUrl - URL of the hero image or null
   */
  updatePreview(imageUrl) {
    const previewContainer = document.querySelector('[data-hero-preview]')
    if (!previewContainer) return

    const previewImg = previewContainer.querySelector('img')
    
    if (imageUrl) {
      if (previewImg) {
        previewImg.src = imageUrl
        previewImg.style.display = 'block'
      } else {
        // Create img element if it doesn't exist
        const img = document.createElement('img')
        img.src = imageUrl
        img.alt = 'Hero image preview'
        img.className = 'w-full h-full object-cover'
        previewContainer.innerHTML = ''
        previewContainer.appendChild(img)
      }
      // Hide empty state message
      const emptyState = previewContainer.querySelector('div')
      if (emptyState && emptyState.textContent.includes('No hero image')) {
        emptyState.style.display = 'none'
      }
    } else {
      // Show empty state
      previewContainer.innerHTML = `
        <div class="text-center text-slate">
          <p class="text-sm">No hero image selected</p>
          <p class="text-xs mt-1">Default gradient background will be used</p>
        </div>
      `
    }
  }
}

