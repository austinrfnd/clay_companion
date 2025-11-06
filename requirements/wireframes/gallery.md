# Gallery Page - Wireframe

**URL**: `claycompanion.com/artist-name/gallery`

**Purpose**: Browse and explore all of an artist's public work, organized by series and groups

---

## Key Design Decisions

1. **Default View**: Featured filter (curated selection)
2. **Layout Type**: Single scrollable page with sectioned content
3. **Organization**: Series → Groups (optional) → Artworks
4. **Visibility Control**: Artists can feature or hide artworks, groups, and series
5. **Groups**: Optional, external-facing, can be used for sub-organization within series
6. **Ungrouped Work**: Shows in "Miscellaneous" section

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
│  GALLERY                                                                      │
│                                                                               │
│  ┌─────────┐ ┌─────┐ ┌─────────────┐ ┌─────────────┐ ┌───────────┐        │
│  │Featured*│ │ All │ │ Vessels 2024│ │ Bowls 2022  │ │ Plates... │ [>]    │
│  └─────────┘ └─────┘ └─────────────┘ └─────────────┘ └───────────┘        │
│  (Filter pills - horizontal scroll if many series)                           │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

─────────────────────────────────────────────────────────────────────────────
DEFAULT VIEW: FEATURED FILTER
─────────────────────────────────────────────────────────────────────────────

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  FEATURED                                                                     │
│  (Curated mix of featured artworks, series, groups - shows "best of")        │
│                                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │              │  │              │  │              │  │              │   │
│  │    Image     │  │    Image     │  │    Image     │  │    Image     │   │
│  │              │  │              │  │              │  │              │   │
│  │              │  │              │  │              │  │              │   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘   │
│   Title, Year       Title, Year       Title, Year       Title, Year        │
│   Series Name       Series Name       Series Name       Series Name        │
│                                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │    Image     │  │    Image     │  │    Image     │  │    Image     │   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘   │
│   Title, Year       Title, Year       Title, Year       Title, Year        │
│                                                                               │
│  (Responsive grid: 4 columns desktop, 2-3 tablet, 1-2 mobile)                │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

─────────────────────────────────────────────────────────────────────────────
"ALL" FILTER VIEW: ORGANIZED BY SERIES
─────────────────────────────────────────────────────────────────────────────

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  VESSELS SERIES (2023-2024)                                       [- Expand] │
│  A collection exploring form and function through vessel-making...           │
│                                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │    Image     │  │    Image     │  │    Image     │  │    Image     │   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘   │
│   Vessel No. 47     Vessel No. 46     Vessel No. 45     Vessel No. 44      │
│   2024              2024              2023              2023               │
│                                                                               │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                               │
│  Blue Vessels (Group)                                                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                      │
│  │    Image     │  │    Image     │  │    Image     │                      │
│  └──────────────┘  └──────────────┘  └──────────────┘                      │
│   Title             Title             Title                                  │
│                                                                               │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                               │
│  Red Vessels (Group)                                                          │
│  ┌──────────────┐  ┌──────────────┐                                         │
│  │    Image     │  │    Image     │                                         │
│  └──────────────┘  └──────────────┘                                         │
│   Title             Title                                                    │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  BOWLS SERIES (2022)                                              [+ Expand] │
│  (Collapsed state - shows series header only)                                │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  MISCELLANEOUS                                                    [- Expand] │
│  (Artworks not in any series)                                                │
│                                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                      │
│  │    Image     │  │    Image     │  │    Image     │                      │
│  └──────────────┘  └──────────────┘  └──────────────┘                      │
│   Title, Year       Title, Year       Title, Year                           │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

─────────────────────────────────────────────────────────────────────────────
SINGLE SERIES FILTER VIEW
─────────────────────────────────────────────────────────────────────────────

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  VESSELS SERIES (2023-2024)                                                  │
│  A collection exploring form and function through vessel-making...           │
│                                                                               │
│  All Artworks in Series (ungrouped first)                                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │    Image     │  │    Image     │  │    Image     │  │    Image     │   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘   │
│                                                                               │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                               │
│  Blue Vessels (Group)                                                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                      │
│  │    Image     │  │    Image     │  │    Image     │                      │
│  └──────────────┘  └──────────────┘  └──────────────┘                      │
│                                                                               │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                               │
│  Red Vessels (Group)                                                          │
│  ┌──────────────┐  ┌──────────────┐                                         │
│  │    Image     │  │    Image     │                                         │
│  └──────────────┘  └──────────────┘                                         │
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
│  GALLERY                                                │
│                                                          │
│  ┌─────────┐ ┌─────┐ ┌─────────┐ ┌─────────┐ [>]      │
│  │Featured*│ │ All │ │Vessels  │ │Bowls    │          │
│  └─────────┘ └─────┘ └─────────┘ └─────────┘          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│  FEATURED                                               │
│                                                          │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐          │
│  │   Image   │  │   Image   │  │   Image   │          │
│  └───────────┘  └───────────┘  └───────────┘          │
│   Title          Title          Title                   │
│                                                          │
│  ┌───────────┐  ┌───────────┐  ┌───────────┐          │
│  │   Image   │  │   Image   │  │   Image   │          │
│  └───────────┘  └───────────┘  └───────────┘          │
│                                                          │
│  (3 columns on tablet)                                  │
└────────────────────────────────────────────────────────┘
```

---

## Mobile Layout (320px - 767px)

```
┌───────────────────────────────┐
│  Artist Name          ☰ Menu  │
└───────────────────────────────┘

┌───────────────────────────────┐
│  GALLERY                       │
│                                │
│  ┌──────┐ ┌─────┐ ┌──────┐   │
│  │Feat.*│ │All  │ │Vess..│[>]│
│  └──────┘ └─────┘ └──────┘   │
│  (Horizontal scroll)           │
└───────────────────────────────┘

┌───────────────────────────────┐
│  FEATURED                      │
│                                │
│  ┌─────────────┐               │
│  │             │               │
│  │    Image    │               │
│  │             │               │
│  └─────────────┘               │
│   Title, Year                  │
│   Series Name                  │
│                                │
│  ┌─────────────┐               │
│  │    Image    │               │
│  └─────────────┘               │
│   Title, Year                  │
│                                │
│  (1-2 columns mobile)          │
└───────────────────────────────┘
```

---

## Layout Specifications

### Filter Pills

- **Desktop**:
  - Horizontal pills/tabs
  - "Featured" selected by default (with asterisk or highlight)
  - Horizontal scroll if many series (with arrow indicators)
  - Pills have rounded corners, padding, background color changes on active
- **Mobile**:
  - Compact pills with truncated text
  - Horizontal scroll
  - Arrows to indicate more content
- **Behavior**:
  - Click to filter gallery content
  - Active state: Different background/border color
  - Smooth transition when switching filters

### Gallery Grid

- **Grid Layout**:
  - Desktop: 4 columns
  - Tablet: 3 columns
  - Mobile: 1-2 columns (depends on viewport)
  - Spacing: Generous/spacious (MVP default)
- **Image Cards**:
  - **Aspect Ratio**: Square (1:1) for all thumbnails
  - **Crop Method**: Center crop or object-fit cover
  - Hover effect: Slight scale (1.05x)
  - Click opens lightbox/modal with **original proportions** and full details
- **Metadata Display**:
  - Always visible below image: Title, Year
  - Optional: Series name (if in Featured view)
  - Typography: Title medium weight, year/series lighter
- **Infinite Scroll**:
  - Load 20-30 images initially
  - Auto-load next batch when user scrolls near bottom
  - Loading indicator while fetching more
- **Sort Order**: Newest first (`ORDER BY year_created DESC, created_at DESC`)

### Series Sections (in "All" view)

- **Section Header**:
  - Series title + year range (e.g., "VESSELS SERIES (2023-2024)")
  - Description below header (2-3 lines)
  - Expand/collapse toggle on right
  - Spacing: 4rem top margin, 1rem bottom margin
- **Ungrouped Artworks**:
  - Show first (before any groups)
  - No sub-header, just the grid
- **Groups**:
  - Sub-header with group title (lighter/smaller than series header)
  - Horizontal rule or subtle divider above group
  - Group artworks in grid below

### Miscellaneous Section

- Shows artworks not assigned to any series
- Same styling as series sections
- Only appears if there are ungrouped artworks

### Series Collapse/Expand

- **Default State**: All series expanded
- **Collapsed**: Shows only series header + description
- **Expanded**: Shows all content (artworks + groups)
- **Icon**: "+" to expand, "-" to collapse
- **Behavior**: Smooth animation (height transition)

### Featured Filter Logic

- Shows items where `is_featured = true`:
  - Individual artworks marked as featured
  - All artworks from series marked as featured
  - All artworks from groups marked as featured
- Display: Mixed grid (no series sections, just featured items)
- Order: By `display_order` or most recently marked as featured

### Visibility Logic

- Items with `is_hidden_from_gallery = true` never appear in public gallery
- Items must also be `is_public = true` to show in gallery
- Groups inherit visibility from parent series (if series is hidden, groups are too)

---

## Interaction & Behavior

### Filter Switching

- Default view: "Featured" filter
- Click filter pill to switch views
- Smooth transition/fade when content changes
- URL updates to reflect filter (e.g., `/gallery?filter=vessels` or `/gallery#vessels`)
- Browser back/forward works with filter changes

### Image Click

- Opens lightbox/modal with:
  - **Large image in original proportions** (not square)
  - Swipeable if multiple images per artwork
  - Artwork title, year, description
  - Series/group context
  - Dimensions, clay type (optional - configurable by artist)
  - Previous/Next navigation arrows
  - Close button (X) or click outside to close
- Keyboard navigation: ESC to close, arrow keys to navigate

### Hover States

- Desktop: Slight zoom (1.05x) - no overlay needed (metadata always visible)
- Mobile: Tap to open lightbox (no hover)

### Loading States

- Skeleton screens while images load
- Progressive image loading (blur-up technique)
- **Infinite scroll**: Auto-load more as user approaches bottom
- Loading spinner/indicator when fetching next batch

### Empty States

- **No Featured Items**: "No featured work yet. Explore all work below."
- **Series with No Artworks**: Don't show series section
- **Empty Gallery**: "Gallery coming soon" message

### Series Collapse State Persistence

- Save collapse/expand state in localStorage
- Remember user's preference across page visits
- Default: All expanded on first visit

---

## Responsive Breakpoints

- **Mobile**: 320px - 767px
  - 1-2 column grid
  - Compact filter pills with horizontal scroll
  - Stacked series sections
  - Simplified metadata (title + year only)

- **Tablet**: 768px - 1024px
  - 3 column grid
  - Filter pills with horizontal scroll if needed
  - Series sections with smaller spacing

- **Desktop**: 1025px+
  - 4 column grid
  - Full filter pills visible (with scroll if many)
  - Generous spacing
  - Max-width container (~1200px) centered

---

## Accessibility

- **Keyboard Navigation**:
  - Filter pills accessible via Tab
  - Image cards focusable and have Enter to open
  - Lightbox ESC to close, arrows to navigate
- **Screen Readers**:
  - ARIA labels on filter buttons
  - Alt text on all images
  - Semantic HTML (section, heading hierarchy)
- **Focus States**:
  - Visible focus indicators on all interactive elements
  - Skip to content link

---

## Performance Considerations

- **Image Optimization**:
  - Lazy loading (images load as user scrolls)
  - Generate square thumbnails (1:1 aspect ratio) at multiple sizes for gallery grid
  - Store original images for lightbox view (original proportions)
  - Next.js Image component for automatic optimization
  - WebP format with fallbacks
- **Infinite Scroll**:
  - Load first 20-30 images initially
  - Prefetch next batch when user scrolls to ~80% of current content
  - Smooth loading with skeleton screens
- **Caching**:
  - Cache gallery data (series, artworks)
  - Revalidate on navigation or artist updates

---

## Database Query Strategy

### Featured Filter Query

```sql
SELECT * FROM artworks
WHERE artist_id = ?
  AND is_public = true
  AND is_hidden_from_gallery = false
  AND (
    is_featured = true
    OR series_id IN (SELECT id FROM series WHERE is_featured = true)
    OR group_id IN (SELECT id FROM artwork_groups WHERE is_featured = true)
  )
ORDER BY year_created DESC, created_at DESC
LIMIT 30 OFFSET ?
```

### All View Query

```sql
-- Get all public series (not hidden)
SELECT * FROM series
WHERE artist_id = ?
  AND is_public = true
  AND is_hidden_from_gallery = false
ORDER BY display_order

-- For each series, get groups and artworks
SELECT * FROM artwork_groups
WHERE series_id = ?
  AND is_hidden_from_gallery = false
ORDER BY display_order

SELECT * FROM artworks
WHERE series_id = ?
  AND is_public = true
  AND is_hidden_from_gallery = false
ORDER BY group_id, year_created DESC, created_at DESC

-- Get miscellaneous (no series)
SELECT * FROM artworks
WHERE artist_id = ?
  AND series_id IS NULL
  AND is_public = true
  AND is_hidden_from_gallery = false
ORDER BY year_created DESC, created_at DESC
LIMIT 30 OFFSET ?
```

### Single Series Filter Query

```sql
-- Get specific series
SELECT * FROM series WHERE id = ? AND is_public = true

-- Get artworks and groups in that series
(same as above, filtered by series_id)
```

---

## Finalized Design Decisions

1. ✅ **Image Aspect Ratio**: Square (1:1) for gallery grid thumbnails
   - Ensures consistent, clean grid layout
   - Lightbox shows original proportions when clicked
   - Images cropped/centered to fit square in gallery view

2. ✅ **Pagination**: Infinite scroll
   - Load initial batch (20-30 images)
   - Auto-load more as user scrolls near bottom
   - Smooth, seamless browsing experience

3. ✅ **Metadata Display**: Always show title and year below each image
   - No hover-only metadata
   - Consistent display on all devices
   - Simple, clean presentation

4. ✅ **Grid Density**: Spacious for MVP
   - Generous spacing between images
   - Breathing room for each piece
   - Post-MVP: Could add artist preference for compact vs. spacious

5. ✅ **Sort Order**: Newest first (by date created)
   - `ORDER BY year_created DESC, created_at DESC`
   - Shows most recent work first
   - Post-MVP: Could add sort options dropdown

---

**Status**: Finalized ✓
**Date**: 2025-10-14
