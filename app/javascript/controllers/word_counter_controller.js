/**
 * Word Counter Controller
 *
 * Handles real-time word counting for textarea fields.
 * Updates word count display as user types.
 * Shows warning when approaching limit (90+ words).
 * Shows error state when over limit (100+ words).
 *
 * Usage:
 *   <textarea
 *     data-controller="word-counter"
 *     data-word-counter-target="textarea"
 *     data-action="input->word-counter#count"
 *   />
 *   <div data-word-counter-target="counter">
 *     <span data-word-counter-target="count">0</span> / 100 words
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "counter", "count"]
  static values = { maxWords: Number }

  connect() {
    // Initialize count on connect
    this.count()
  }

  /**
   * Count words in textarea and update display
   * Called on input event
   */
  count() {
    const text = this.textareaTarget.value || ''
    const wordCount = this.countWords(text)
    const maxWords = this.maxWordsValue || 100

    // Update count display
    if (this.hasCountTarget) {
      this.countTarget.textContent = wordCount
    } else {
      this.counterTarget.textContent = `${wordCount} / ${maxWords} words`
    }

    // Update styling based on word count
    this.updateStyling(wordCount, maxWords)
  }

  /**
   * Count words in text (splits on whitespace, filters empty strings)
   * @param {string} text - Text to count words in
   * @return {number} Word count
   */
  countWords(text) {
    if (!text || text.trim().length === 0) {
      return 0
    }
    // Split on whitespace and filter out empty strings
    return text.trim().split(/\s+/).filter(word => word.length > 0).length
  }

  /**
   * Update counter styling based on word count
   * - Normal: 0-89 words
   * - Warning: 90-99 words (approaching limit)
   * - Error: 100+ words (over limit)
   * @param {number} wordCount - Current word count
   * @param {number} maxWords - Maximum allowed words
   */
  updateStyling(wordCount, maxWords) {
    // Remove all state classes first
    this.counterTarget.classList.remove('text-slate', 'text-yellow-600', 'text-error')

    if (wordCount >= maxWords) {
      // Over limit - error state
      this.counterTarget.classList.add('text-error', 'font-semibold')
    } else if (wordCount >= maxWords * 0.9) {
      // Approaching limit - warning state (90% of max)
      this.counterTarget.classList.add('text-yellow-600', 'font-medium')
    } else {
      // Normal state
      this.counterTarget.classList.add('text-slate')
    }
  }
}

