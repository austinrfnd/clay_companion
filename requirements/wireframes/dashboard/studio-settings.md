# Studio Settings Page - Wireframe

**URL**: `claycompanion.com/dashboard/settings/studio`

**Purpose**: Allow authenticated artists to manage their studio and process page content: intro text, studio/process photos with captions, and display order.

**Reference**: Part of the Settings hub structure. This page manages content for the public-facing Process/Studio page (`/artist-name/process`).

---

## Key Design Decisions

1. **Photo Management Focus**: Upload, caption, categorize, and reorder studio/process images
2. **Optional Intro Text**: Brief paragraph about workspace or process (100 words max)
3. **Drag & Drop Upload**: Support multiple image uploads at once
4. **Visual Reordering**: Drag-and-drop to change display order
5. **Category System**: Organize images as Studio, Process, or Other
6. **Inline Editing**: Edit captions and categories directly in the list
7. **Persistent Sidebar**: Settings menu always visible on left (desktop)
8. **Post-MVP Videos**: Video embeds planned for future phase

---

## Shared Components

This page uses the same **Design System Colors**, **Typography**, **Spacing**, **Form Input Patterns**, **Button Patterns**, and **Accessibility Standards** as defined in the auth wireframes and `requirements/DESIGN_SYSTEM.md`.

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Clay Companion                    [Dashboard] [Settings ▼] [Sign Out]      │
│  (Dashboard Header - Navigation)                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│  ┌──────────────────┐  ┌──────────────────────────────────────────────┐  │
│  │                  │  │  Studio Settings                              │  │
│  │  Settings Menu   │  │  (H1, 48px/3rem, Bold 700, Charcoal #1F2421)│  │
│  │  (Sidebar)       │  │                                                 │  │
│  │                  │  │  Manage your studio and process page:         │  │
│  │  ┌────────────┐  │  │  upload photos, add captions, and organize    │  │
│  │  │ 👤 Account │  │  │  your behind-the-scenes content.              │  │
│  │  └────────────┘  │  │  (Body Large, 18px/1.125rem, Slate #5C6C62)  │  │
│  │                  │  │                                                 │  │
│  │  ┌────────────┐  │  │  ┌──────────────────────────────────────┐    │  │
│  │  │ 🔒 Privacy │  │  │  │ Hero Image (Background)                │    │  │
│  │  └────────────┘  │  │  │ (H2, 36px/2.25rem, Bold 700)         │    │  │
│  │                  │  │  │                                      │    │  │
│  │  ┌────────────┐  │  │  │  Current Hero Image Preview:          │    │  │
│  │  │ 📝 Profile │  │  │  │  ┌──────────────────────────────────┐ │    │  │
│  │  └────────────┘  │  │  │  │                                  │ │    │  │
│  │                  │  │  │  │  [Selected hero image preview]   │ │    │  │
│  │  ┌────────────┐  │  │  │  │  (300px height)                 │ │    │  │
│  │  │ 🏠 Studio  │  │  │  │  │                                  │ │    │  │
│  │  │    (Active)│  │  │  │  └──────────────────────────────────┘ │    │  │
│  │  └────────────┘  │  │  │                                      │    │  │
│  │                  │  │  │  Select an image as hero background: │    │  │
│  │  ┌────────────┐  │  │  │                                      │    │  │
│  │  │ 🎨 My Work │  │  │  │  ☐ [IMG Thumbnail 1]  ☑ [IMG 2]    │    │  │
│  │  └────────────┘  │  │  │     Caption 1          Caption 2    │    │  │
│  │                  │  │  │                                      │    │  │
│  │  (240px width)   │  │  │  ☐ [IMG Thumbnail 3]                │    │  │
│  │  └──────────────────┘  │     Caption 3                        │    │  │
│  │                        │                                      │    │  │
│  │                        │  ☐ Use default background            │    │  │
│  │                        │                                      │    │  │
│  │                        │  Helper: Choose from uploaded photos │    │  │
│  │                        │  or upload a new one. Landscape      │    │  │
│  │                        │  images work best.                    │    │  │
│  │                        │  └──────────────────────────────────────┘    │  │
│  │                        │                                                 │  │
│  │                        │  ┌──────────────────────────────────────┐    │  │
│  │                        │  │ Introduction Text                     │    │  │
│  │                        │  │ (H2, 36px/2.25rem, Bold 700)         │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  │  Studio Introduction (Optional)      │    │  │
│  │                        │  │  [Textarea - 80px min-height]        │    │  │
│  │                        │  │  Brief intro about your workspace    │    │  │
│  │                        │  │  or process (max 100 words)          │    │  │
│  │                        │  │  Word counter: X / 100               │    │  │
│  │                        │  └──────────────────────────────────────┘    │  │
│  │                        │                                                 │  │
│  │                        │  ┌──────────────────────────────────────┐    │  │
│  │                        │  │ Studio & Process Photos               │    │  │
│  │                        │  │ (H2, 36px/2.25rem, Bold 700)         │    │  │
│  │  │ 🎨 My Work │  │  │  │                                      │    │  │
│  │  └────────────┘  │  │  │  ┌────────────────────────────────┐  │    │  │
│  │                  │  │  │  │ [📷 Drag & Drop Upload Area]   │  │    │  │
│  │  (240px width)   │  │  │  │ Click or drag photos here      │  │    │  │
│  │  └──────────────────┘  │  │  │ Supports: JPG, PNG, HEIC       │  │    │  │
│  │                        │  │  │ Max 10MB per file              │  │    │  │
│  │                        │  │  └────────────────────────────────┘  │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  │  ┌────────────────────────────────┐  │    │  │
│  │                        │  │  │ ┌──────┐                       │  │    │  │
│  │                        │  │  │ │      │  Image 1               │  │    │  │
│  │                        │  │  │ │ IMG  │  Caption: [_______...] │  │    │  │
│  │                        │  │  │ │      │  Category: [Studio ▼]  │  │    │  │
│  │                        │  │  │ └──────┘  [Delete] [⋮⋮]        │  │    │  │
│  │                        │  │  │           (Drag handle)         │  │    │  │
│  │                        │  │  └────────────────────────────────┘  │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  │  ┌────────────────────────────────┐  │    │  │
│  │                        │  │  │ ┌──────┐                       │  │    │  │
│  │                        │  │  │ │ IMG  │  Image 2               │  │    │  │
│  │                        │  │  │ └──────┘  Caption: [_______...] │  │    │  │
│  │                        │  │  │           Category: [Process▼]  │  │    │  │
│  │                        │  │  │           [Delete] [⋮⋮]        │  │    │  │
│  │                        │  │  └────────────────────────────────┘  │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  │  (Drag to reorder images)            │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  │  Empty State (if no images):         │    │  │
│  │                        │  │  📷 No studio photos yet             │    │  │
│  │                        │  │  Upload photos to get started        │    │  │
│  │                        │  │                                      │    │  │
│  │                        │  └──────────────────────────────────────┘    │  │
│  │                        │                                                 │  │
│  │                        │  [Cancel]  [Save Changes]                      │  │
│  │                        │                                                 │  │
│  │                        └─────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Form Field Specifications

### 1. Hero Image Selection (FIRST - Displayed at Top)

**Hero Image (Background for Public Page)**:
- **Purpose**: Allow artist to select which uploaded photo appears as the background of the hero section on the public Studio & Process page
- **Priority**: This section appears FIRST, before intro text and photo uploads, so users can immediately set their hero image
- **Display**: Large preview box showing currently selected hero image (300px height, full width)
- **Selection Method**: Radio buttons with thumbnail previews for each uploaded image
- **Thumbnails**: 120px height, 200px wide cards arranged in responsive grid
- **Selected State**: Green border (#6E9180) + subtle shadow highlight
- **Options**:
  - Radio button for each uploaded studio image (caption as label)
  - Checkbox to "Use default background" (no custom image, uses gradient)
- **Helper Text**: "Choose from your uploaded photos below, or upload a new one. Images work best when they are landscape-oriented." - 14px, Slate (#5C6C62)
- **Auto-save**: Selection updates immediately via API without manual save
- **Empty State**: If no images uploaded yet, show message: "Upload photos below to select a hero image"

**Layout**:
```
┌─────────────────────────────────────────────┐
│ Hero Image (Background)                     │
│ (H2, 36px/2.25rem, Bold 700)                │
│                                             │
│ Current Hero Image Preview:                 │
│ ┌─────────────────────────────────────────┐ │
│ │                                         │ │
│ │     [Selected hero image preview]       │ │
│ │     (300px height, full width)          │ │
│ │                                         │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ Select an image as hero background:         │
│                                             │
│ ☐ [IMG Thumbnail 1]  ☑ [IMG Thumbnail 2]   │
│    Caption 1            Caption 2 (Selected)│
│                                             │
│ ☐ [IMG Thumbnail 3]                        │
│    Caption 3                                │
│                                             │
│ ☐ Use default background (no custom image) │
│                                             │
│ Helper: Choose from your uploaded photos   │
│ below, or upload a new one. Images work    │
│ best when they are landscape-oriented.      │
│                                             │
└─────────────────────────────────────────────┘
```

---

### 2. Introduction Text Area

**Studio Introduction (Optional)**:
- **Label**: "Studio Introduction (Optional)" - 16px, Medium 500, Charcoal
- **Min Height**: 80px (5rem) - ~4-5 lines
- **Max Height**: Expands vertically (up to ~200px)
- **Padding**: 12px (0.75rem) all sides
- **Font**: Inter, 16px (1rem), Regular 400
- **Line Height**: 1.6
- **Resize**: Vertical only
- **Max Length**: 100 words (approximately 600 characters)
- **Border**: 1px solid rgba(168, 196, 181, 0.5) - Pale Celadon at 50% opacity
- **Border Radius**: 8px (0.5rem) - MD
- **Background**: White (#FFFFFF)
- **Focus**: 2px solid Celadon Green (#6E9180) outline, 2px offset
- **Helper Text**: "Brief intro about your workspace or process (max 100 words)" - 14px, Slate
- **Word Counter**: Right-aligned below textarea, 12px, Slate (#5C6C62)
  - Format: "X / 100 words"
  - Color changes to Warning Orange (#D68500) when approaching limit (90+)
  - Color changes to Error Red (#C73030) when over limit

---

### 3. Photo Upload Area

**Drag & Drop Zone**:
- **Width**: Full width of content area (max 800px)
- **Height**: 200px (12.5rem)
- **Border**: 2px dashed rgba(168, 196, 181, 0.5) - Pale Celadon
- **Border Radius**: 8px (0.5rem)
- **Background**: Misty White (#F8FAF9)
- **Icon**: 📷 Camera icon, 48px, Slate (#5C6C62), centered
- **Text**: "Click or drag photos here" - 18px, Medium 500, Charcoal
- **Subtext**: "Supports: JPG, PNG, HEIC • Max 10MB per file" - 14px, Slate
- **Hover**: Border color changes to Celadon Green (#6E9180)
- **Active (dragging)**: Background changes to Pale Celadon (#A8C4B5) at 20% opacity
- **Focus**: 2px solid Celadon Green outline, 2px offset (keyboard accessible)

**Upload Progress** (when uploading):
- Show progress bar below upload zone
- Display "Uploading X of Y images..."
- Individual file progress indicators

**Accepted File Types**:
- JPG, JPEG, PNG, HEIC
- Max file size: 10MB per image
- Bulk upload: up to 10 images at once

---

### 4. Image List Items

**Image Card Container**:
- **Layout**: Horizontal (thumbnail + fields + actions)
- **Width**: Full width of content area
- **Padding**: 16px (1rem) all sides
- **Margin Bottom**: 16px (1rem) between cards
- **Border**: 1px solid rgba(168, 196, 181, 0.3) - Pale Celadon at 30%
- **Border Radius**: 8px (0.5rem)
- **Background**: White (#FFFFFF)
- **Hover**: Slight shadow (0 2px 4px rgba(0,0,0,0.05))
- **Dragging**: Elevated shadow, 50% opacity

**Image Thumbnail**:
- **Size**: 120px × 120px (7.5rem square)
- **Border Radius**: 4px (0.25rem)
- **Object Fit**: Cover (maintain aspect ratio)
- **Border**: 1px solid rgba(168, 196, 181, 0.3)
- **Position**: Left side of card
- **Loading**: Skeleton placeholder with pulse animation

**Caption Field**:
- **Type**: Text input
- **Label**: "Caption" - 14px, Medium 500, Charcoal
- **Height**: 40px (2.5rem)
- **Width**: Flexible (grows with container)
- **Padding**: 8px (0.5rem) horizontal
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Max Length**: 150 characters
- **Placeholder**: "Describe this photo..."
- **Border**: 1px solid rgba(168, 196, 181, 0.5)
- **Border Radius**: 4px (0.25rem)
- **Focus**: 2px solid Celadon Green outline, 2px offset

**Category Dropdown**:
- **Label**: "Category" - 14px, Medium 500, Charcoal
- **Height**: 40px (2.5rem)
- **Width**: 150px
- **Options**:
  - Studio
  - Process
  - Other
- **Default**: Studio
- **Border**: 1px solid rgba(168, 196, 181, 0.5)
- **Border Radius**: 4px (0.25rem)
- **Focus**: 2px solid Celadon Green outline, 2px offset
- **Icon**: Chevron down icon on right

**Drag Handle**:
- **Icon**: ⋮⋮ (6 dots, 2×3 grid) or ☰ (hamburger)
- **Size**: 24px × 24px
- **Color**: Slate (#5C6C62)
- **Position**: Far right of card
- **Cursor**: grab (when not dragging), grabbing (when dragging)
- **Hover**: Color changes to Celadon Green
- **Accessible**: Keyboard shortcuts for reordering (Alt+Up/Down)

**Delete Button**:
- **Text**: "Delete" or 🗑️ icon
- **Size**: 14px font, 32px × 32px touch target
- **Color**: Slate (#5C6C62)
- **Hover**: Error Red (#C73030)
- **Confirmation**: "Are you sure?" dialog before deletion
- **Position**: Next to drag handle

---

## Section Spacing

- **Between Sections**: 48px (3rem) vertical spacing
- **Within Sections**: 24px (1.5rem) between form elements
- **Section Headings**: 32px (2rem) margin bottom
- **Form Actions**: 48px (3rem) top margin from last section
- **Image Cards**: 16px (1rem) between each card

---

## Typography

- **Page Title (H1)**: 48px (3rem), Bold 700, Charcoal (#1F2421)
- **Page Description**: 18px (1.125rem), Regular 400, Slate (#5C6C62)
- **Section Headings (H2)**: 36px (2.25rem), Bold 700, Charcoal (#1F2421)
- **Field Labels**: 16px (1rem), Medium 500, Charcoal (#1F2421)
- **Input Text**: 16px (1rem), Regular 400, Charcoal (#1F2421)
- **Helper Text**: 14px (0.875rem), Regular 400, Slate (#5C6C62)
- **Counters**: 12px (0.75rem), Regular 400, Slate (#5C6C62)
- **Button Text**: 16px (1rem), Medium 500

---

## Colors

- **Background**: Misty White (#F8FAF9) for page, White (#FFFFFF) for cards
- **Text**: Charcoal (#1F2421) for headings/labels, Slate (#5C6C62) for body/helpers
- **Borders**: Pale Celadon (#A8C4B5) at 30-50% opacity
- **Primary Actions**: Celadon Dark (#527563)
- **Hover States**: Celadon Green (#6E9180)
- **Error**: Error Red (#C73030)
- **Warning**: Warning Orange (#D68500)
- **Success**: Success Green (#4A7C59)

---

## Buttons

**Primary Button** (Save Changes):
- **Background**: Celadon Dark (#527563)
- **Text**: White (#FFFFFF), 16px (1rem), Medium 500
- **Padding**: 12px (0.75rem) vertical, 24px (1.5rem) horizontal
- **Border Radius**: 8px (0.5rem) - MD
- **Height**: 48px (3rem)
- **Hover**: Background darkens to #3E5A4A
- **Focus**: 2px Celadon Green outline, 2px offset
- **Disabled**: Background Gray (#9CA3AF), cursor not-allowed

**Secondary Button** (Cancel):
- **Background**: Transparent
- **Text**: Slate (#5C6C62), 16px (1rem), Medium 500
- **Border**: 1px solid Pale Celadon (#A8C4B5)
- **Padding**: Same as primary
- **Hover**: Misty White (#F8FAF9) background
- **Focus**: 2px Celadon Green outline, 2px offset

**Delete Button** (within image card):
- **Text**: "Delete" or 🗑️ icon
- **Color**: Slate (#5C6C62)
- **Background**: Transparent
- **Hover**: Text color changes to Error Red (#C73030)
- **Size**: 14px font, 32px minimum touch target

---

## Empty States

### No Images Uploaded

When no studio images exist:

```
┌────────────────────────────────────┐
│                                    │
│           📷                       │
│     No studio photos yet           │
│                                    │
│  Upload photos of your workspace,  │
│  tools, and making process to      │
│  share with visitors.              │
│                                    │
│  [Upload Your First Photo]         │
│                                    │
└────────────────────────────────────┘
```

- **Icon**: 📷 Camera, 64px, Slate (#5C6C62)
- **Heading**: "No studio photos yet" - 24px, Bold 600, Charcoal
- **Description**: 16px, Regular 400, Slate, max 2 lines
- **CTA Button**: Primary button style
- **Background**: Misty White (#F8FAF9)
- **Padding**: 48px (3rem) all sides
- **Border**: 1px dashed Pale Celadon (#A8C4B5)
- **Border Radius**: 8px

---

## JavaScript Interactions

### Photo Upload (Stimulus Controller)

**Features**:
- Drag and drop file handling
- Click to browse file picker
- Multiple file selection
- File type validation
- File size validation (max 10MB)
- Upload progress indicators
- Error handling for failed uploads
- Preview thumbnails before upload

**Controller**: `photo_upload_controller.js` (reuse from profile setup)

**Events**:
- `dragover`: Highlight drop zone
- `drop`: Process files
- `change`: Handle file input change
- Upload progress: Show progress bars

---

### Drag-and-Drop Reordering (Stimulus Controller)

**Features**:
- Drag handle on each image card
- Visual feedback when dragging (opacity, shadow)
- Drop zones between cards
- Update `display_order` field on drop
- Smooth animations
- Keyboard accessible (Alt+Up/Down to reorder)
- Auto-save order or manual save

**Controller**: `sortable_list_controller.js` or similar

**Library Option**: SortableJS or Stimulus SortableJS wrapper

**Events**:
- `dragstart`: Capture dragged element
- `dragover`: Show drop indicator
- `drop`: Reorder and update positions
- Save to backend via AJAX

---

### Inline Caption Editing

**Features**:
- Edit captions directly in the list
- Auto-save on blur or manual save
- Character counter (150 chars max)
- Validation feedback

**Controller**: `auto_save_controller.js` or inline editing

**Events**:
- `blur`: Save changes to backend
- `input`: Update character counter

---

### Delete Confirmation

**Features**:
- Confirmation dialog before deleting image
- "Are you sure?" with Yes/No options
- Optimistic UI removal on confirmation
- Undo option (optional, post-MVP)

**Implementation**:
- Browser native `confirm()` or custom modal
- Turbo Frame for partial page updates

---

## Accessibility

### Semantic HTML

- `<main>` for page content
- `<section>` for each major form section
- `<form>` for the entire settings form
- Proper heading hierarchy (H1 → H2)
- `<label>` elements for all inputs (visible or `aria-label`)
- `<ul>` or `<ol>` for image list (semantically a list)

### ARIA Labels

- Upload zone: `role="button"` and `aria-label="Upload studio photos"`
- Drag handles: `aria-label="Drag to reorder image"`
- Delete buttons: `aria-label="Delete image: [caption]"`
- Form sections: `aria-labelledby` pointing to section headings

### Keyboard Navigation

- **Tab Order**: Through all form fields, upload zone, image cards, buttons
- **Enter Key**: Activates buttons and upload zone
- **Space Key**: Activates buttons
- **Drag Handle**: Alt+Up/Down to reorder images (keyboard alternative)
- **Delete**: Enter or Space on delete button (with confirmation)
- **Focus Indicators**: 2px solid Celadon Green outline, 2px offset, visible on all interactive elements

### Screen Reader Support

- Upload zone announces drag-and-drop capability
- Image cards announce caption and category
- Upload progress announced as it updates
- Success/error messages announced via `aria-live="polite"` regions
- Form validation errors associated with fields via `aria-describedby`

### Image Alt Text

- Thumbnails: Use caption as alt text, or "Studio photo [number]" if no caption

---

## Responsive Breakpoints

### Mobile (320px - 767px)

```
┌───────────────────────────────┐
│  Clay Companion        ☰ Menu │
└───────────────────────────────┘

┌───────────────────────────────┐
│  Studio Settings               │
│  (H1, 32px, Bold 700)          │
│                                │
│  Manage your studio and        │
│  process page.                 │
│                                │
│  ┌────────────────────────┐   │
│  │ Introduction Text      │   │
│  │ [Textarea]             │   │
│  │ Word counter: X / 100  │   │
│  └────────────────────────┘   │
│                                │
│  ┌────────────────────────┐   │
│  │ Studio & Process Photos│   │
│  │                        │   │
│  │ [📷 Upload Area]       │   │
│  │ Tap to upload          │   │
│  └────────────────────────┘   │
│                                │
│  ┌────────────────────────┐   │
│  │ ┌────┐                 │   │
│  │ │IMG │ Image 1         │   │
│  │ └────┘                 │   │
│  │ Caption: [_________]   │   │
│  │ Category: [Studio ▼]   │   │
│  │ [Delete]               │   │
│  └────────────────────────┘   │
│                                │
│  ┌────────────────────────┐   │
│  │ ┌────┐ Image 2         │   │
│  │ │IMG │                 │   │
│  │ └────┘                 │   │
│  │ Caption: [_________]   │   │
│  │ Category: [Process ▼]  │   │
│  │ [Delete]               │   │
│  └────────────────────────┘   │
│                                │
│  [Cancel]  [Save Changes]     │
│                                │
└───────────────────────────────┘
```

**Changes from Desktop**:
- Sidebar hidden, hamburger menu
- H1 reduced to 32px (2rem)
- Upload area: Tap instead of drag-and-drop
- Image cards: Stacked vertically
- Thumbnail: 80px × 80px
- Caption/category: Full width, stacked
- No drag handles (manual reorder via move up/down buttons or post-MVP)
- Padding: 16px (1rem) instead of 24px

---

### Tablet (768px - 1023px)

```
┌────────────────────────────────────────────────────┐
│  Clay Companion        [Dashboard] [Settings ▼] [Sign Out]  │
└────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────┐
│  ☰  Studio Settings                                │
│  (Sidebar collapsible/toggle)                      │
│                                                    │
│  ┌──────────────────────────────────────────┐     │
│  │ Introduction Text                        │     │
│  │ [Textarea]                               │     │
│  │ Word counter: X / 100                    │     │
│  └──────────────────────────────────────────┘     │
│                                                    │
│  ┌──────────────────────────────────────────┐     │
│  │ Studio & Process Photos                  │     │
│  │ [📷 Drag & Drop Upload Area]            │     │
│  └──────────────────────────────────────────┘     │
│                                                    │
│  ┌──────────────────────────────────────────┐     │
│  │ ┌─────┐  Image 1                        │     │
│  │ │ IMG │  Caption: [____________]         │     │
│  │ └─────┘  Category: [Studio ▼]           │     │
│  │          [Delete] [⋮⋮]                  │     │
│  └──────────────────────────────────────────┘     │
│                                                    │
│  [Cancel]  [Save Changes]                         │
│                                                    │
└────────────────────────────────────────────────────┘
```

**Changes from Desktop**:
- Sidebar collapsible (toggle button)
- Content area: Full width when sidebar collapsed
- Image cards: Horizontal layout maintained
- Drag-and-drop: Enabled

---

## Error Handling

### Upload Errors

**File Too Large** (> 10MB):
- Error message: "File too large. Maximum size is 10MB." - Red, below upload zone
- Icon: ⚠️ Warning
- Dismiss: Auto-dismiss after 5 seconds or manual close

**Invalid File Type**:
- Error message: "Invalid file type. Please upload JPG, PNG, or HEIC images."
- Same styling as above

**Upload Failed** (network error):
- Error message: "Upload failed. Please try again."
- Retry button: "Retry Upload"

### Form Validation Errors

**Empty Required Fields** (if any are made required in future):
- Red border on field
- Error message below field
- Focus on first error field

**Network Error on Save**:
- Toast notification: "Failed to save changes. Please try again."
- Form remains in editable state
- Retry button in toast

---

## Success States

### Upload Success

- Success message: "X photos uploaded successfully" - Green, below upload zone
- Auto-dismiss after 3 seconds
- Smooth fade-in of new image cards

### Save Success

- Toast notification: "Changes saved successfully" - Green, top-right corner
- Checkmark icon: ✓
- Auto-dismiss after 3 seconds
- Optional: Briefly flash saved button with checkmark

---

## Post-MVP Features

### Process Videos Section

**Structure** (similar to image upload):
- Section heading: "Process Videos (Optional)"
- Add video form:
  - Video URL field (YouTube or Vimeo)
  - Caption field
  - Add button
- Video list:
  - Video embed preview (thumbnail)
  - Caption
  - Remove button
- Drag-and-drop reordering

**Implementation**: New model `ProcessVideo` or extend `studio_images` with `category: 'video'`

---

## Database Schema

**Existing `studio_images` table** (already supports this feature):
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artists)
- `caption` (text, nullable)
- `category` (text: studio/process/other)
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

**Images stored via Active Storage**:
- Attached as `image` (has_one_attached :image)

**Addition to `artists` table**:
```ruby
add_column :artists, :studio_intro_text, :text
```

**Migration**:
```ruby
class AddStudioIntroTextToArtists < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :studio_intro_text, :text
  end
end
```

---

## Finalized Decisions

1. ✅ **Layout**: Sidebar navigation + main content area (consistent with other settings pages)
2. ✅ **Upload Method**: Drag & drop + click to browse
3. ✅ **Image Organization**: Caption + category + drag-to-reorder
4. ✅ **Intro Text**: Optional textarea, 100 words max
5. ✅ **Categories**: Studio, Process, Other (via dropdown)
6. ✅ **Videos**: Post-MVP feature
7. ✅ **Database**: Use existing `studio_images` table + Active Storage
8. ✅ **Accessibility**: Full keyboard navigation and screen reader support

---

**Status**: Finalized ✓
**Date**: 2025-01-19
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`.
