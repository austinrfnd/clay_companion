/**
 * Auto Save Controller
 *
 * Handles auto-saving form fields to the API when user blurs or changes the field.
 * Supports both studio page fields (intro_text) and studio image fields (caption, category).
 * Shows visual feedback during save operations.
 *
 * Usage:
 *   <input
 *     data-controller="auto-save"
 *     data-auto-save-artist-id-value="<%= @artist.id %>"
 *     data-auto-save-field-value="studio_intro_text"
 *     data-action="blur->auto-save#save"
 *   />
 *
 *   <input
 *     data-controller="auto-save"
 *     data-auto-save-artist-id-value="<%= @artist.id %>"
 *     data-auto-save-image-id-value="<%= image.id %>"
 *     data-auto-save-field-value="caption"
 *     data-action="blur->auto-save#save"
 *   />
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["charCount"]
  static values = {
    artistId: String,
    imageId: String,
    field: String
  }

  /**
   * Saves the field value to the API
   * Called on blur (for text inputs) or change (for selects)
   */
  async save() {
    const field = this.fieldValue
    const value = this.element.value

    // Update character counter if it exists (for caption fields)
    this.updateCharacterCounter(value)

    // Determine which endpoint to use
    if (this.hasImageIdValue) {
      // Updating a studio image field (caption, category)
      await this.updateStudioImage(field, value)
    } else {
      // Updating studio page field (studio_intro_text)
      await this.updateStudioPage(field, value)
    }
  }

  /**
   * Updates character counter display if target exists
   * Called on input for real-time updates
   */
  updateCounter() {
    const value = this.element.value || ''
    this.updateCharacterCounter(value)
  }

  /**
   * Updates character counter display if target exists
   * @param {string} value - Current field value
   */
  updateCharacterCounter(value) {
    if (this.hasCharCountTarget) {
      this.charCountTarget.textContent = value.length || 0
    }
  }

  /**
   * Updates a studio image field via API
   * @param {string} field - Field name (caption, category)
   * @param {string} value - Field value
   */
  async updateStudioImage(field, value) {
    const artistId = this.artistIdValue
    const imageId = this.imageIdValue
    const url = `/api/artists/${artistId}/studio-images/${imageId}`

    const body = {
      studio_image: {
        [field]: value
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
        throw new Error(error.errors?.join(', ') || 'Failed to update field')
      }

      // Show success feedback (subtle - could use a checkmark icon)
      this.showSuccessFeedback()
    } catch (error) {
      console.error('Error auto-saving field:', error)
      this.showErrorFeedback()
    }
  }

  /**
   * Updates studio page field via API
   * @param {string} field - Field name (studio_intro_text)
   * @param {string} value - Field value
   */
  async updateStudioPage(field, value) {
    const artistId = this.artistIdValue
    const url = `/api/artists/${artistId}/studio-page`

    // Map field name if needed (studio_intro_text vs intro_text)
    const apiField = field === 'studio_intro_text' ? 'intro_text' : field

    const body = {
      studio_page: {
        [apiField]: value
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
        throw new Error(error.errors?.join(', ') || 'Failed to update field')
      }

      // Show success feedback
      this.showSuccessFeedback()
    } catch (error) {
      console.error('Error auto-saving field:', error)
      this.showErrorFeedback()
    }
  }

  /**
   * Shows subtle success feedback
   * Adds a temporary visual indicator that save was successful
   */
  showSuccessFeedback() {
    // Add a subtle success class (could be styled with CSS)
    this.element.classList.add('border-green-500')
    this.element.classList.remove('border-error')

    // Remove success class after a short delay
    setTimeout(() => {
      this.element.classList.remove('border-green-500')
    }, 1000)
  }

  /**
   * Shows error feedback
   * Adds error styling to indicate save failed
   */
  showErrorFeedback() {
    this.element.classList.add('border-error')
    
    // Remove error class after a delay
    setTimeout(() => {
      this.element.classList.remove('border-error')
    }, 3000)
  }
}

