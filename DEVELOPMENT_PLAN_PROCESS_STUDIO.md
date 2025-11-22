# Development Plan: Process/Studio Page (Dashboard + Public)

**Scope**: Dashboard studio settings management + Public process/studio page
**Priority**: High (core portfolio feature)
**Estimated Effort**: 2-3 weeks
**Status**: Planning phase

---

## Table of Contents

1. [Quick Reference](#quick-reference)
2. [Architecture Overview](#architecture-overview)
3. [Database Schema Review](#database-schema-review)
4. [Dashboard Settings - Studio Page](#dashboard-settings---studio-page)
5. [Public-Facing Process/Studio Page](#public-facing-processstudio-page)
6. [API Endpoints](#api-endpoints)
7. [Implementation Sequence](#implementation-sequence)
8. [Testing Strategy](#testing-strategy)

---

## Quick Reference

### Working Preview Files

**Public Page Preview**: `requirements/wireframes/process-studio-preview.html`

This file contains **production-ready HTML/CSS/JS** for the public-facing page with:
- ✅ Hero section with background image support
- ✅ Dynamic 12-column masonry grid layout
- ✅ Responsive design (desktop/tablet/mobile)
- ✅ Category badges with distinct colors
- ✅ Image cards with hover effects
- ✅ Functional lightbox with navigation
- ✅ Keyboard navigation support

**How to use it**:
1. This serves as the visual specification and starting point
2. Extract CSS and adapt to your framework (Rails, etc.)
3. Convert HTML structure to your templating language (ERB, etc.)
4. Keep the logic as-is and wire it to your backend API

**CSS to reuse**:
- Hero section styling (background, overlay, typography)
- Gallery grid layout (12-column, responsive breakpoints)
- Image card styling (aspect ratio, hover, badge positioning)
- Lightbox styling and animations

**JavaScript to adapt**:
- Lightbox open/close logic
- Image navigation (prev/next)
- Keyboard event handling

---

---

## Architecture Overview

### Data Flow

```
Artist Dashboard (Settings)
    ↓
    uploads images & edits metadata
    ↓
database (studio_images table)
    ↓
API endpoints
    ↓
Public Portfolio Page (Read-only display)
    ↓
Visitor sees process/studio photos
```

### Key Files to Create/Modify

**Backend**:
- `app/models/studio_image.rb` (or update existing)
- `app/controllers/api/studio_images_controller.rb`
- `app/serializers/studio_image_serializer.rb`

**Frontend - Dashboard**:
- `app/views/dashboard/studio_settings.html.erb`
- `app/javascript/controllers/studio_upload_controller.js`
- `app/javascript/controllers/studio_reorder_controller.js`

**Frontend - Public** (Reference: `requirements/wireframes/process-studio-preview.html`):
- `app/views/artists/process_studio.html.erb` - Adapt preview HTML to ERB template
- `app/assets/stylesheets/studio_page.css` - Extract CSS from preview
- `app/javascript/studio_page.js` - Adapt lightbox JS from preview

### Integration Strategy for Preview HTML

The preview HTML already has all the styling and JS logic you need. Here's how to integrate it:

**Step 1: Extract CSS**
- Copy all `<style>` content from preview
- Adapt color variables to your design token system
- Create `app/assets/stylesheets/studio_page.css` or use CSS modules

**Step 2: Convert HTML to ERB Template**
```erb
<!-- From preview: -->
<section class="hero" style="background-image: url('./clay_studio.png');">

<!-- Convert to ERB: -->
<section class="hero" style="background-image: url('<%= @artist.studio_hero_image_url %>');">
  <div class="hero-content">
    <h1>Studio & Process</h1>
    <div class="hero-divider"></div>
    <p class="intro-text"><%= @artist.studio_intro_text %></p>
  </div>
</section>
```

**Step 3: Wire up JavaScript**
- Copy lightbox functions from preview `<script>` section
- Create Stimulus controller or vanilla JS module
- Connect to your data/API

**Step 4: Adapt for Dynamic Data**
Replace static image cards with loop:
```erb
<div class="gallery-grid">
  <% @studio_images.each_with_index do |image, index| %>
    <div class="image-card" onclick="openLightbox(<%= index %>)">
      <div class="image-wrapper">
        <span class="image-badge <%= image.category %>">
          <%= image.category.titleize %>
        </span>
        <%= image_tag image.image.url, alt: image.caption %>
      </div>
      <p class="image-caption"><%= image.caption %></p>
    </div>
  <% end %>
</div>
```

---

## Database Schema Review

### Current `studio_images` Table

```sql
CREATE TABLE studio_images (
  id UUID PRIMARY KEY,
  artist_id UUID NOT NULL FOREIGN KEY,
  alt_text VARCHAR(500),
  caption TEXT,
  width INTEGER,
  height INTEGER,
  file_size INTEGER,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (artist_id) REFERENCES artists(id),
  INDEX (artist_id, display_order)
);
```

### Required Additions

```sql
-- Add category field if not exists
ALTER TABLE studio_images ADD COLUMN category VARCHAR(50) DEFAULT 'other';
-- Values: 'studio', 'process', 'other'

-- Verify indexes
CREATE INDEX idx_studio_images_artist_id_display_order
  ON studio_images(artist_id, display_order);
```

### `artists` Table - Additions

```sql
-- Add studio intro text if not exists
ALTER TABLE artists ADD COLUMN studio_intro_text TEXT;
-- Max 100 words (~600 characters)

-- Add studio hero image reference (optional)
ALTER TABLE artists ADD COLUMN studio_hero_image_id UUID;
-- Foreign key to studio_images table
-- Allows artist to select which image displays as hero background
-- NULL means use default gradient background
ALTER TABLE artists
  ADD CONSTRAINT fk_studio_hero_image
  FOREIGN KEY (studio_hero_image_id)
  REFERENCES studio_images(id) ON DELETE SET NULL;
```

### Model Relationships

```ruby
class Artist < ApplicationRecord
  has_many :studio_images, dependent: :destroy
  belongs_to :studio_hero_image, class_name: 'StudioImage', optional: true,
    foreign_key: 'studio_hero_image_id'

  validates :studio_intro_text, length: { maximum: 600 }
end

class StudioImage < ApplicationRecord
  belongs_to :artist
  has_one_attached :image

  enum category: { studio: 'studio', process: 'process', other: 'other' }

  validates :caption, length: { maximum: 150 }
  validates :category, presence: true

  scope :by_artist, ->(artist_id) { where(artist_id: artist_id) }
  scope :ordered, -> { order(display_order: :asc) }
end
```

---

## Dashboard Settings - Studio Page

### Overview

Artists manage their studio photos and intro text from a settings page. This is where they:
- Write/edit intro paragraph
- Upload photos
- Edit captions and categories
- Reorder images
- Delete images

### Page Layout

**URL**: `/dashboard/settings/studio`

**Template Structure**:
```
┌─────────────────────────────────────────────────────┐
│ Studio Settings                                     │
│ (H1 - 48px, Bold)                                   │
│                                                     │
│ Manage your studio and process photos               │
│ (Body Large - 18px)                                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ Introduction Text (Optional)                        │
│                                                     │
│ [Textarea - 80px min height, max 100 words]         │
│ Brief intro about your workspace or process         │
│ (max 100 words)                                      │
│                                                     │
│ Word counter: X / 100                               │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ Studio & Process Photos                             │
│                                                     │
│ [📷 Drag & Drop Upload Area]                        │
│ Click or drag photos here                           │
│ Supports: JPG, PNG, HEIC • Max 10MB per file        │
│                                                     │
│ ┌─────────────────────────────────────────────────┐ │
│ │ [IMG] Image 1                                   │ │
│ │       Caption: [________] Category: [Studio ▼] │ │
│ │       [Delete] [⋮⋮ drag handle]                │ │
│ └─────────────────────────────────────────────────┘ │
│                                                     │
│ ┌─────────────────────────────────────────────────┐ │
│ │ [IMG] Image 2                                   │ │
│ │       Caption: [________] Category: [Process▼] │ │
│ │       [Delete] [⋮⋮ drag handle]                │ │
│ └─────────────────────────────────────────────────┘ │
│                                                     │
└─────────────────────────────────────────────────────┘

[Cancel] [Save Changes]
```

### Components to Build

#### 1. **Hero Image Section**

**Component**: `StudioHeroImageSection`

```jsx
<div class="form-section">
  <h2>Hero Image (Background for Process/Studio Page)</h2>

  <p class="section-description">
    Choose which photo to use as the background image in the hero section
    of your public Process/Studio page. This photo will be displayed with
    a white overlay to ensure text readability.
  </p>

  <!-- Hero image preview -->
  <div class="hero-preview">
    <div class="preview-label">Current Hero Image Preview:</div>
    <% if @artist.studio_hero_image %>
      <div class="preview-container">
        <%= image_tag @artist.studio_hero_image.image.url, alt: "Hero image preview" %>
      </div>
    <% else %>
      <div class="preview-container empty">
        <p>No hero image selected</p>
      </div>
    <% end %>
  </div>

  <!-- Image selection -->
  <div class="hero-image-selector">
    <label>Select an image as hero background:</label>
    <p class="helper-text">
      Choose from your uploaded photos below, or upload a new one.
      Images work best when they are landscape-oriented.
    </p>

    <div class="image-radio-group">
      <% @artist.studio_images.each do |image| %>
        <div class="radio-item">
          <label class="radio-with-preview">
            <input
              type="radio"
              name="studio_hero_image_id"
              value="<%= image.id %>"
              <%= 'checked' if @artist.studio_hero_image_id == image.id %>
              data-auto-save
            >
            <span class="radio-label-text">
              <%= image.caption || "Untitled Image" %>
            </span>
          </label>
          <div class="thumbnail-preview">
            <%= image_tag image.image.url, alt: image.caption %>
          </div>
        </div>
      <% end %>
    </div>
  </div>

  <!-- Clear hero image option -->
  <div class="form-field">
    <label class="checkbox-label">
      <input
        type="checkbox"
        name="clear_hero_image"
        data-action="change->studio-settings#clearHeroImage"
      >
      Use default background (no custom image)
    </label>
  </div>
</div>
```

**Styling for Hero Image Section**:
```css
.hero-preview {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: #F8FAF9;
  border-radius: 0.5rem;
  border: 1px solid rgba(168, 196, 181, 0.3);
}

.preview-label {
  font-size: 0.875rem;
  font-weight: 600;
  color: #5C6C62;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.preview-container {
  width: 100%;
  height: 300px;
  background: #E5E7EB;
  border-radius: 0.5rem;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.preview-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.preview-container.empty {
  background: #D1D5DB;
  color: #6B7280;
}

.image-radio-group {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
  margin-top: 1rem;
}

.radio-item {
  position: relative;
}

.radio-with-preview {
  display: flex;
  flex-direction: column;
  cursor: pointer;
  gap: 0.75rem;
}

.radio-with-preview input[type="radio"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
}

.radio-label-text {
  font-weight: 500;
  color: #1F2421;
}

.thumbnail-preview {
  width: 100%;
  height: 120px;
  border-radius: 0.5rem;
  overflow: hidden;
  border: 2px solid transparent;
  transition: all 200ms;
}

.thumbnail-preview img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.radio-item input[type="radio"]:checked ~ .thumbnail-preview {
  border-color: #6E9180;
  box-shadow: 0 0 0 4px rgba(110, 145, 128, 0.1);
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  cursor: pointer;
  font-weight: 500;
}

.checkbox-label input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
}
```

**Functionality**:
- Display preview of currently selected hero image
- Show all uploaded studio images as options
- Allow artist to select which image to use as hero background
- Option to use default background (no custom image)
- Auto-save selection
- Preview updates in real-time

---

#### 2. **Introduction Text Section**

**Component**: `StudioIntroSection`

```jsx
<div class="form-section">
  <h2>Introduction Text (Optional)</h2>

  <label for="studio_intro_text">Studio Introduction</label>
  <textarea
    id="studio_intro_text"
    name="studio_intro_text"
    class="form-textarea"
    placeholder="Brief intro about your workspace or process (max 100 words)"
    minlength="0"
    maxlength="600"
    style="min-height: 80px; resize: vertical;"
  ></textarea>

  <div class="helper-text">
    Brief intro about your workspace or process (max 100 words)
  </div>

  <div class="word-counter">
    <span id="word-count">0</span> / 100 words
  </div>
</div>
```

**Functionality**:
- Auto-count words as user types
- Disable submit if over 100 words
- Show warning at 90+ words
- Pre-populate with existing text

#### 2. **Photo Upload Section**

**Component**: `StudioUploadZone`

```jsx
<div class="form-section">
  <h2>Studio & Process Photos</h2>

  <div
    class="upload-zone"
    data-controller="studio-upload"
    data-studio-upload-artist-id-value="<%= @artist.id %>"
  >
    <svg class="upload-icon"><!-- camera icon --></svg>
    <h3>Click or drag photos here</h3>
    <p class="upload-subtext">
      Supports: JPG, PNG, HEIC • Max 10MB per file
    </p>

    <input
      type="file"
      multiple
      accept="image/jpeg,image/png,image/heic"
      data-studio-upload-target="fileInput"
      style="display: none;"
    >
  </div>

  <!-- Upload progress (hidden until upload starts) -->
  <div class="upload-progress" style="display: none;">
    <div>Uploading X of Y images...</div>
    <progress value="0" max="100"></progress>
  </div>
</div>
```

**Functionality**:
- Drag and drop files
- Click to browse files
- File type validation
- File size validation (max 10MB)
- Show upload progress
- Handle errors gracefully

#### 3. **Image List Section**

**Component**: `StudioImageList`

```erb
<div class="form-section">
  <h3>Your Photos (<%= @artist.studio_images.count %>)</h3>

  <div
    class="image-list"
    data-controller="studio-reorder"
  >
    <% @artist.studio_images.ordered.each_with_index do |image, index| %>
      <div
        class="image-card"
        data-studio-reorder-target="item"
        data-image-id="<%= image.id %>"
      >
        <!-- Thumbnail -->
        <div class="image-thumbnail">
          <%= image_tag image.image, alt: image.caption || "Studio photo" %>
        </div>

        <!-- Image details -->
        <div class="image-details">
          <!-- Caption field -->
          <div class="form-field">
            <label for="caption_<%= image.id %>">Caption</label>
            <input
              type="text"
              id="caption_<%= image.id %>"
              class="form-input"
              value="<%= image.caption %>"
              maxlength="150"
              placeholder="Describe this photo..."
              data-studio-image-id="<%= image.id %>"
              data-auto-save
            >
            <span class="char-counter">
              <span class="current-count"><%= image.caption&.length || 0 %></span>/150
            </span>
          </div>

          <!-- Category dropdown -->
          <div class="form-field">
            <label for="category_<%= image.id %>">Category</label>
            <select
              id="category_<%= image.id %>"
              class="form-select"
              data-studio-image-id="<%= image.id %>"
              data-auto-save
            >
              <option value="studio" <%= 'selected' if image.category == 'studio' %>>
                Studio
              </option>
              <option value="process" <%= 'selected' if image.category == 'process' %>>
                Process
              </option>
              <option value="other" <%= 'selected' if image.category == 'other' %>>
                Other
              </option>
            </select>
          </div>

          <!-- Actions -->
          <div class="image-actions">
            <button
              type="button"
              class="btn-delete"
              data-action="click->studio-reorder#deleteImage"
              data-image-id="<%= image.id %>"
            >
              Delete
            </button>

            <div class="drag-handle" data-studio-reorder-target="handle">
              ⋮⋮
            </div>
          </div>
        </div>
      </div>
    <% end %>
  </div>

  <!-- Empty state -->
  <% if @artist.studio_images.empty? %>
    <div class="empty-state">
      <svg class="empty-icon"><!-- camera icon --></svg>
      <h3>No studio photos yet</h3>
      <p>Upload photos of your workspace, tools, and making process to share with visitors.</p>
    </div>
  <% end %>
</div>
```

**Functionality**:
- Display uploaded images in list
- Show thumbnail (120x120px)
- Inline edit caption
- Inline category selection
- Drag handle for reordering
- Delete button with confirmation
- Auto-save caption/category changes
- Empty state when no images

---

## Public-Facing Process/Studio Page

### Overview

Visitors see a beautifully designed gallery of studio photos with a hero section at the top. This is a read-only display of the artist's behind-the-scenes content.

### Page Layout

**URL**: `/artists/:name/process` or `/artists/:name/studio`

**Full Page Design**:
```
┌──────────────────────────────────────────────────────┐
│ HERO SECTION                                         │
│ [Background image with white overlay]                │
│                                                      │
│ STUDIO & PROCESS                                     │
│ ─────────────────                                    │
│                                                      │
│ Come behind the scenes and see where the work is     │
│ made. My studio in Brooklyn is where I spend my      │
│ days throwing, trimming, glazing, and firing...      │
└──────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────┐
│ GALLERY GRID (12-column masonry layout)              │
│                                                      │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐              │
│ │ Image 1  │ │ Image 2  │ │ Image 3  │              │
│ │ Studio   │ │ Studio   │ │ Studio   │              │
│ └──────────┘ └──────────┘ └──────────┘              │
│                                                      │
│ ┌──────────────┐ ┌──────────┐                        │
│ │  Image 4     │ │ Image 5  │                        │
│ │  LARGE       │ │ Process  │                        │
│ │  (2 rows)    │ └──────────┘                        │
│ │              │ ┌──────────┐                        │
│ │  Process     │ │ Image 6  │                        │
│ │              │ │ Process  │                        │
│ └──────────────┘ └──────────┘                        │
│                                                      │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐              │
│ │ Image 7  │ │ Image 8  │ │ Image 9  │              │
│ │ Process  │ │ Process  │ │ Process  │              │
│ └──────────┘ └──────────┘ └──────────┘              │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Components to Build

#### 1. **Hero Section**

**Component**: `StudioHero`

```jsx
<section class="studio-hero">
  <div class="hero-content">
    <h1>Studio & Process</h1>
    <div class="hero-divider"></div>
    <p class="intro-text">
      <%= @artist.studio_intro_text %>
    </p>
  </div>
</section>

<style>
.studio-hero {
  position: relative;
  min-height: 500px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  padding: 6rem 2rem;
  background: linear-gradient(135deg, #F8FAF9 0%, #E8F1ED 100%);
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  overflow: hidden;
}

.studio-hero::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(255, 255, 255, 0.85);
  z-index: 0;
}

.studio-hero::after {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: url('data:image/svg+xml,...');
  opacity: 0.5;
  z-index: 0;
}

.hero-content {
  position: relative;
  z-index: 1;
  max-width: 900px;
}

.studio-hero h1 {
  font-size: 3.5rem;
  font-weight: 700;
  color: #1F2421;
  margin-bottom: 1.5rem;
  letter-spacing: -0.02em;
}

.hero-divider {
  width: 60px;
  height: 3px;
  background: #6E9180;
  margin: 1.5rem auto;
  border-radius: 2px;
}

.intro-text {
  font-size: 1.125rem;
  line-height: 1.8;
  color: #5C6C62;
  max-width: 800px;
}

@media (max-width: 768px) {
  .studio-hero {
    padding: 3rem 1.5rem;
    min-height: auto;
  }

  .studio-hero h1 {
    font-size: 2.25rem;
  }
}
</style>
```

#### 2. **Gallery Grid**

**Component**: `GalleryGrid`

```jsx
<section class="gallery">
  <div class="gallery-grid">
    <% @images.each do |image| %>
      <%= render 'image_card', image: image %>
    <% end %>
  </div>
</section>

<style>
.gallery-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 3rem;
  auto-rows: max-content;
}

/* First row: 3 medium images (4-col each) */
.gallery-grid .image-card:nth-child(1) { grid-column: span 4; }
.gallery-grid .image-card:nth-child(2) { grid-column: span 4; }
.gallery-grid .image-card:nth-child(3) { grid-column: span 4; }

/* Large hero image (6-col, 2-row span) */
.gallery-grid .image-card:nth-child(4) {
  grid-column: span 6;
  grid-row: 2 / span 2;
}

/* Images wrap to right of large image */
.gallery-grid .image-card:nth-child(5) {
  grid-column: span 6;
  grid-row: 2;
}
.gallery-grid .image-card:nth-child(6) {
  grid-column: span 6;
  grid-row: 3;
}

/* Third row: 3 images */
.gallery-grid .image-card:nth-child(7) { grid-column: span 4; }
.gallery-grid .image-card:nth-child(8) { grid-column: span 4; }
.gallery-grid .image-card:nth-child(9) { grid-column: span 4; }

@media (max-width: 1024px) {
  .gallery-grid {
    grid-template-columns: repeat(8, 1fr);
    gap: 2.5rem;
  }

  .gallery-grid .image-card { grid-column: span 4 !important; grid-row: auto !important; }
}

@media (max-width: 768px) {
  .gallery-grid {
    grid-template-columns: 1fr;
    gap: 2.5rem;
  }

  .gallery-grid .image-card { grid-column: span 1 !important; grid-row: auto !important; }
}
</style>
```

#### 3. **Image Card**

**Component**: `ImageCard`

```erb
<div
  class="image-card"
  data-image-id="<%= image.id %>"
  onclick="openLightbox(<%= image.id %>)"
>
  <div class="image-wrapper">
    <!-- Category badge -->
    <span class="image-badge <%= image.category %>">
      <%= image.category.titleize %>
    </span>

    <!-- Image -->
    <%= image_tag image.image,
      class: "image",
      alt: image.caption || "Studio photo",
      loading: "lazy"
    %>
  </div>

  <!-- Caption -->
  <p class="image-caption"><%= image.caption %></p>
</div>

<style>
.image-card {
  cursor: pointer;
  transition: all 300ms cubic-bezier(0.4, 0, 0.2, 1);
  border-radius: 0.75rem;
  overflow: hidden;
}

.image-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
}

.image-wrapper {
  position: relative;
  width: 100%;
  padding-bottom: 75%; /* 4:3 aspect ratio */
  background: #E5E7EB;
  border-radius: 0.75rem;
  overflow: hidden;
  margin-bottom: 1rem;
}

.image {
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  object-fit: cover;
}

.image-badge {
  position: absolute;
  top: 12px; right: 12px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  padding: 0.375rem 0.75rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  z-index: 10;
}

.image-badge.studio { color: #527563; }
.image-badge.process { color: #6E9180; }
.image-badge.other { color: #5C6C62; }

.image-caption {
  font-size: 1rem;
  line-height: 1.6;
  color: #1F2421;
  font-weight: 500;
}
</style>
```

#### 4. **Lightbox Modal**

**Component**: `ImageLightbox`

```jsx
<div class="lightbox" id="lightbox" onclick="closeLightbox(event)">
  <div class="lightbox-content">
    <button class="lightbox-close" onclick="closeLightbox(event)">×</button>
    <button class="lightbox-nav lightbox-prev" onclick="prevImage(event)">‹</button>
    <button class="lightbox-nav lightbox-next" onclick="nextImage(event)">›</button>

    <div class="lightbox-image-container">
      <%= image_tag @current_image.image,
        class: "lightbox-image",
        alt: @current_image.caption
      %>
    </div>

    <p class="lightbox-caption" id="lightboxCaption">
      <%= @current_image.caption %>
    </p>

    <div class="lightbox-counter">
      <span id="current-image">1</span> of <span id="total-images"><%= @images.count %></span>
    </div>
  </div>
</div>

<style>
.lightbox {
  display: none;
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0, 0, 0, 0.9);
  z-index: 1000;
  justify-content: center;
  align-items: center;
}

.lightbox.active {
  display: flex;
}

.lightbox-content {
  position: relative;
  max-width: 90%;
  max-height: 90%;
}

.lightbox-image {
  max-width: 100%;
  max-height: 90vh;
  border-radius: 0.5rem;
}

.lightbox-caption {
  position: absolute;
  bottom: -3rem;
  left: 0; right: 0;
  color: #FFFFFF;
  text-align: center;
  font-size: 1rem;
  padding: 1rem;
}

.lightbox-counter {
  position: absolute;
  bottom: -5rem;
  left: 50%;
  transform: translateX(-50%);
  color: #FFFFFF;
  font-size: 0.875rem;
}

.lightbox-close {
  position: absolute;
  top: -3rem; right: 0;
  background: transparent;
  border: none;
  color: #FFFFFF;
  font-size: 2rem;
  cursor: pointer;
  padding: 0.5rem 1rem;
  transition: color 150ms;
}

.lightbox-close:hover {
  color: #6E9180;
}

.lightbox-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: #FFFFFF;
  font-size: 2rem;
  cursor: pointer;
  padding: 1rem;
  border-radius: 0.25rem;
  transition: background 150ms;
}

.lightbox-nav:hover {
  background: rgba(255, 255, 255, 0.2);
}

.lightbox-prev { left: 2rem; }
.lightbox-next { right: 2rem; }
</style>
```

---

## API Endpoints

### GET `/api/artists/:id/studio-page`

**Purpose**: Fetch hero section data

**Response**:
```json
{
  "hero": {
    "intro_text": "Come behind the scenes...",
    "background_image_url": "https://..."
  }
}
```

### GET `/api/artists/:id/studio-images`

**Purpose**: Fetch all studio images for gallery

**Query Parameters**:
- `include_count`: boolean (default: true) - include total count
- `limit`: integer (default: 100) - max images to return

**Response**:
```json
{
  "images": [
    {
      "id": "uuid",
      "caption": "My studio workspace",
      "category": "studio",
      "display_order": 0,
      "image_url": "https://...",
      "alt_text": "..."
    },
    ...
  ],
  "total": 9
}
```

### POST `/api/artists/:id/studio-images`

**Purpose**: Upload new studio image (Dashboard only)

**Request**:
```multipart
file: (image file)
caption: "Description"
category: "studio|process|other"
```

**Response**:
```json
{
  "id": "uuid",
  "caption": "Description",
  "category": "studio",
  "display_order": 10,
  "image_url": "https://...",
  "message": "Image uploaded successfully"
}
```

### PATCH `/api/artists/:id/studio-images/:image_id`

**Purpose**: Update image caption/category/order

**Request**:
```json
{
  "caption": "Updated caption",
  "category": "process",
  "display_order": 5
}
```

**Response**:
```json
{
  "id": "uuid",
  "caption": "Updated caption",
  "category": "process",
  "display_order": 5,
  "message": "Image updated"
}
```

### DELETE `/api/artists/:id/studio-images/:image_id`

**Purpose**: Delete studio image

**Response**:
```json
{
  "message": "Image deleted successfully"
}
```

### PATCH `/api/artists/:id/studio-page`

**Purpose**: Update studio intro text and hero image

**Request**:
```json
{
  "studio_intro_text": "New intro...",
  "studio_hero_image_id": "uuid" (optional - image to use as hero)
}
```

**Response**:
```json
{
  "studio_intro_text": "New intro...",
  "background_image_url": "https://...",
  "message": "Studio page updated"
}
```

---

## Implementation Sequence

### Week 1: Backend Setup

**Day 1-2: Database & Models**
- [ ] Verify/create `studio_images` table schema
- [ ] Add `studio_intro_text` to `artists` table
- [ ] Update `StudioImage` model with validations
- [ ] Add `Artist` -> `StudioImage` relationship
- [ ] Write database migrations

**Day 3-4: API Endpoints**
- [ ] Create `Api::StudioImagesController`
- [ ] Implement GET /api/artists/:id/studio-images
- [ ] Implement GET /api/artists/:id/studio-page
- [ ] Implement POST /api/artists/:id/studio-images (file upload)
- [ ] Implement PATCH /api/artists/:id/studio-images/:image_id
- [ ] Implement DELETE /api/artists/:id/studio-images/:image_id
- [ ] Implement PATCH /api/artists/:id/studio-page

**Day 5: Authorization & Testing**
- [ ] Add authorization checks (artist can only edit own content)
- [ ] Write unit tests for models
- [ ] Write integration tests for API endpoints

### Week 2: Dashboard Settings Page

**Day 1-2: Upload & List Components**
- [ ] Create `StudioUploadZone` component (Stimulus controller)
- [ ] Implement drag & drop file upload
- [ ] Implement file validation (type, size)
- [ ] Create `StudioImageList` component
- [ ] Display uploaded images in table

**Day 3-4: Edit & Reorder**
- [ ] Implement inline caption editing
- [ ] Implement category dropdown
- [ ] Implement delete with confirmation
- [ ] Create drag-to-reorder functionality (Stimulus + CSS)
- [ ] Auto-save changes via API

**Day 5: Integration & Polish**
- [ ] Create intro text section (textarea + word counter)
- [ ] Wire up form submission
- [ ] Add success/error messages
- [ ] Test form validation
- [ ] Mobile responsiveness

### Week 3: Public Page & Testing

**Day 1-2: Public Page Components**
- [ ] Create `StudioHero` component
- [ ] Implement hero background image display
- [ ] Create `GalleryGrid` component with masonry layout
- [ ] Create `ImageCard` component with badge
- [ ] Implement responsive breakpoints

**Day 3-4: Lightbox & Interactions**
- [ ] Create `ImageLightbox` modal
- [ ] Implement previous/next navigation
- [ ] Implement keyboard navigation (arrows, ESC)
- [ ] Add image counter
- [ ] Implement lazy loading for images

**Day 5: Testing & Optimization**
- [ ] Cross-browser testing
- [ ] Mobile responsiveness testing
- [ ] Accessibility testing (WCAG AA)
- [ ] Performance optimization
- [ ] Image optimization (lazy load, CDN)

---

## Testing Strategy

### Unit Tests

**Backend**:
- `StudioImage` model validations
- Slug generation for artist URLs
- Authorization checks

**Frontend**:
- Word counter functionality
- Caption validation
- Category selection

### Integration Tests

**Dashboard**:
- Upload image → appears in list
- Edit caption → saves via API
- Change category → updates display
- Drag to reorder → updates display order
- Delete image → removes from list with confirmation

**Public Page**:
- Images render in correct grid positions
- Lightbox opens and closes
- Previous/Next navigation works
- Keyboard navigation works (arrows, ESC)
- Page responsive at all breakpoints

### Visual Tests

- Hero section displays background image correctly
- Grid layout matches design at desktop/tablet/mobile
- Category badges display with correct colors
- Hover effects work smoothly
- Lightbox overlay and styling is correct

### Accessibility Tests

- Keyboard navigation through all elements
- Screen reader announces images and captions
- Color contrast meets WCAG AA (4.5:1)
- Focus indicators visible
- Form labels properly associated

### Performance Tests

- Images lazy load below fold
- Lightbox preloads next/prev images
- CSS animations are smooth (60fps)
- Page loads in under 3 seconds
- No console errors/warnings

---

## Success Criteria

### Dashboard Settings Page
- ✅ Can upload multiple images at once
- ✅ Can edit caption inline with character counter
- ✅ Can change category for each image
- ✅ Can drag to reorder images
- ✅ Can delete images with confirmation
- ✅ Changes auto-save or submit via form
- ✅ Can write and save intro text (max 100 words)
- ✅ Shows error messages for validation failures
- ✅ Mobile-responsive and touch-friendly

### Public Page
- ✅ Hero section displays with background image
- ✅ Gallery renders in correct 12-column masonry layout
- ✅ Images display with category badges
- ✅ Captions display below images
- ✅ Hover effects work (elevation + shadow)
- ✅ Lightbox opens when clicking image
- ✅ Can navigate prev/next in lightbox
- ✅ Keyboard navigation works (arrows, ESC)
- ✅ Page responsive at desktop/tablet/mobile sizes
- ✅ Images lazy load for performance
- ✅ Accessibility passes WCAG AA

---

## Questions Before Starting

1. **Framework choice**: Rails, another backend framework?
2. **Frontend**: Using Stimulus for interactivity? React components?
3. **Image hosting**: Active Storage + S3, or simpler solution?
4. **Drag library**: Build custom with Stimulus or use SortableJS?
5. **Form handling**: Traditional form submission or API-driven?
6. **Authentication**: How are artists currently logged in to dashboard?

---

**Document Created**: 2025-11-22
**Status**: Ready for implementation
**Owner**: Development Team
