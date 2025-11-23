/**
 * Studio Upload Controller
 *
 * Handles drag-and-drop and click-to-upload for studio images.
 * Supports multiple file uploads (JPG, PNG, HEIC).
 * Validates file types and sizes, then uploads to API.
 * Shows upload progress and error handling.
 *
 * Usage:
 *   <div
 *     data-controller="studio-upload"
 *     data-studio-upload-artist-id-value="<%= @artist.id %>"
 *     data-action="click->studio-upload#openFileDialog dragover->studio-upload#handleDragOver drop->studio-upload#handleDrop"
 *   >
 *     <input type="file" multiple data-studio-upload-target="fileInput" />
 *   </div>
 */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput"]
  static values = { artistId: String }

  /**
   * Opens the file picker dialog
   */
  openFileDialog() {
    this.fileInputTarget.click()
  }

  /**
   * Handles drag over event
   * Prevents default and adds visual feedback
   */
  handleDragOver(event) {
    event.preventDefault()
    event.stopPropagation()
    this.element.classList.add('border-celadon-dark', 'bg-celadon/5')
  }

  /**
   * Handles drag leave event
   * Removes visual feedback
   */
  handleDragLeave(event) {
    event.preventDefault()
    event.stopPropagation()
    this.element.classList.remove('border-celadon-dark', 'bg-celadon/5')
  }

  /**
   * Handles drop event
   * Processes dropped files
   */
  handleDrop(event) {
    event.preventDefault()
    event.stopPropagation()
    this.element.classList.remove('border-celadon-dark', 'bg-celadon/5')

    const files = event.dataTransfer.files
    if (files.length > 0) {
      this.processFiles(Array.from(files))
    }
  }

  /**
   * Handles file input change event
   * Processes selected files
   */
  handleFileSelect(event) {
    const files = Array.from(event.target.files)
    if (files.length > 0) {
      this.processFiles(files)
    }
    // Reset file input to allow selecting the same file again
    event.target.value = ''
  }

  /**
   * Processes multiple files
   * Validates and uploads each file
   * @param {File[]} files - Array of File objects
   */
  async processFiles(files) {
    const validFiles = []

    // Validate all files first
    for (const file of files) {
      const validation = this.validateFile(file)
      if (validation.valid) {
        validFiles.push(file)
      } else {
        alert(`"${file.name}": ${validation.error}`)
      }
    }

    // Upload valid files
    for (const file of validFiles) {
      await this.uploadFile(file)
    }
  }

  /**
   * Validates a file
   * @param {File} file - File to validate
   * @return {Object} { valid: boolean, error?: string }
   */
  validateFile(file) {
    // Validate file type
    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/heic', 'image/heif']
    if (!validTypes.includes(file.type)) {
      return { valid: false, error: 'Only JPG, PNG, and HEIC images are supported' }
    }

    // Validate file size (10MB)
    const maxSize = 10 * 1024 * 1024 // 10MB in bytes
    if (file.size > maxSize) {
      return { valid: false, error: 'Image must be under 10MB. Please compress and try again.' }
    }

    return { valid: true }
  }

  /**
   * Uploads a single file to the API
   * @param {File} file - File to upload
   */
  async uploadFile(file) {
    const artistId = this.artistIdValue
    const url = `/api/artists/${artistId}/studio-images`

    // Create FormData for file upload
    const formData = new FormData()
    formData.append('studio_image[image]', file)

    try {
      // Show upload indicator (could add a loading spinner)
      this.showUploadProgress(file.name)

      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: formData
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.errors?.join(', ') || 'Failed to upload image')
      }

      const data = await response.json()

      // Hide upload progress
      this.hideUploadProgress(file.name)

      // Reload the page to show the new image
      // Alternatively, could use Turbo to append the new image card
      window.location.reload()
    } catch (error) {
      console.error('Error uploading file:', error)
      this.hideUploadProgress(file.name)
      alert(`Failed to upload "${file.name}": ${error.message}`)
    }
  }

  /**
   * Shows upload progress indicator
   * @param {string} fileName - Name of file being uploaded
   */
  showUploadProgress(fileName) {
    // Create a temporary progress indicator
    const progressDiv = document.createElement('div')
    progressDiv.id = `upload-progress-${fileName}`
    progressDiv.className = 'mb-2 p-2 bg-blue-50 border border-blue-200 rounded text-sm text-blue-800'
    progressDiv.textContent = `Uploading ${fileName}...`
    
    // Insert before the upload zone
    this.element.parentNode.insertBefore(progressDiv, this.element)
  }

  /**
   * Hides upload progress indicator
   * @param {string} fileName - Name of file that was uploaded
   */
  hideUploadProgress(fileName) {
    const progressDiv = document.getElementById(`upload-progress-${fileName}`)
    if (progressDiv) {
      progressDiv.remove()
    }
  }
}

