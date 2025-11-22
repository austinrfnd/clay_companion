# Quick Reference: Resume Tomorrow

## TL;DR This Session

✅ **Backend 100% Done** - Ready for frontend
- Database migrations (2)
- API controllers (2)
- Models updated (2)
- Tests written (85+)
- Docs complete (4)

---

## Tomorrow's Starting Point

**Branch**: `feature/studio-dashboard`
**First Task**: Add routes to `config/routes.rb`

```ruby
# Add to config/routes.rb in Rails.application.routes.draw block
namespace :api do
  scope '/artists/:artist_id' do
    resources :studio_images, only: [:index, :show, :create, :update, :destroy]
    resource :studio_page, only: [:show, :update]
  end
end
```

**Then Run Tests**:
```bash
bundle exec rspec spec/requests/api/
# Should pass ~40 tests
```

---

## What Each API Endpoint Does

### Studio Images
```
GET    /api/artists/:id/studio-images       → List all images (public)
GET    /api/artists/:id/studio-images/:id   → Get one image (public)
POST   /api/artists/:id/studio-images       → Upload new (auth required)
PATCH  /api/artists/:id/studio-images/:id   → Update caption/category (auth required)
DELETE /api/artists/:id/studio-images/:id   → Delete image (auth required)
```

### Studio Page (Hero)
```
GET    /api/artists/:id/studio-page         → Get hero data (public)
PATCH  /api/artists/:id/studio-page         → Update intro + hero image (auth required)
```

---

## Three Main Views to Build

### 1. Dashboard Settings Page
**URL**: `/dashboard/settings/studio`
**File**: `app/views/dashboard/settings/studio.html.erb`

Components:
- Hero image selector (radio buttons)
- Intro text textarea (word counter)
- Photo upload zone (drag & drop)
- Image list (edit/delete/reorder)

**Reference**: `requirements/wireframes/dashboard/studio-settings.md`

### 2. Public Gallery Page
**URL**: `/artists/:name/process` (or `/artists/:name/studio`)
**File**: `app/views/artists/process_studio.html.erb`

Components:
- Hero section (background image)
- Gallery grid (12-column masonry)
- Image cards (badges + captions)
- Lightbox modal (click image)

**Reference**: `requirements/wireframes/process-studio-preview.html`

### 3. Four Stimulus Controllers

```
studio_upload_controller.js      → Drag/drop upload
studio_reorder_controller.js     → Drag to reorder images
auto_save_controller.js          → Auto-save on field change
word_counter_controller.js       → Count words in textarea
```

---

## Key Implementation Details

### Hero Image Selection
- Optional (can be NULL)
- Radio buttons with 120px thumbnails
- Shows 300px preview of current hero
- Auto-saves on selection

### Category System
```
'studio'   → Behind-the-scenes studio photos
'process'  → Making/working process photos
'other'    → Miscellaneous photos
```

### Display Order
- Auto-assigned on create: `max(display_order) + 1`
- Can be updated for drag-to-reorder
- Always query with `.ordered` scope

### Authorization
```
1. Authenticate (Devise)
   └─ Returns 401 if not logged in

2. Load Resource
   └─ Returns 404 if not found

3. Verify Ownership
   └─ Returns 404 if not the artist's image
```

---

## File Structure (What to Create)

```
app/views/dashboard/settings/
  ├─ studio.html.erb                    (Main form)
  ├─ _hero_image_section.html.erb       (Hero selector)
  ├─ _upload_zone.html.erb              (Upload area)
  └─ _image_list.html.erb               (Images list)

app/views/artists/
  ├─ process_studio.html.erb            (Public gallery)
  ├─ _studio_hero.html.erb              (Hero section)
  ├─ _gallery_grid.html.erb             (Grid layout)
  ├─ _image_card.html.erb               (Image card)
  └─ _lightbox.html.erb                 (Modal)

app/javascript/controllers/
  ├─ studio_upload_controller.js        (Upload handling)
  ├─ studio_reorder_controller.js       (Drag reorder)
  ├─ auto_save_controller.js            (Auto-save)
  └─ word_counter_controller.js         (Word count)

app/assets/stylesheets/
  ├─ dashboard/studio_settings.css
  └─ artist_process_studio.css
```

---

## Responsive Breakpoints

```
Mobile:    320px - 767px   (1 column)
Tablet:    768px - 1023px  (8-col grid)
Desktop:   1024px+         (12-col grid)
```

---

## API Response Examples

### GET /api/artists/abc123/studio-images
```json
{
  "images": [
    {
      "id": "img-uuid",
      "caption": "My studio workspace",
      "category": "studio",
      "display_order": 0,
      "image_url": "https://...",
      "alt_text": "..."
    }
  ],
  "total": 1
}
```

### GET /api/artists/abc123/studio-page
```json
{
  "hero": {
    "intro_text": "Come see my studio...",
    "background_image_url": "https://...",
    "title": "Studio & Process"
  }
}
```

### POST /api/artists/abc123/studio-images
```json
{
  "id": "img-uuid",
  "caption": "...",
  "category": "studio",
  "display_order": 0,
  "image_url": "https://...",
  "message": "Image uploaded successfully"
}
```

---

## Testing Tips

### Run All Tests
```bash
bundle exec rspec spec/requests/api/studio_images_spec.rb
bundle exec rspec spec/requests/api/studio_page_spec.rb
bundle exec rspec spec/models/artist_spec.rb
bundle exec rspec spec/models/studio_image_spec.rb
```

### Test Specific Test
```bash
bundle exec rspec spec/requests/api/studio_images_spec.rb:25
```

### Test with Output
```bash
bundle exec rspec spec/ -fd
```

---

## Important Models Info

### Artist
```ruby
has_many :studio_images, dependent: :destroy
belongs_to :studio_hero_image, class_name: 'StudioImage', optional: true
validates :studio_intro_text, length: { maximum: 600 }
```

### StudioImage
```ruby
belongs_to :artist
enum category: { studio: 'studio', process: 'process', other: 'other' }
validates :category, presence: true
scope :ordered, -> { order(display_order: :asc, created_at: :asc) }
scope :by_artist, ->(artist_id) { where(artist_id: artist_id) }
scope :by_category, ->(category) { where(category: category) }
```

---

## Key Constants

**Caption max length**: 150 characters
**Intro text max length**: 600 characters (~100 words)
**Image file size limit**: 5 MB
**Allowed image types**: JPG, PNG, HEIC
**Upload limit**: 10 images per request
**Display order**: Auto-assigned (max + 1)

---

## Resources Available

- `DEVELOPMENT_PLAN_PROCESS_STUDIO.md` - Full architecture
- `IMPLEMENTATION_SUMMARY_STUDIO_FEATURE.md` - Backend summary
- `SESSION_HANDOFF_STUDIO_FEATURE.md` - Detailed handoff (THIS LONG VERSION)
- `docs/AUTHORIZATION_PATTERN.md` - Security docs
- `requirements/wireframes/dashboard/studio-settings.md` - Dashboard design
- `requirements/wireframes/process-studio-preview.html` - Public page HTML reference
- Tests in `spec/requests/api/` - Show expected behavior

---

## First 3 Commands Tomorrow

```bash
# 1. Update routes
# (Edit config/routes.rb - add API routes above ↑)

# 2. Run tests
bundle exec rspec spec/requests/api/

# 3. Start server
rails server
# Visit http://localhost:3000/dashboard/settings/studio (will 404 until view created)
```

---

## Success = ...

- ✅ API routes added
- ✅ Tests passing
- ✅ Dashboard form displays
- ✅ Photos upload working
- ✅ Public gallery displays
- ✅ Lightbox opens/closes
- ✅ Mobile responsive
- ✅ No console errors

Then you're done! 🎉

---

**See `SESSION_HANDOFF_STUDIO_FEATURE.md` for full details**
