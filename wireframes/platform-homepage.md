# Platform Homepage Wireframe

**URL**: `claycompanion.com`
**Purpose**: Discovery, inspiration, and platform promotion
**User Type**: Non-authenticated visitors, potential artists, art enthusiasts
**Created**: 2025-10-14

---

## Design Decisions

### Overall Approach
- **Feel**: Balanced - showcase artwork/artists while promoting the platform
- **Goal**: "Discover cool artists. Discover cool artwork. Inspiration."
- **Positioning**: "By artists, for artists"

### Key Features
1. **Hero Carousel**: Featured artwork with artist attribution
2. **Search & Filters**: Clay type, firing type, artist name, location
3. **Featured Artists**: 3 artists with substantial showcase space
4. **Value Proposition**: "By artists, for artists" mission statement
5. **Artist Directory**: Browseable/filterable grid of all artists

---

## Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│                    FIXED NAVIGATION BAR                      │
│  Clay Companion (logo)    Browse Artists | Login | Sign Up   │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                     HERO CAROUSEL SECTION                    │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                                                         │  │
│  │         [FEATURED ARTWORK - AUTO ROTATING]             │  │
│  │                                                         │  │
│  │              Full-width image carousel                  │  │
│  │              (5-10 sec transitions)                     │  │
│  │                                                         │  │
│  │   Overlay (bottom):                                     │  │
│  │   ┌──────────────────────────────────────────────────┐ │  │
│  │   │ "Midnight Vessel" by Sarah Chen                   │ │  │
│  │   │ Click to view artist profile →                    │ │  │
│  │   └──────────────────────────────────────────────────┘ │  │
│  │                                                         │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                               │
│              [◄]  ●  ○  ○  ○  ○  [►]                        │
│                  (carousel indicators)                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                 PLATFORM INTRODUCTION                        │
│                                                               │
│              Discover Exceptional Ceramic Art                │
│                                                               │
│     Explore portfolios from talented ceramic artists.        │
│         Find inspiration. Connect with makers.               │
│                                                               │
│                  [Explore Artists →]                         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                   SEARCH & FILTER BAR                        │
│  ┌─────────────────────────────────────────────────────┐   │
│  │  🔍  Search by artist name, location, technique...   │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                               │
│  Filters:  [Clay Type ▼]  [Firing Type ▼]  [Location ▼]    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    FEATURED ARTISTS                          │
│                                                               │
│                    Featured Artists                          │
│                                                               │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐│
│  │                 │  │                 │  │                 ││
│  │  [Main Image]   │  │  [Main Image]   │  │  [Main Image]   ││
│  │                 │  │                 │  │                 ││
│  │                 │  │                 │  │                 ││
│  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤│
│  │ Sarah Chen      │  │ Marcus Brown    │  │ Elena Torres    ││
│  │ Functional      │  │ Sculptural      │  │ Contemporary    ││
│  │ Stoneware       │  │ Porcelain       │  │ Raku            ││
│  │                 │  │                 │  │                 ││
│  │ 2-3 thumbnail   │  │ 2-3 thumbnail   │  │ 2-3 thumbnail   ││
│  │ pieces below    │  │ pieces below    │  │ pieces below    ││
│  │ [○][○][○]       │  │ [○][○][○]       │  │ [○][○][○]       ││
│  │                 │  │                 │  │                 ││
│  │ [View Profile]  │  │ [View Profile]  │  │ [View Profile]  ││
│  └─────────────────┘  └─────────────────┘  └─────────────────┘│
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  VALUE PROPOSITION                           │
│                                                               │
│              By Artists, For Artists                         │
│                                                               │
│    Clay Companion was built by ceramic artists who          │
│    understand the unique needs of showcasing ceramic         │
│    work. We provide the tools to catalog your work          │
│    internally and share it beautifully with the world.       │
│                                                               │
│  ┌──────────────────────┐    ┌──────────────────────┐      │
│  │   For Art Lovers      │    │    For Artists        │      │
│  │                       │    │                       │      │
│  │ • Discover artists    │    │ • Catalog your work   │      │
│  │ • Explore techniques  │    │ • Build your portfolio│      │
│  │ • Find inspiration    │    │ • Share your process  │      │
│  │ • Direct connection   │    │ • Connect with buyers │      │
│  └──────────────────────┘    └──────────────────────┘      │
│                                                               │
│              [Start Your Portfolio →]                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    ARTIST DIRECTORY                          │
│                                                               │
│                  Browse All Artists (24)                     │
│                                                               │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐    │
│  │      │ │      │ │      │ │      │ │      │ │      │    │
│  │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │    │
│  │      │ │      │ │      │ │      │ │      │ │      │    │
│  ├──────┤ ├──────┤ ├──────┤ ├──────┤ ├──────┤ ├──────┤    │
│  │Name  │ │Name  │ │Name  │ │Name  │ │Name  │ │Name  │    │
│  │Style │ │Style │ │Style │ │Style │ │Style │ │Style │    │
│  └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘    │
│                                                               │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐    │
│  │      │ │      │ │      │ │      │ │      │ │      │    │
│  │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │ │ IMG  │    │
│  │ ...  │ │ ...  │ │ ...  │ │ ...  │ │ ...  │ │ ...  │    │
│  └──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘    │
│                                                               │
│                    [Load More Artists]                       │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                          FOOTER                              │
│                                                               │
│  Clay Companion                                              │
│  By artists, for artists                                     │
│                                                               │
│  About  |  For Artists  |  Blog  |  Contact  |  Terms       │
│                                                               │
│  © 2025 Clay Companion. All rights reserved.                │
└─────────────────────────────────────────────────────────────┘
```

---

## Component Details

### 1. Navigation Bar
- **Logo**: "Clay Companion" (left)
- **Links**: Browse Artists | Login | Sign Up (right)
- **Behavior**: Fixed/sticky on scroll
- **Style**: Clean, minimal, white background

### 2. Hero Carousel
- **Images**: Curated featured artworks from multiple artists
- **Size**: Full-width, 60-70vh height
- **Overlay**: Semi-transparent gradient at bottom with:
  - Artwork title
  - Artist name (clickable)
  - Call-to-action: "Click to view artist profile →"
- **Controls**: Prev/Next arrows + dot indicators
- **Auto-rotate**: 7 seconds per slide (pause on hover)
- **Interaction**: Click anywhere on slide → artist profile

### 3. Platform Introduction
- **Layout**: Centered text block, max-width container
- **Headline**: "Discover Exceptional Ceramic Art" (large, bold)
- **Subhead**: 2 lines about discovery/inspiration
- **CTA Button**: "Explore Artists" (scrolls to directory)
- **Spacing**: Generous padding top/bottom

### 4. Search & Filter Bar
- **Search input**: Full-width with icon
- **Placeholder**: "Search by artist name, location, technique..."
- **Filters** (dropdown buttons):
  - **Clay Type**: Stoneware, Porcelain, Earthenware, Raku, Terracotta, Mixed Media
  - **Firing Type**: Cone 6, Cone 10, Raku, Pit Fire, Wood Fire, Electric, Gas, Soda/Salt
  - **Location**: City/State/Country (searchable dropdown)
- **Behavior**:
  - Real-time search (debounced 300ms)
  - Filters apply immediately to directory
  - Show active filter count badges
  - "Clear all" button when filters active

### 5. Featured Artists (3 cards)
- **Layout**: 3-column grid, equal width, responsive
- **Each card contains**:
  - **Primary image**: Square/portrait (400x500px approx)
  - **Artist name**: Large, bold
  - **Style/Specialty**: 1-2 words (e.g., "Functional Stoneware")
  - **Technique/Medium**: Secondary text
  - **Thumbnail row**: 2-3 small images (80x80px) showing recent work
  - **CTA Button**: "View Profile"
- **Spacing**: Generous whitespace between cards
- **Hover effect**: Subtle elevation/shadow

### 6. Value Proposition
- **Headline**: "By Artists, For Artists" (centered, large)
- **Body**: 2-3 sentences about platform origin/mission
- **Two columns** (50/50 split):
  - **For Art Lovers**:
    - Discover artists
    - Explore techniques
    - Find inspiration
    - Direct connection
  - **For Artists**:
    - Catalog your work
    - Build your portfolio
    - Share your process
    - Connect with buyers
- **CTA**: "Start Your Portfolio →" (button for artists to sign up)
- **Background**: Light background color to differentiate section

### 7. Artist Directory
- **Headline**: "Browse All Artists (24)" (dynamic count)
- **Grid**: 6 columns × N rows (responsive: 4 cols tablet, 2 cols mobile)
- **Cards**: Compact
  - Profile/artwork image (square, 200x200px)
  - Artist name (bold)
  - Primary style (secondary text)
- **Hover effect**: Scale up slightly, add shadow
- **Pagination**: "Load More Artists" button (load 12 more at a time)
- **Filtering**: Updates based on search/filter bar above
- **Empty state**: "No artists match your search. Try adjusting filters."

### 8. Footer
- **Background**: Light grey (#F5F5F5)
- **Content**:
  - Platform name and tagline: "By artists, for artists"
  - Links: About | For Artists | Blog | Contact | Terms | Privacy
  - Copyright notice: "© 2025 Clay Companion. All rights reserved."
- **Style**: Simple, minimal, centered text

---

## Responsive Behavior

### Desktop (>1024px)
- Full layout as shown
- 3-column featured artists
- 6-column directory grid
- Search bar with inline filters

### Tablet (768px - 1024px)
- 2-column featured artists (larger cards)
- 4-column directory grid
- Value prop columns stacked
- Filters stay inline (smaller)

### Mobile (<768px)
- 1-column featured artists (full-width, stacked)
- 2-column directory grid
- Hamburger menu for navigation
- Search/filters collapse to modal or accordion
- Hero carousel height reduced (50vh)

---

## Interaction Details

### Hero Carousel
- **Auto-advance**: Every 7 seconds
- **Pause**: On hover
- **Click**: Anywhere on image → navigate to artist profile
- **Keyboard**: Arrow keys for navigation
- **Touch**: Swipe left/right on mobile

### Search Bar
- **Real-time search**: Debounced (300ms)
- **Updates**: Directory results below
- **Clear button**: Appears when text entered

### Filters
- **Type**: Multi-select dropdowns
- **Apply**: Real-time (no "Apply" button needed)
- **Indicators**: Show count of active filters
- **Clear**: "Clear all filters" link when filters active

### Featured Artists Cards
- **Hover**: Slight elevation + shadow
- **Click**: Anywhere on card → artist profile
- **Button**: "View Profile" is primary CTA

### Directory Grid
- **Pagination**: "Load More" button (OR infinite scroll - decide during dev)
- **Loading state**: Skeleton loaders while fetching
- **Smooth updates**: Fade in/out when filtering

---

## Data Requirements

### Hero Carousel
- Source: Featured/curated artworks (admin-selected or algorithm)
- Fields needed: artwork image, title, artist name, artist slug

### Featured Artists
- Source: Featured artists (admin-selected or algorithm)
- Fields needed: artist name, slug, profile image, 3-4 artwork thumbnails, primary style/medium

### Artist Directory
- Source: All published artists
- Fields needed: artist name, slug, profile/artwork image, primary style
- Filters: Clay types, firing types, location

### Search
- Indexed fields: artist name, location, bio, techniques, clay types, firing types

---

## Technical Notes

### Performance
- Hero carousel: Lazy load non-visible slides
- Directory: Pagination or virtual scrolling for large artist counts
- Images: Next.js Image component with optimization
- Search: Debounce to reduce API calls

### SEO
- Server-side rendering for all content
- Metadata: "Discover ceramic artists and pottery portfolios"
- Structured data: Organization schema
- Sitemap: Include all artist profile links

### Accessibility
- Carousel: Pause button, keyboard navigation, ARIA labels
- Filters: Keyboard accessible dropdowns
- Images: Alt text for all artwork
- Color contrast: WCAG AA compliance

---

## Open Questions / Future Enhancements

1. **Hero Carousel Source**:
   - Admin-curated selection?
   - Algorithm-based (most liked, recent, etc.)?
   - Featured artwork flag in database?

2. **Featured Artists Selection**:
   - Rotating featured artists?
   - Manual curation by admin?
   - Algorithm (newest, most active)?

3. **Directory Pagination**:
   - "Load More" button?
   - Infinite scroll?
   - Traditional pagination (1, 2, 3...)?

4. **Artist Profiles Preview**:
   - Show artist count on hover?
   - Show follower count? (if social features added)

5. **Advanced Filters** (post-MVP):
   - Price range
   - Available for sale vs. portfolio only
   - Technique tags
   - Style tags

---

## Design References

- **Art-first marketplaces**: Saatchi Art, Artsy (for discovery)
- **Pottery-specific**: Ceramic Arts Network (for technique filters)
- **Portfolio platforms**: Behance (for artist cards)
- **Clean carousels**: Apple product pages

---

## Notes

- Keep visuals prominent - artwork is the hero
- Minimize text in hero section - let images speak
- Ensure fast load times for hero carousel
- Mobile experience is critical for discovery
- Consider adding "New Artists" or "Recently Updated" section in future
