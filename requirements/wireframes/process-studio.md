# Process/Studio Page - Wireframe

**URL**: `claycompanion.com/artist-name/process` (or `/studio`)

**Purpose**: Show behind-the-scenes content - workspace, tools, making process, and artist at work

---

## Key Design Decisions

1. **Layout Style**: Photo gallery with captions (simple, visual-first approach)
2. **Content Type**: Mix of studio environment photos and process/making photos
3. **Organization**: Single scrollable gallery with optional intro text
4. **Image Display**: Responsive grid layout (3-col desktop, 2-col tablet, 1-col mobile)
5. **Captions**: Short descriptions below each image (1-2 sentences)
6. **Optional**: Video embeds for process demonstrations

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Artist Name / Logo        Gallery  About  Process  Exhibitions  Press      │
│                                                  Techniques  Contact          │
│  (Navigation Bar - Fixed/Sticky)                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  STUDIO & PROCESS                                                             │
│                                                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  Come behind the scenes and see where the work is made. My studio   │   │
│  │  in Brooklyn is where I spend my days throwing, trimming, glazing,  │   │
│  │  and firing each piece by hand.                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│  (Optional intro paragraph - 1-2 sentences, max 100 words)                   │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐          │
│  │                  │  │                  │  │                  │          │
│  │                  │  │                  │  │                  │          │
│  │   Studio Photo   │  │   Studio Photo   │  │   Studio Photo   │          │
│  │                  │  │                  │  │                  │          │
│  │                  │  │                  │  │                  │          │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘          │
│  My studio workspace   The pottery wheel    Tools & materials              │
│  in Red Hook, Brooklyn in action            I use daily                    │
│                                                                               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐          │
│  │                  │  │                  │  │                  │          │
│  │   Process Photo  │  │   Process Photo  │  │   Process Photo  │          │
│  │                  │  │                  │  │                  │          │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘          │
│  Centering clay on    Trimming the foot    Applying glaze by               │
│  the wheel            of a bowl            hand                             │
│                                                                               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐          │
│  │                  │  │                  │  │                  │          │
│  │   Process Photo  │  │   Process Photo  │  │   Process Photo  │          │
│  │                  │  │                  │  │                  │          │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘          │
│  Loading the kiln     Pieces fresh from    Inspecting finished              │
│  for firing           bisque firing        work                             │
│                                                                               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐          │
│  │   Studio Photo   │  │   Process Photo  │  │   Studio Photo   │          │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘          │
│  Caption text here    Caption text here    Caption text here                │
│                                                                               │
│  (Responsive grid: 3 columns desktop, 2 tablet, 1 mobile)                    │
│  (Continues with more images...)                                             │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  OPTIONAL: PROCESS VIDEOS                                                    │
│                                                                               │
│  ┌────────────────────────────────────┐  ┌───────────────────────────────┐ │
│  │                                    │  │                               │ │
│  │     [YouTube/Vimeo Embed]         │  │    [YouTube/Vimeo Embed]     │ │
│  │                                    │  │                               │ │
│  └────────────────────────────────────┘  └───────────────────────────────┘ │
│  Throwing a bowl on the wheel            Glazing techniques                │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  Footer (Light grey background #f8f9fa)                                      │
│  Contact | Social Links | Copyright | "Powered by Clay Companion"           │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Tablet Layout (768px - 1024px)

```
┌────────────────────────────────────────────────────────┐
│  Artist Name                             ☰ Menu         │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                                                          │
│  STUDIO & PROCESS                                        │
│                                                          │
│  Come behind the scenes and see where the work is        │
│  made. My studio in Brooklyn is where I spend my days    │
│  throwing, trimming, glazing, and firing...              │
│                                                          │
│  ┌──────────────────┐  ┌──────────────────┐            │
│  │                  │  │                  │            │
│  │  Studio Photo    │  │  Studio Photo    │            │
│  │                  │  │                  │            │
│  └──────────────────┘  └──────────────────┘            │
│  Caption text         Caption text                      │
│                                                          │
│  ┌──────────────────┐  ┌──────────────────┐            │
│  │  Process Photo   │  │  Process Photo   │            │
│  └──────────────────┘  └──────────────────┘            │
│  Caption text         Caption text                      │
│                                                          │
│  (2 columns, continues...)                               │
│                                                          │
└────────────────────────────────────────────────────────┘
```

---

## Mobile Layout (320px - 767px)

```
┌───────────────────────────────┐
│  Artist Name          ☰ Menu  │
└───────────────────────────────┘

┌───────────────────────────────┐
│  STUDIO & PROCESS              │
│                                │
│  Come behind the scenes and    │
│  see where the work is made... │
│                                │
│  ┌───────────────────────┐    │
│  │                       │    │
│  │    Studio Photo       │    │
│  │                       │    │
│  └───────────────────────┘    │
│  My studio workspace in        │
│  Red Hook, Brooklyn            │
│                                │
│  ┌───────────────────────┐    │
│  │    Studio Photo       │    │
│  └───────────────────────┘    │
│  Caption text                  │
│                                │
│  ┌───────────────────────┐    │
│  │    Process Photo      │    │
│  └───────────────────────┘    │
│  Caption text                  │
│                                │
│  ┌───────────────────────┐    │
│  │    Process Photo      │    │
│  └───────────────────────┘    │
│  Caption text                  │
│                                │
│  (Continues...)                │
│                                │
│  ┌───────────────────────┐    │
│  │  [Video Embed]        │    │
│  └───────────────────────┘    │
│  Video caption                 │
│                                │
└───────────────────────────────┘
```

---

## Layout Specifications

### Page Container

- **Max-width**: ~1400px, centered
- **Padding**: 4-6rem vertical, 2-3rem horizontal
- **Background**: White or off-white

### Intro Section (Optional)

- **Max-width**: ~800px, centered
- **Font size**: 1.125rem (18px)
- **Length**: 1-2 sentences, max 100 words
- **Purpose**: Brief context about the artist's workspace or process
- **Placement**: Between page title and photo gallery

### Photo Gallery Grid

- **Desktop**: 3 columns with equal gutters (gap: 1.5-2rem)
- **Tablet**: 2 columns
- **Mobile**: 1 column (full width)
- **Layout type**: Standard grid or masonry (Pinterest-style)
- **Image aspect ratios**: Original (not forced to squares)
- **Images**: 10-20 photos total

### Image Cards

- **Photo**: Full-width within column
- **Hover effect**: Subtle zoom (1.03x scale) or slight shadow
- **Caption**: Below image, 14-16px font, grey color (#666)
- **Click behavior**: Open lightbox with full-size image

### Captions

- **Length**: 1-2 sentences, max 80 characters
- **Style**: Short, descriptive, conversational
- **Examples**:
  - "Centering clay on the wheel"
  - "My studio space in Brooklyn"
  - "Trimming the foot of a bowl"
  - "Glazing in progress"
  - "Fresh from the kiln"

### Video Section (Optional)

- **Placement**: Below photo gallery
- **Layout**: 2 columns on desktop, 1 on mobile
- **Video embeds**: YouTube or Vimeo (responsive 16:9)
- **Caption**: Below each video
- **Max videos**: 2-4 (don't overwhelm the page)

---

## Content Types & Examples

### Studio Environment Photos

- Wide shot of workspace
- Work benches and shelving
- Pottery wheel(s)
- Kiln exterior/interior
- Storage areas with materials
- Windows/natural light
- Overall studio atmosphere

### Process/Making Photos

- Hands working with clay
- Throwing on the wheel
- Hand-building techniques
- Trimming and refining
- Carving or decorating
- Applying glaze
- Loading kiln
- Unloading kiln
- Work in progress shots
- Before/after comparisons

### Tools & Materials Photos

- Close-ups of favorite tools
- Glaze jars and materials
- Raw clay
- Brushes, ribs, wire tools
- Organized tool storage

### Artist at Work Photos (Optional)

- Artist at the wheel
- Artist glazing
- Artist inspecting work
- Can be candid or posed
- Shows human element

---

## Typography

- **Page Title**: 2.5-3rem, "Studio & Process" or "Making" or "Studio"
- **Intro Text**: 1.125rem (18px), line height 1.7
- **Image Captions**: 0.875-1rem (14-16px), color: #666 or #777
- **Section Headers** (if videos): 1.5-2rem

---

## Responsive Breakpoints

### Mobile (320px - 767px)

- Single column layout
- Full-width images
- Captions below each image
- Stacked video embeds

### Tablet (768px - 1024px)

- 2-column grid
- Maintain image quality
- Adequate gutter spacing

### Desktop (1025px+)

- 3-column grid
- Generous spacing between images
- Hover effects enabled

---

## Content Management (Database)

### Data Structure

**Use existing `studio_images` table**:

- `id` (uuid)
- `artist_id` (uuid, foreign key)
- `image_url` (text)
- `caption` (text) - Short description for each image
- `category` (text) - 'studio' | 'process' | 'other'
- `display_order` (integer) - For sorting
- `created_at` (timestamp)

**Add optional field to `artist_profile` table**:

- `studio_intro_text` (text, nullable) - Optional 1-2 sentence intro paragraph

**For videos** (optional - can add post-MVP):

- Store as `studio_images` with `category: 'video'`
- Store video URL in `image_url` field
- OR create separate `process_videos` table

### Image Categories

- **'studio'**: Workspace, environment, tools, setup
- **'process'**: Making, hands working, stages of creation
- **'other'**: Miscellaneous behind-the-scenes content

### Query Logic

```sql
SELECT * FROM studio_images
WHERE artist_id = [artist_id]
ORDER BY display_order ASC, created_at DESC
```

---

## Interaction & Behavior

### Image Loading

- **Progressive loading**: Blur-up technique
- **Lazy loading**: Load images as user scrolls
- **Optimization**: Serve appropriately sized images per viewport
- **Lightbox**: Click image to view full-size with navigation

### Lightbox Features

- Full-size image display
- Caption shown below or overlaid
- Previous/Next navigation
- Close button
- Keyboard navigation (arrow keys, ESC)
- Dark backdrop

### Hover States

- Desktop: Subtle zoom or shadow on hover
- Mobile: No hover states (tap to open lightbox)

### Loading States

- Skeleton screens while images load
- Smooth fade-in animation

---

## Accessibility

### Semantic HTML

- `<main>` for page content
- `<section>` for gallery
- `<figure>` and `<figcaption>` for each image+caption pair
- Proper heading hierarchy

### Images

- **Alt text**: Descriptive but concise
  - "Artist throwing clay on pottery wheel"
  - "Studio workspace with shelving and tools"
  - "Hands trimming the foot of a ceramic bowl"
- **Caption**: Provides additional context beyond alt text

### Keyboard Navigation

- Lightbox accessible via keyboard
- Focus states clearly visible
- ESC key closes lightbox

### Video Accessibility

- YouTube/Vimeo embeds include native captions if available
- Video titles clearly labeled

---

## Dashboard: Edit Studio & Process Page

### Form Structure (Dashboard Side)

```
Edit Studio & Process Page

┌─────────────────────────────────────┐
│ Introduction Text (Optional)         │
│ [Text area - 2-3 lines]              │
│ Brief intro about your workspace     │
│ or process (max 100 words)           │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Studio & Process Photos              │
│                                      │
│ [Drag & Drop Upload Area]            │
│ Upload photos of your workspace,     │
│ tools, and making process            │
│                                      │
│ ┌────────────────────────────────┐  │
│ │ ┌──────┐  [Image 1 thumb]      │  │
│ │ │ img  │  Caption: [________]  │  │
│ │ └──────┘  Category: [Studio ▼]│  │
│ │           [Delete] [↑] [↓]    │  │
│ └────────────────────────────────┘  │
│                                      │
│ ┌────────────────────────────────┐  │
│ │ ┌──────┐  [Image 2 thumb]      │  │
│ │ │ img  │  Caption: [________]  │  │
│ │ └──────┘  Category: [Process▼]│  │
│ │           [Delete] [↑] [↓]    │  │
│ └────────────────────────────────┘  │
│                                      │
│ (Drag to reorder)                    │
│                                      │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Process Videos (Optional)            │
│                                      │
│ ┌─────────────────────────────────┐ │
│ │ Video URL: [_________________] │ │
│ │ (YouTube or Vimeo)             │ │
│ │ Caption: [___________________] │ │
│ │ [Remove]                       │ │
│ └─────────────────────────────────┘ │
│                                      │
│ [+ Add Video]                        │
└─────────────────────────────────────┘

[Cancel]  [Save Changes]
```

### Dashboard Features

- **Bulk upload**: Upload multiple images at once
- **Drag-drop reorder**: Change display order
- **Category assignment**: Studio vs Process vs Other
- **Caption editing**: Inline text input for each image
- **Delete**: Remove individual images
- **Preview**: See how page will look on public site

---

## Finalized Decisions

1. ✅ **Layout**: Photo gallery with captions (Option A)
2. ✅ **Organization**: Single scrollable page with responsive grid
3. ✅ **Content Mix**: Studio environment + process/making photos
4. ✅ **Captions**: Short descriptions (1-2 sentences) below images
5. ✅ **Grid**: 3 columns desktop, 2 tablet, 1 mobile
6. ✅ **Optional Elements**: Intro text (100 words max), video embeds
7. ✅ **Database**: Use existing `studio_images` table with categories

---

## Database Schema (No Changes Needed!)

The existing schema already supports this design:

**`studio_images` table** (already exists):

- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `image_url` (text)
- `caption` (text)
- `category` (text: studio/process/other)
- `display_order` (integer)
- `created_at` (timestamp)

**Optional addition to `artist_profile` table**:

- `studio_intro_text` (text, nullable) - Brief intro paragraph for studio page

---

## Implementation Notes

### Why Option A (Simple Gallery)?

1. **Visual storytelling**: Photos speak for themselves
2. **Easy to manage**: Artists just upload photos and add short captions
3. **Flexible**: Works whether artist has 5 photos or 50
4. **Low barrier**: Artists don't need to write long-form content
5. **Engaging**: Visual content performs well, especially for ceramic work
6. **Fast to build**: Simpler than multi-section layouts
7. **Mobile-friendly**: Gallery layout works great on all devices

### Content Guidelines for Artists

**Suggested photo count**: 10-20 images
**Mix**:

- 40% studio environment photos
- 50% process/making photos
- 10% tools/materials close-ups

**Caption tips**:

- Keep it short and conversational
- Describe what's happening or what's shown
- No need for complete sentences
- Examples: "Centering clay", "My wheel", "Glazing day"

---

**Status**: Finalized ✓
**Date**: 2025-10-20
