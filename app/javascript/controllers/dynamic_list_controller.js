// Dynamic List Controller
//
// Handles dynamic addition, removal, and reordering of form fields for:
// - Education entries (institution, degree, year)
// - Awards entries (title, organization, year)
// - Other links (label, url)
//
// Usage:
//   <div data-controller="dynamic-list" data-dynamic-list-item-name-value="education">
//     <div data-dynamic-list-target="item">...</div>
//     <button data-action="click->dynamic-list#addItem">Add</button>
//     <button data-action="click->dynamic-list#removeItem">Remove</button>
//   </div>

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    itemName: String  // e.g., "education", "awards", "other_links"
  }

  static targets = ["item"]

  connect() {
    // Initialize on connect
  }

  // Add a new item to the list
  addItem(event) {
    event.preventDefault()
    
    const itemName = this.itemNameValue
    const lastItem = this.itemTargets[this.itemTargets.length - 1]
    
    // Clone the last item (or create from template if no items exist)
    let newItem
    if (lastItem) {
      newItem = lastItem.cloneNode(true)
      // Clear input values in the cloned item
      newItem.querySelectorAll('input, textarea, select').forEach(input => {
        if (input.type === 'checkbox' || input.type === 'radio') {
          input.checked = false
        } else {
          input.value = ''
        }
        // Update the name attribute to use a new index
        const name = input.getAttribute('name')
        if (name) {
          // Extract the current index and increment it
          const match = name.match(/\[(\d+)\]/)
          if (match) {
            const currentIndex = parseInt(match[1])
            const newIndex = currentIndex + 1
            input.setAttribute('name', name.replace(/\[\d+\]/, `[${newIndex}]`))
            input.setAttribute('id', input.getAttribute('id')?.replace(/_\d+_/, `_${newIndex}_`) || '')
          } else {
            // If no index found, add one
            const baseName = name.replace(/\[\]$/, '')
            input.setAttribute('name', `${baseName}[${this.itemTargets.length}]`)
          }
        }
      })
      
      // Update labels to match new input IDs
      newItem.querySelectorAll('label').forEach(label => {
        const forAttr = label.getAttribute('for')
        if (forAttr) {
          const input = newItem.querySelector(`#${forAttr}`)
          if (input && input.id) {
            label.setAttribute('for', input.id)
          }
        }
      })
    } else {
      // Create a new item from scratch if no items exist
      newItem = this.createNewItem(itemName, 0)
    }
    
    // Insert the new item before the "Add" button
    const addButton = event.target.closest('[data-controller*="dynamic-list"]').querySelector('[data-action*="addItem"]')
    if (addButton && addButton.parentNode) {
      addButton.parentNode.insertBefore(newItem, addButton)
    } else {
      this.element.appendChild(newItem)
    }
    
    // Focus the first input in the new item
    const firstInput = newItem.querySelector('input, textarea, select')
    if (firstInput) {
      firstInput.focus()
    }
  }

  // Remove an item from the list
  removeItem(event) {
    event.preventDefault()
    
    const item = event.target.closest('[data-dynamic-list-target="item"]')
    if (item && this.itemTargets.length > 0) {
      item.remove()
      // Re-index remaining items to maintain sequential indices
      this.reindexItems()
    }
  }

  // Re-index all items to maintain sequential array indices
  reindexItems() {
    this.itemTargets.forEach((item, index) => {
      item.querySelectorAll('input, textarea, select').forEach(input => {
        const name = input.getAttribute('name')
        if (name) {
          // Replace the index in the name attribute
          const newName = name.replace(/\[(\d+)\]/, `[${index}]`)
          input.setAttribute('name', newName)
          
          // Update ID if it exists
          const id = input.getAttribute('id')
          if (id) {
            const newId = id.replace(/_\d+_/, `_${index}_`)
            input.setAttribute('id', newId)
            
            // Update associated label
            const label = item.querySelector(`label[for="${id}"]`)
            if (label) {
              label.setAttribute('for', newId)
            }
          }
        }
      })
    })
  }

  // Create a new item element from scratch (fallback if no template exists)
  createNewItem(itemName, index) {
    const item = document.createElement('div')
    item.setAttribute('data-dynamic-list-target', 'item')
    item.className = 'border border-pale-celadon rounded-lg p-4'
    
    // Create fields based on item type
    if (itemName === 'education') {
      item.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Institution</label>
            <input type="text" name="artist[education][${index}][institution]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="School name">
          </div>
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Degree/Program</label>
            <input type="text" name="artist[education][${index}][degree]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Degree or program">
          </div>
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Year</label>
            <input type="text" name="artist[education][${index}][year]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Year">
          </div>
        </div>
        <button type="button" class="mt-3 text-sm text-error hover:text-error/80" 
                data-action="click->dynamic-list#removeItem">Remove</button>
      `
    } else if (itemName === 'awards') {
      item.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Title</label>
            <input type="text" name="artist[awards][${index}][title]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Award title">
          </div>
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Organization</label>
            <input type="text" name="artist[awards][${index}][organization]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Organization name">
          </div>
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Year</label>
            <input type="text" name="artist[awards][${index}][year]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Year">
          </div>
        </div>
        <button type="button" class="mt-3 text-sm text-error hover:text-error/80" 
                data-action="click->dynamic-list#removeItem">Remove</button>
      `
    } else if (itemName === 'other_links') {
      item.innerHTML = `
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">Label</label>
            <input type="text" name="artist[other_links][${index}][label]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="Link label">
          </div>
          <div>
            <label class="block text-sm font-medium text-charcoal mb-2">URL</label>
            <input type="url" name="artist[other_links][${index}][url]" 
                   class="w-full h-12 px-4 border border-pale-celadon rounded-lg focus:outline-none focus:ring-2 focus:ring-celadon focus:border-transparent"
                   placeholder="https://example.com">
          </div>
        </div>
        <button type="button" class="mt-3 text-sm text-error hover:text-error/80" 
                data-action="click->dynamic-list#removeItem">Remove</button>
      `
    }
    
    return item
  }
}


