/**
 * Password Toggle Controller
 *
 * Toggles password visibility between password and text input types.
 * Updates button icon/text to reflect current state.
 * Maintains accessibility with proper ARIA attributes.
 *
 * Usage:
 *   <div data-controller="password-toggle">
 *     <input type="password" data-password-toggle-target="input" />
 *     <button type="button" data-action="click->password-toggle#toggle" data-password-toggle-target="button">
 *       <span data-password-toggle-target="icon">👁️</span>
 *     </button>
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "button", "icon"]

  /**
   * Toggles password visibility
   * Switches between password and text input types
   * Updates icon to reflect current state
   */
  toggle() {
    const input = this.inputTarget
    const icon = this.iconTarget

    if (input.type === "password") {
      input.type = "text"
      icon.textContent = "🙈"
      icon.setAttribute("aria-label", "Hide password")
    } else {
      input.type = "password"
      icon.textContent = "👁️"
      icon.setAttribute("aria-label", "Show password")
    }
  }
}


