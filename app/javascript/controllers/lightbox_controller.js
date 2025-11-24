/**
 * Lightbox Controller
 *
 * Handles full-screen image viewing with navigation.
 * Supports keyboard navigation (arrow keys, ESC), click navigation, and image counter.
 *
 * Usage:
 *   <div data-controller="lightbox" data-lightbox-images-value="[...]">
 *     <div data-lightbox-target="item" data-image-url="..." data-image-caption="..."></div>
 *     <div data-lightbox-target="modal">...</div>
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image", "caption", "counter", "item"]
  static values = {
    images: Array
  }

  connect() {
    this.currentIndex = 0
    this.images = []
    
    // Build images array from items or values
    if (this.hasImagesValue && this.imagesValue.length > 0) {
      this.images = this.imagesValue
    } else if (this.hasItemTargets) {
      this.images = this.itemTargets.map(item => ({
        id: item.dataset.imageId,
        url: item.dataset.imageUrl,
        caption: item.dataset.imageCaption || ''
      }))
    }
  }

  /**
   * Opens lightbox with specific image
   * Called from image card click
   */
  openImage(event) {
    const item = event.currentTarget
    const imageId = item.dataset.imageId
    
    // Find index of clicked image
    const index = this.images.findIndex(img => img.id === imageId)
    if (index !== -1) {
      this.currentIndex = index
      this.open()
    }
  }

  /**
   * Opens the lightbox at current index
   */
  open() {
    if (this.images.length === 0) return
    
    this.updateImage()
    this.modalTarget.classList.remove('hidden')
    this.modalTarget.classList.add('flex')
    document.body.style.overflow = 'hidden'
  }

  /**
   * Closes the lightbox
   */
  close() {
    this.modalTarget.classList.add('hidden')
    this.modalTarget.classList.remove('flex')
    document.body.style.overflow = 'auto'
  }

  /**
   * Closes lightbox when clicking backdrop
   */
  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }

  /**
   * Navigate to next image
   */
  next(event) {
    if (event) event.stopPropagation()
    this.currentIndex = (this.currentIndex + 1) % this.images.length
    this.updateImage()
  }

  /**
   * Navigate to previous image
   */
  previous(event) {
    if (event) event.stopPropagation()
    this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length
    this.updateImage()
  }

  /**
   * Handle keyboard navigation
   */
  handleKeyboard(event) {
    if (!this.modalTarget.classList.contains('flex')) return
    
    switch (event.key) {
      case 'Escape':
        this.close()
        break
      case 'ArrowRight':
        event.preventDefault()
        this.next()
        break
      case 'ArrowLeft':
        event.preventDefault()
        this.previous()
        break
    }
  }

  /**
   * Update displayed image and caption
   */
  updateImage() {
    if (this.images.length === 0) return
    
    const currentImage = this.images[this.currentIndex]
    
    if (this.hasImageTarget) {
      this.imageTarget.src = currentImage.url
      this.imageTarget.alt = currentImage.caption || 'Studio photo'
    }
    
    if (this.hasCaptionTarget) {
      this.captionTarget.textContent = currentImage.caption || ''
    }
    
    if (this.hasCounterTarget) {
      this.counterTarget.textContent = `${this.currentIndex + 1} / ${this.images.length}`
    }
  }
}

