/**
 * Password Strength Controller
 *
 * Calculates and displays real-time password strength based on requirements.
 * Updates strength indicator visual and requirements checklist as user types.
 *
 * Password Requirements:
 * - 8-30 characters
 * - Uppercase and lowercase letters
 * - At least one number
 * - At least one special character
 *
 * Usage:
 *   <div data-controller="password-strength">
 *     <input type="password" data-password-strength-target="input" />
 *     <div data-password-strength-target="strengthBar"></div>
 *     <div data-password-strength-target="strengthText"></div>
 *     <ul data-password-strength-target="requirements"></ul>
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "strengthBar", "strengthText", "strengthLevel", "requirements"]

  connect() {
    // Initialize on connect - always update to show initial state
    this.updateStrength()
  }

  /**
   * Updates password strength as user types
   * Called on input event
   */
  updateStrength() {
    const password = this.inputTarget.value
    const requirements = this.checkRequirements(password)
    const strength = this.calculateStrength(requirements)

    this.updateStrengthBar(strength, requirements.metCount)
    this.updateStrengthText(strength)
    this.updateRequirementsList(requirements)
  }

  /**
   * Checks which password requirements are met
   * @param {string} password - The password to check
   * @returns {Object} Requirements status object
   */
  checkRequirements(password) {
    const hasLength = password.length >= 8 && password.length <= 30
    const hasUppercase = /[A-Z]/.test(password)
    const hasLowercase = /[a-z]/.test(password)
    const hasNumber = /[0-9]/.test(password)
    const hasSpecial = /[^A-Za-z0-9]/.test(password)

    const metCount = [hasLength, hasUppercase && hasLowercase, hasNumber, hasSpecial].filter(Boolean).length

    return {
      length: hasLength,
      case: hasUppercase && hasLowercase,
      number: hasNumber,
      special: hasSpecial,
      metCount: metCount
    }
  }

  /**
   * Calculates strength level (weak/medium/strong)
   * @param {Object} requirements - Requirements status object
   * @returns {string} Strength level
   */
  calculateStrength(requirements) {
    if (requirements.metCount === 0 || requirements.metCount === 1) {
      return "weak"
    } else if (requirements.metCount === 2 || requirements.metCount === 3) {
      return "medium"
    } else {
      return "strong"
    }
  }

  /**
   * Updates the strength bar visual
   * @param {string} strength - Strength level (weak/medium/strong)
   * @param {number} metCount - Number of requirements met
   */
  updateStrengthBar(strength, metCount) {
    if (!this.hasStrengthBarTarget) return
    
    const bar = this.strengthBarTarget
    const percentage = (metCount / 4) * 100

    // Remove all strength classes
    bar.classList.remove("strength-weak", "strength-medium", "strength-strong")
    
    // Add appropriate class
    bar.classList.add(`strength-${strength}`)
    
    // Update width
    bar.style.width = `${percentage}%`
  }

  /**
   * Updates the strength text
   * @param {string} strength - Strength level
   */
  updateStrengthText(strength) {
    if (this.hasStrengthLevelTarget) {
      const password = this.inputTarget.value
      if (!password || password.length === 0) {
        this.strengthLevelTarget.textContent = "-"
      } else {
        const levelText = strength.charAt(0).toUpperCase() + strength.slice(1)
        this.strengthLevelTarget.textContent = levelText
      }
    }
  }

  /**
   * Updates the requirements checklist
   * @param {Object} requirements - Requirements status object
   */
  updateRequirementsList(requirements) {
    if (!this.hasRequirementsTarget) return

    const items = this.requirementsTarget.querySelectorAll("[data-requirement]")
    
    items.forEach(item => {
      const requirementType = item.dataset.requirement
      let isMet = false

      switch(requirementType) {
        case "length":
          isMet = requirements.length
          break
        case "case":
          isMet = requirements.case
          break
        case "number":
          isMet = requirements.number
          break
        case "special":
          isMet = requirements.special
          break
      }

      // Update icon and styling
      const icon = item.querySelector(".requirement-icon")
      const text = item.querySelector(".requirement-text")
      
      if (isMet) {
        icon.textContent = "✓"
        icon.classList.remove("requirement-unmet")
        icon.classList.add("requirement-met")
        text.classList.remove("requirement-unmet")
        text.classList.add("requirement-met")
      } else {
        icon.textContent = "✗"
        icon.classList.remove("requirement-met")
        icon.classList.add("requirement-unmet")
        text.classList.remove("requirement-met")
        text.classList.add("requirement-unmet")
      }
    })
  }
}

