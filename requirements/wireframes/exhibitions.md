# Exhibitions Page - Wireframe

**URL**: `claycompanion.com/artist-name/exhibitions`

**Purpose**: Showcase featured exhibitions with visual galleries and provide a comprehensive chronological history of past and upcoming shows

---

## Key Design Decisions

1. **Layout Structure**: Featured exhibitions section (top) + Exhibition history list (below)
2. **Featured Section**: 2-3 exhibitions with title, description, and horizontal scrolling image carousel
3. **History Section**: Chronological list organized by year, then by type (Solo/Group)
4. **Images**: Only in featured section; history section is text-only for scannability
5. **Carousel**: Horizontal scroll with arrow controls, click to open lightbox
6. **Organization**: Year (newest first) → Type (Solo/Group) → Date (newest first)

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
│  EXHIBITIONS                                                                  │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  FEATURED EXHIBITIONS                                                         │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Vessels of Memory: A Solo Exhibition                                  │ │
│  │  Museum of Contemporary Ceramics, New York, NY  |  March 15 - May 30, │ │
│  │  2024                                                                   │ │
│  │                                                                         │ │
│  │  This exhibition presents twenty new vessels exploring themes of       │ │
│  │  memory, time, and transformation. Each piece incorporates found       │ │
│  │  materials and traditional glazing techniques to create a dialogue     │ │
│  │  between past and present.                                             │ │
│  │                                                                         │ │
│  │  The works range from intimate cup forms to large-scale sculptural     │ │
│  │  vessels, all unified by an exploration of how objects carry memory    │ │
│  │  and meaning across generations. Visitors will encounter pieces that   │ │
│  │  reference archaeological fragments, domestic vessels, and ritualistic │ │
│  │  objects from various cultural traditions.                             │ │
│  │                                                                         │ │
│  │  ┌────────────────────────────────────────────────────────────────┐   │ │
│  │  │                                                                  │   │ │
│  │  │  [<]  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  [>]  │   │ │
│  │  │       │      │  │      │  │      │  │      │  │      │       │   │ │
│  │  │       │ img  │  │ img  │  │ img  │  │ img  │  │ img  │       │   │ │
│  │  │       │  1   │  │  2   │  │  3   │  │  4   │  │  5   │       │   │ │
│  │  │       │      │  │      │  │      │  │      │  │      │       │   │ │
│  │  │       └──────┘  └──────┘  └──────┘  └──────┘  └──────┘       │   │ │
│  │  │                                                                  │   │ │
│  │  │       Installation  Detail shot  Opening     Gallery    Catalog │   │ │
│  │  │       view                       reception   view       cover   │   │ │
│  │  │                                                                  │   │ │
│  │  │                    ● ○ ○ ○ ○                                   │   │ │
│  │  │                  (Position dots)                                │   │ │
│  │  │                                                                  │   │ │
│  │  └────────────────────────────────────────────────────────────────┘   │ │
│  │  (Horizontal scrolling carousel - 4-5 images visible at once)          │ │
│  │  (Click image to open lightbox with full-size view)                    │ │
│  │                                                                         │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Clay & Light: New Work                                                │ │
│  │  Portland Clay Studio, Portland, OR  |  January 10 - February 28, 2024│ │
│  │                                                                         │ │
│  │  An intimate exhibition of recent work exploring the relationship      │ │
│  │  between form, surface, and illumination. This body of work features   │ │
│  │  translucent porcelain vessels designed to interact with natural and   │ │
│  │  artificial light sources.                                             │ │
│  │                                                                         │ │
│  │  Each piece in the exhibition considers how light transforms our       │ │
│  │  perception of ceramic surfaces and interior volumes...                │ │
│  │                                                                         │ │
│  │  ┌────────────────────────────────────────────────────────────────┐   │ │
│  │  │  [<]  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  [>]  │   │ │
│  │  │       │ img  │  │ img  │  │ img  │  │ img  │  │ img  │       │   │ │
│  │  │       └──────┘  └──────┘  └──────┘  └──────┘  └──────┘       │   │ │
│  │  │                    ● ○ ○ ○ ○                                   │   │ │
│  │  └────────────────────────────────────────────────────────────────┘   │ │
│  │                                                                         │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  (2-3 featured exhibitions max)                                              │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  EXHIBITION HISTORY                                                           │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2024                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  SOLO EXHIBITIONS                                                             │
│                                                                               │
│  • Vessels of Memory                                                         │
│    Museum of Contemporary Ceramics, New York, NY                             │
│    March 15 - May 30, 2024                                                   │
│                                                                               │
│  • Clay & Light: New Work                                                    │
│    Portland Clay Studio, Portland, OR                                        │
│    January 10 - February 28, 2024                                            │
│                                                                               │
│  GROUP EXHIBITIONS                                                            │
│                                                                               │
│  • Contemporary Ceramics Biennial                                            │
│    International Ceramics Museum, Denver, CO                                 │
│    June 1 - August 15, 2024                                                  │
│                                                                               │
│  • Emerging Voices in Clay                                                   │
│    Craft Alliance, St. Louis, MO                                             │
│    April 5 - May 20, 2024                                                    │
│                                                                               │
│  • Functional Forms                                                          │
│    San Francisco Craft & Design Museum, San Francisco, CA                    │
│    February 12 - April 3, 2024                                               │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2023                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  SOLO EXHIBITIONS                                                             │
│                                                                               │
│  • Fired Earth                                                               │
│    Brooklyn Clay Works, Brooklyn, NY                                         │
│    September 12 - October 30, 2023                                           │
│                                                                               │
│  • Ritual Objects                                                            │
│    Chicago Art Institute - Artist Space, Chicago, IL                         │
│    May 8 - June 25, 2023                                                     │
│                                                                               │
│  GROUP EXHIBITIONS                                                            │
│                                                                               │
│  • National Ceramics Invitational                                            │
│    American Museum of Ceramic Art, Pomona, CA                                │
│    October 15 - December 10, 2023                                            │
│                                                                               │
│  • West Coast Clay                                                           │
│    Seattle Art Museum, Seattle, WA                                           │
│    July 20 - September 5, 2023                                               │
│                                                                               │
│  • Material Matters                                                          │
│    Museum of Arts and Design, New York, NY                                   │
│    March 3 - June 18, 2023                                                   │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2022                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  GROUP EXHIBITIONS                                                            │
│                                                                               │
│  • American Craft Biennial                                                   │
│    Renwick Gallery, Smithsonian, Washington, DC                              │
│    November 5, 2022 - February 26, 2023                                      │
│                                                                               │
│  • New Ceramic Art                                                           │
│    Los Angeles County Museum of Art, Los Angeles, CA                         │
│    June 10 - September 4, 2022                                               │
│                                                                               │
│  (Continues with more years...)                                              │
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
│  EXHIBITIONS                                             │
│                                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  FEATURED EXHIBITIONS                                    │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │  Vessels of Memory                              │    │
│  │  Museum of Contemporary Ceramics, New York, NY  │    │
│  │  March 15 - May 30, 2024                        │    │
│  │                                                  │    │
│  │  Description text...                            │    │
│  │                                                  │    │
│  │  [<] ┌────┐ ┌────┐ ┌────┐ [>]                 │    │
│  │      │img │ │img │ │img │                      │    │
│  │      └────┘ └────┘ └────┘                      │    │
│  │          ● ○ ○ ○                                │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
│  (More featured exhibitions...)                         │
│                                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  EXHIBITION HISTORY                                      │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                          │
│  ────────────────────────────────────────────────────  │
│  2024                                                    │
│  ────────────────────────────────────────────────────  │
│                                                          │
│  SOLO EXHIBITIONS                                        │
│  • Vessels of Memory                                    │
│    Museum of Contemporary Ceramics, New York, NY        │
│    March 15 - May 30, 2024                              │
│                                                          │
│  (Continues...)                                          │
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
│  EXHIBITIONS                   │
│                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  FEATURED                      │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                │
│  ┌───────────────────────┐    │
│  │ Vessels of Memory     │    │
│  │                       │    │
│  │ Museum of             │    │
│  │ Contemporary          │    │
│  │ Ceramics, New York    │    │
│  │                       │    │
│  │ March 15 - May 30,    │    │
│  │ 2024                  │    │
│  │                       │    │
│  │ Description text...   │    │
│  │                       │    │
│  │ [<] ┌───┐ ┌───┐ [>] │    │
│  │     │img│ │img│      │    │
│  │     └───┘ └───┘      │    │
│  │        ● ○ ○          │    │
│  │                       │    │
│  └───────────────────────┘    │
│                                │
│  (Swipe enabled on mobile)     │
│                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  HISTORY                       │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                │
│  ─────────────────────────    │
│  2024                          │
│  ─────────────────────────    │
│                                │
│  SOLO EXHIBITIONS              │
│                                │
│  • Vessels of Memory           │
│    Museum of                   │
│    Contemporary                │
│    Ceramics, New York, NY      │
│    March 15 - May 30, 2024     │
│                                │
│  • Clay & Light                │
│    Portland Clay Studio,       │
│    Portland, OR                │
│    Jan 10 - Feb 28, 2024       │
│                                │
│  GROUP EXHIBITIONS             │
│                                │
│  • Contemporary                │
│    Ceramics Biennial           │
│    International Ceramics      │
│    Museum, Denver, CO          │
│    June 1 - Aug 15, 2024       │
│                                │
│  (Continues...)                │
│                                │
└───────────────────────────────┘
```

---

## Layout Specifications

### Page Container

- **Max-width**: ~1200px, centered
- **Padding**: 4-6rem vertical, 2-3rem horizontal
- **Background**: White or off-white

### Featured Exhibitions Section

#### Section Container

- **Background**: Light background (#f8f9fa) or subtle border
- **Padding**: 2-3rem
- **Margin**: 2rem between featured exhibitions
- **Max featured**: 2-3 exhibitions

#### Each Featured Exhibition Card

- **Title**:
  - Font size: 1.75-2rem (28-32px)
  - Font weight: Bold
  - Color: Primary text color
- **Venue & Location**:
  - Font size: 1.125rem (18px)
  - Font weight: Medium
  - Color: Grey (#666)
  - Format: "Venue Name, City, State/Country"
- **Dates**:
  - Same line as venue, separated by pipe |
  - Font size: 1.125rem (18px)
  - Color: Grey (#666)
  - Format: "Month DD - Month DD, YYYY"
- **Description**:
  - Font size: 1rem (16px)
  - Line height: 1.7
  - Color: Body text color
  - Length: 2-3 paragraphs (200-300 words)
  - Margin: 1.5rem top and bottom

#### Horizontal Image Carousel

- **Container**:
  - Full width within card
  - Height: 250-350px (fixed for consistency)
  - Overflow: Hidden with horizontal scroll
- **Images**:
  - Width: 300-400px each
  - Height: 250-350px (maintain aspect ratio)
  - Gap: 1rem between images
  - 4-5 images visible on desktop
  - 3-4 on tablet
  - 2 on mobile
- **Controls**:
  - Left/Right arrow buttons (40-50px)
  - Position: Centered vertically on carousel
  - Background: Semi-transparent white circle
  - Icon: Chevron left/right
  - Hover: Darken background
- **Position Indicators**:
  - Dots below carousel
  - Active dot: Filled, larger
  - Inactive dots: Outlined, smaller
  - Color: Primary or grey
- **Click Behavior**: Opens lightbox with full-size image
- **Mobile**: Swipe gestures enabled

### Exhibition History Section

#### Section Header

- **Text**: "EXHIBITION HISTORY"
- **Font size**: 2rem (32px)
- **Font weight**: Bold
- **Border**: Top and bottom lines, or just top
- **Margin**: 4rem top, 2rem bottom

#### Year Headers

- **Font size**: 1.5-1.75rem (24-28px)
- **Font weight**: Bold
- **Color**: Primary text
- **Divider**: Full-width horizontal line above and below
- **Spacing**: 2rem top, 1rem bottom

#### Type Sub-headers (Solo/Group)

- **Font size**: 1.25rem (20px)
- **Font weight**: Medium or Semi-bold
- **Color**: Grey (#666)
- **Text transform**: Uppercase
- **Spacing**: 1.5rem top, 0.75rem bottom

#### Exhibition Entries

- **Format**: Bulleted list
- **Bullet**: Standard bullet or custom icon
- **Spacing**: 1rem between entries
- **Title**:
  - Font size: 1rem (16px)
  - Font weight: Bold
  - Color: Primary text
- **Venue, Location**:
  - Font size: 1rem (16px)
  - Font weight: Regular
  - Color: Grey (#666)
  - Line 2 of entry
- **Dates**:
  - Font size: 1rem (16px)
  - Font weight: Regular
  - Color: Grey (#666)
  - Line 3 of entry

---

## Content Management (Database)

### Data Structure

**Updated `exhibitions` table** (add these fields):

- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `title` (text)
- `venue` (text)
- `location` (text)
- `start_date` (date)
- `end_date` (date, nullable)
- `description` (text)
- `is_upcoming` (boolean)
- **`is_featured`** (boolean, default false) **← NEW**
- **`exhibition_type`** (text: 'solo' | 'group' | 'other') **← NEW**
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

**New table: `exhibition_images`**:

```sql
CREATE TABLE exhibition_images (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  exhibition_id UUID NOT NULL REFERENCES exhibitions(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  caption TEXT,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Query Logic

**Featured Exhibitions**:

```sql
SELECT e.*,
  (SELECT json_agg(
    json_build_object(
      'image_url', ei.image_url,
      'caption', ei.caption
    ) ORDER BY ei.display_order
  ) FROM exhibition_images ei
  WHERE ei.exhibition_id = e.id
  ) as images
FROM exhibitions e
WHERE e.artist_id = $1
  AND e.is_featured = true
ORDER BY e.start_date DESC
LIMIT 3;
```

**Exhibition History**:

```sql
SELECT * FROM exhibitions
WHERE artist_id = $1
ORDER BY
  EXTRACT(YEAR FROM start_date) DESC,
  exhibition_type ASC, -- 'solo' before 'group'
  start_date DESC;
```

**Frontend Grouping Logic**:

1. Group results by year (extracted from `start_date`)
2. Within each year, separate into "Solo" and "Group" sections
3. Display in chronological order within each section

---

## Typography

- **Page Title**: 2.5-3rem, "Exhibitions"
- **Section Headers**: 2rem, "Featured Exhibitions", "Exhibition History"
- **Featured Exhibition Title**: 1.75-2rem, bold
- **Featured Venue/Dates**: 1.125rem, medium weight, grey
- **Featured Description**: 1rem, line height 1.7
- **Year Header**: 1.5-1.75rem, bold
- **Type Sub-header**: 1.25rem, medium, uppercase, grey
- **Exhibition Entry Title**: 1rem, bold
- **Exhibition Entry Details**: 1rem, regular, grey

---

## Responsive Breakpoints

### Mobile (320px - 767px)

- Featured: Full-width cards, stacked
- Carousel: 2 images visible, swipe enabled
- History: Compressed spacing, same structure
- Reduce font sizes slightly for readability

### Tablet (768px - 1024px)

- Featured: Slightly reduced padding
- Carousel: 3-4 images visible
- History: Same layout as desktop

### Desktop (1025px+)

- Featured: Full layout with generous padding
- Carousel: 4-5 images visible
- History: Single column, clean list

---

## Interaction & Behavior

### Horizontal Carousel

- **Scroll**: Smooth CSS scroll-snap behavior
- **Arrow Controls**: Click to scroll by 1-2 images
- **Keyboard**: Arrow keys navigate when focused
- **Touch/Swipe**: Enabled on mobile devices
- **Autoplay**: Optional (disabled by default)
- **Loop**: Optional (can loop back to start)

### Lightbox

- **Trigger**: Click any carousel image
- **Display**: Full-screen modal with image
- **Navigation**: Previous/Next buttons, arrow keys
- **Caption**: Display below or overlaid on image
- **Close**: X button, ESC key, click outside
- **Backdrop**: Dark semi-transparent (#000 70% opacity)

### Exhibition History

- **Static list**: No interactivity in MVP
- **Optional enhancement**: Collapsible year sections
- **Optional enhancement**: Smooth scroll to year

### Loading States

- Skeleton screens for carousel images
- Fade-in animation when images load
- Loading indicator for lightbox images

---

## Accessibility

### Semantic HTML

- `<main>` for page content
- `<section>` for featured and history sections
- `<article>` for each featured exhibition
- `<ul>` and `<li>` for exhibition history list
- Proper heading hierarchy (h1 → h2 → h3)

### Carousel Accessibility

- **ARIA roles**: `role="region" aria-label="Exhibition images"`
- **Arrow buttons**: Clear labels ("Previous image", "Next image")
- **Keyboard navigation**: Tab through images, arrow keys to scroll
- **Focus management**: Clear focus indicators
- **Screen reader**: Announce current position (e.g., "Image 2 of 5")

### Images

- **Alt text**: Descriptive
  - "Installation view of Vessels of Memory exhibition"
  - "Detail of ceramic vessel from exhibition"
  - "Opening reception at Museum of Contemporary Ceramics"
- **Captions**: Additional context beyond alt text

### Contrast & Readability

- Text meets WCAG AA contrast standards
- Sufficient spacing for touch targets (44x44px min)
- Clear visual hierarchy

---

## Dashboard: Edit Exhibitions Page

### Form Structure (Dashboard Side)

```
Edit Exhibitions

┌─────────────────────────────────────────────────────────┐
│ All Exhibitions                                          │
│                                                          │
│ [+ Add Exhibition]                                       │
│                                                          │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Exhibition 1                                         │ │
│ │                                                      │ │
│ │ Title: [Vessels of Memory                    ]      │ │
│ │ Venue: [Museum of Contemporary Ceramics      ]      │ │
│ │ Location: [New York, NY                      ]      │ │
│ │ Start Date: [2024-03-15]                            │ │
│ │ End Date: [2024-05-30]                              │ │
│ │ Type: [Solo ▼]                                      │ │
│ │                                                      │ │
│ │ Description:                                         │ │
│ │ [Large textarea for description]                    │ │
│ │                                                      │ │
│ │ ☑ Featured Exhibition (show in featured section)   │ │
│ │ ☐ Upcoming Exhibition                               │ │
│ │                                                      │ │
│ │ ┌─────────────────────────────────────────────────┐│ │
│ │ │ Featured Images (only if featured is checked)   ││ │
│ │ │                                                  ││ │
│ │ │ [Drag & Drop Upload Area]                       ││ │
│ │ │                                                  ││ │
│ │ │ ┌──────┐ ┌──────┐ ┌──────┐                     ││ │
│ │ │ │      │ │      │ │      │                     ││ │
│ │ │ │ img1 │ │ img2 │ │ img3 │                     ││ │
│ │ │ │      │ │      │ │      │                     ││ │
│ │ │ └──────┘ └──────┘ └──────┘                     ││ │
│ │ │ Caption: Caption: Caption:                      ││ │
│ │ │ [______] [______] [______]                      ││ │
│ │ │ [↑][↓]   [↑][↓]   [↑][↓]                       ││ │
│ │ │ [Delete] [Delete] [Delete]                      ││ │
│ │ │                                                  ││ │
│ │ │ (Drag to reorder)                               ││ │
│ │ └─────────────────────────────────────────────────┘│ │
│ │                                                      │ │
│ │ [Edit] [Delete Exhibition]                          │ │
│ └─────────────────────────────────────────────────────┘ │
│                                                          │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Exhibition 2                                         │ │
│ │ (Same structure...)                                  │ │
│ └─────────────────────────────────────────────────────┘ │
│                                                          │
│ (More exhibitions...)                                    │
│                                                          │
└─────────────────────────────────────────────────────────┘

[Save All Changes]
```

### Dashboard Features

- **Add Exhibition**: Button to create new exhibition
- **Edit/Delete**: Modify or remove exhibitions
- **Featured Toggle**: Checkbox to mark for featured section
- **Type Dropdown**: Solo | Group | Other
- **Upcoming Toggle**: Mark future exhibitions
- **Image Upload**: Only visible when "Featured" is checked
  - Drag-drop upload multiple images
  - Reorder images with drag-drop or arrows
  - Add captions for each image
  - Delete individual images
- **Preview**: See how exhibitions page looks on public site
- **Validation**:
  - Featured exhibitions require at least 1 image
  - Title, venue, location, dates are required
  - Description required for featured exhibitions

---

## Finalized Decisions

1. ✅ **Featured Section**: 2-3 exhibitions with title, description, horizontal image carousel
2. ✅ **Carousel**: Horizontal scroll with arrow controls, 4-5 images visible (desktop)
3. ✅ **Click Images**: Opens lightbox for full-size view
4. ✅ **History Section**: Chronological list by year → type (Solo/Group) → date
5. ✅ **Images**: Only in featured section; history is text-only
6. ✅ **Organization**: Professional CV-style format for history
7. ✅ **Responsive**: Mobile-friendly carousel with swipe gestures

---

## Database Schema Changes

**Add to `exhibitions` table**:

- `is_featured` (boolean, default false)
- `exhibition_type` (text: 'solo' | 'group' | 'other')

**Create new table `exhibition_images`**:

- `id` (uuid, primary key)
- `exhibition_id` (uuid, foreign key)
- `image_url` (text)
- `caption` (text, nullable)
- `display_order` (integer)
- `created_at` (timestamp)

---

## Implementation Notes

### Why This Approach?

1. **Featured Section**: Highlights most important exhibitions with rich storytelling
2. **Horizontal Carousel**: Modern UI pattern; saves vertical space; engaging interaction
3. **Chronological History**: Industry standard CV format; professional and scannable
4. **Solo/Group Separation**: Standard practice in art world; provides context
5. **Images in Featured Only**: Keeps history section fast and scannable
6. **Flexible**: Works for emerging artists (few exhibitions) and established artists (many)

### Content Guidelines for Artists

**Featured Exhibitions** (2-3 max):

- Most significant recent exhibitions
- Solo shows or major group exhibitions
- 5-8 high-quality images per exhibition
- Images: Installation views, artwork details, opening reception, catalog covers

**Image Captions**:

- Short and descriptive
- Examples: "Installation view", "Opening reception", "Catalog cover", "Detail view"

**Exhibition History**:

- Comprehensive list of all exhibitions
- Format: Title, Venue/Location, Dates
- No need for descriptions (keeps it scannable)
- Organized by year and type

---

**Status**: Finalized ✓
**Date**: 2025-10-20
