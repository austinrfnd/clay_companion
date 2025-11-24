/**
 * Studio Reorder Controller
 *
 * Handles drag-and-drop reordering of studio images.
 * Also handles image deletion.
 * Updates display_order via API when items are reordered.
 *
 * Usage:
 *   <div data-controller="studio-reorder">
 *     <div data-studio-reorder-target="item" data-image-id="<%= image.id %>">
 *       <div data-studio-reorder-target="handle">Drag handle</div>
 *     </div>
 *   </div>
 *
 *   <button
 *     data-controller="studio-reorder"
 *     data-action="click->studio-reorder#deleteImage"
 *     data-studio-reorder-image-id-param="<%= image.id %>"
 *     data-studio-reorder-artist-id-param="<%= @artist.id %>"
 *   >Delete</button>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "handle"]
  static values = { artistId: String }

  connect() {
    // Initialize drag and drop if Sortable library is available
    // For now, we'll use native HTML5 drag and drop
    this.initializeDragAndDrop()
  }

  /**
   * Initializes drag and drop functionality
   */
  initializeDragAndDrop() {
    this.itemTargets.forEach((item, index) => {
      const handle = item.querySelector('[data-studio-reorder-target="handle"]')
      if (handle) {
        // Make the item draggable
        item.draggable = true
        item.dataset.originalIndex = index

        // Add drag event listeners
        item.addEventListener('dragstart', (e) => this.handleDragStart(e, item))
        item.addEventListener('dragover', (e) => this.handleDragOver(e, item))
        item.addEventListener('drop', (e) => this.handleDrop(e, item))
        item.addEventListener('dragend', (e) => this.handleDragEnd(e, item))
      }
    })
  }

  /**
   * Handles drag start event
   */
  handleDragStart(event, item) {
    event.dataTransfer.effectAllowed = 'move'
    event.dataTransfer.setData('text/html', item.outerHTML)
    item.classList.add('opacity-50', 'border-celadon-dark')
  }

  /**
   * Handles drag over event
   */
  handleDragOver(event, item) {
    event.preventDefault()
    event.dataTransfer.dropEffect = 'move'

    const draggingItem = this.element.querySelector('.opacity-50')
    if (draggingItem && draggingItem !== item) {
      const rect = item.getBoundingClientRect()
      const midpoint = rect.top + rect.height / 2

      if (event.clientY < midpoint) {
        // Insert before this item
        item.classList.add('border-t-2', 'border-celadon-dark')
        item.classList.remove('border-b-2')
      } else {
        // Insert after this item
        item.classList.add('border-b-2', 'border-celadon-dark')
        item.classList.remove('border-t-2')
      }
    }
  }

  /**
   * Handles drop event
   */
  handleDrop(event, item) {
    event.preventDefault()
    event.stopPropagation()

    const draggingItem = this.element.querySelector('.opacity-50')
    if (!draggingItem || draggingItem === item) {
      return
    }

    // Determine insert position
    const rect = item.getBoundingClientRect()
    const midpoint = rect.top + rect.height / 2
    const insertBefore = event.clientY < midpoint

    if (insertBefore) {
      item.parentNode.insertBefore(draggingItem, item)
    } else {
      item.parentNode.insertBefore(draggingItem, item.nextSibling)
    }

    // Update display orders via API
    this.updateDisplayOrders()
  }

  /**
   * Handles drag end event
   */
  handleDragEnd(event, item) {
    // Remove all drag styling
    this.itemTargets.forEach(i => {
      i.classList.remove('opacity-50', 'border-celadon-dark', 'border-t-2', 'border-b-2')
    })
  }

  /**
   * Updates display orders for all items
   */
  async updateDisplayOrders() {
    const artistId = this.artistIdValue
    const items = this.itemTargets
    const updates = []

    // Build array of image IDs in their new order
    items.forEach((item, index) => {
      const imageId = item.dataset.imageId
      if (imageId) {
        updates.push({
          id: imageId,
          display_order: index
        })
      }
    })

    // Update via API (batch update would be ideal, but for now update individually)
    // Note: This could be optimized with a batch update endpoint
    for (const update of updates) {
      await this.updateImageOrder(artistId, update.id, update.display_order)
    }
  }

  /**
   * Updates a single image's display order
   * @param {string} artistId - Artist UUID
   * @param {string} imageId - StudioImage UUID
   * @param {number} displayOrder - New display order
   */
  async updateImageOrder(artistId, imageId, displayOrder) {
    const url = `/api/artists/${artistId}/studio-images/${imageId}`

    try {
      const response = await fetch(url, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          studio_image: {
            display_order: displayOrder
          }
        })
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.errors?.join(', ') || 'Failed to update display order')
      }
    } catch (error) {
      console.error('Error updating display order:', error)
      // Reload page to restore correct order
      window.location.reload()
    }
  }

  /**
   * Deletes an image
   * Called from delete button click
   * Expects data attributes: data-image-id and data-artist-id on the button
   */
  async deleteImage(event) {
    const button = event.currentTarget
    const imageId = button.dataset.imageId
    const artistId = button.dataset.artistId || this.artistIdValue

    if (!imageId) {
      console.error('Image ID not found')
      return
    }

    if (!confirm('Are you sure you want to delete this image? This action cannot be undone.')) {
      return
    }

    const url = `/api/artists/${artistId}/studio-images/${imageId}`

    try {
      const response = await fetch(url, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.errors?.join(', ') || 'Failed to delete image')
      }

      // Remove the image card from the DOM
      const imageCard = document.querySelector(`[data-image-id="${imageId}"]`)
      if (imageCard) {
        imageCard.remove()
      } else {
        // If we can't find it, reload the page
        window.location.reload()
      }
    } catch (error) {
      console.error('Error deleting image:', error)
      alert(`Failed to delete image: ${error.message}`)
    }
  }
}

