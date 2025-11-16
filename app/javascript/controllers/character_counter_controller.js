/**
 * Character Counter Controller
 * 
 * Handles real-time character counting for textarea fields.
 * Updates character count display as user types.
 * 
 * Targets:
 * - textarea: The textarea element to count
 * - counter: The character counter display element
 * - count: The count number element (optional, if counter contains count separately)
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "counter", "count"]
  static values = { maxLength: Number }

  connect() {
    // Initialize count on connect
    this.updateCount()
  }

  /**
   * Update character count
   * Called on input event
   */
  updateCount() {
    const text = this.textareaTarget.value || ''
    const length = text.length
    const maxLength = this.textareaTarget.maxLength || this.maxLengthValue || 2000

    // Update count display
    if (this.hasCountTarget) {
      // If separate count target exists, update it
      this.countTarget.textContent = length
    } else {
      // Otherwise update the counter target directly
      this.counterTarget.textContent = `${length} / ${maxLength} characters`
    }

    // Add error class if over limit
    if (length > maxLength) {
      this.counterTarget.classList.add('error')
    } else {
      this.counterTarget.classList.remove('error')
    }
  }
}

