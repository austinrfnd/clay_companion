/**
 * Flash Message Controller
 *
 * Handles dismissal of flash messages when the close button is clicked.
 * Provides smooth fade-out animation and removes the message from the DOM.
 * Supports both mouse clicks and keyboard navigation (Escape key).
 *
 * Usage:
 *   <div data-controller="flash">
 *     <button data-action="click->flash#dismiss keydown->flash#handleKeydown">×</button>
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  /**
   * Dismisses the flash message
   * Fades out the message and removes it from the DOM
   */
  dismiss() {
    this.element.style.transition = "opacity 200ms ease"
    this.element.style.opacity = "0"
    
    setTimeout(() => {
      this.element.remove()
    }, 200)
  }

  /**
   * Handles keyboard events for accessibility
   * Dismisses the message when Escape key is pressed
   *
   * @param {KeyboardEvent} event - The keyboard event
   */
  handleKeydown(event) {
    if (event.key === 'Escape') {
      this.dismiss()
    }
  }
}

