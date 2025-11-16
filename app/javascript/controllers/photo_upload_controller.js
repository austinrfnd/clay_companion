/**
 * Photo Upload Controller
 * 
 * Handles photo upload functionality for profile setup:
 * - Drag and drop file upload
 * - Click to upload
 * - Image preview
 * - Remove photo
 * - Change photo
 * 
 * Targets:
 * - uploadZone: The upload zone container
 * - fileInput: The file input element
 * - uploadContent: The default upload content (icon, text, etc.)
 * - preview: The image preview element
 * - removeButton: The remove photo button
 * - changeLink: The change photo link
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["uploadZone", "fileInput", "uploadContent", "preview", "removeButton", "changeLink"]

  connect() {
    // Initialize on connect
    this.updatePreviewState()
  }

  /**
   * Handle drag over event
   * Prevents default and adds visual feedback
   */
  handleDragOver(event) {
    event.preventDefault()
    event.stopPropagation()
    this.uploadZoneTarget.classList.add("drag-over")
  }

  /**
   * Handle drag leave event
   * Removes visual feedback
   */
  handleDragLeave(event) {
    event.preventDefault()
    event.stopPropagation()
    this.uploadZoneTarget.classList.remove("drag-over")
  }

  /**
   * Handle drop event
   * Processes dropped file
   */
  handleDrop(event) {
    event.preventDefault()
    event.stopPropagation()
    this.uploadZoneTarget.classList.remove("drag-over")

    const files = event.dataTransfer.files
    if (files.length > 0) {
      this.processFile(files[0])
    }
  }

  /**
   * Handle click on upload zone
   * Opens file picker
   */
  handleClick(event) {
    // Don't trigger if clicking on preview, remove button, or change link
    if (event.target.closest('.profile-photo-preview') || 
        event.target.closest('.profile-photo-remove') ||
        event.target.closest('.profile-photo-change')) {
      return
    }
    this.fileInputTarget.click()
  }

  /**
   * Handle file selection from file input
   */
  handleFileSelect(event) {
    const file = event.target.files[0]
    if (file) {
      this.processFile(file)
    }
  }

  /**
   * Process selected file
   * Validates and shows preview
   */
  processFile(file) {
    // Validate file type
    if (!file.type.match(/^image\/(jpeg|jpg|png)$/)) {
      alert('Only JPG and PNG images are supported')
      return
    }

    // Validate file size (5MB)
    if (file.size > 5 * 1024 * 1024) {
      alert('Image must be under 5MB. Please compress and try again.')
      return
    }

    // Show preview
    const reader = new FileReader()
    reader.onload = (e) => {
      this.previewTarget.src = e.target.result
      this.previewTarget.style.display = 'block'
      this.updatePreviewState()
    }
    reader.readAsDataURL(file)
  }

  /**
   * Handle remove photo button click
   */
  handleRemove(event) {
    event.preventDefault()
    event.stopPropagation()
    
    // Clear file input
    this.fileInputTarget.value = ''
    
    // Hide preview
    this.previewTarget.src = ''
    this.previewTarget.style.display = 'none'
    
    this.updatePreviewState()
  }

  /**
   * Handle change photo link click
   */
  handleChange(event) {
    event.preventDefault()
    event.stopPropagation()
    this.fileInputTarget.click()
  }

  /**
   * Update preview state visibility
   * Shows/hides upload content, preview, remove button, and change link
   */
  updatePreviewState() {
    const hasPreview = this.previewTarget.src && this.previewTarget.src !== window.location.href
    
    if (hasPreview) {
      // Show preview, hide upload content
      this.uploadContentTarget.style.display = 'none'
      this.previewTarget.style.display = 'block'
      this.removeButtonTarget.style.display = 'block'
      this.changeLinkTarget.style.display = 'block'
    } else {
      // Show upload content, hide preview
      this.uploadContentTarget.style.display = 'block'
      this.previewTarget.style.display = 'none'
      this.removeButtonTarget.style.display = 'none'
      this.changeLinkTarget.style.display = 'none'
    }
  }
}

