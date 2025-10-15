# Clay Companion - UI Plan

## Overview
This document outlines the user interface design and page structure for Clay Companion MVP.

---

## Design Principles
- Clean, minimal design that puts artwork first
- Easy-to-use catalog management
- Professional portfolio presentation
- Mobile responsive
- Accessible (WCAG compliant)

---

## Dashboard Pages (Internal/Protected)

### 1. Login Page
**Purpose**: Artist authentication

**Layout**:
- Centered card/form
- Logo/app name at top
- Email input field
- Password input field
- "Login" button
- Clean, minimal design

**Questions to Resolve**:
- [ ] Include "Forgot password" functionality in MVP?
- [ ] Include "Remember me" checkbox?

**Status**: Planning

---

### 2. Dashboard Home (Activity Feed)
**Purpose**: Overview of recent activity and quick access

**Layout** (DECIDED):
- Activity feed showing recent changes:
  - "Added artwork X" (with thumbnail)
  - "Made series Y public"
  - "Updated exhibition Z"
  - "Uploaded 3 new photos to artwork X"
- Quick action buttons at top:
  - "+ Add Artwork"
  - "+ Add Series"
  - "View Catalog"
- Quick stats in header/sidebar:
  - Total artworks
  - Public vs Private count
  - Series count

**Feed Items Include**:
- Timestamp (e.g., "2 hours ago", "Yesterday")
- Action type icon
- Brief description
- Link to the item
- Thumbnail if applicable

**Status**: Planned ✓

---

### 3. Catalog - Artworks List
**Purpose**: View and manage all artworks

**Layout** (DECIDED - Option C: List View):
- Card-style list layout
- Each card shows:
  - Thumbnail on left
  - Title, description preview (truncated)
  - Metadata: Series, Year, Status (public/private badge)
  - Actions on right: Edit button, Delete button
  - Public/Private toggle switch
- Top section:
  - Search bar
  - Filters: All/Public/Private, Series dropdown
  - Sort: Recent, Title, Series
  - "+ Add Artwork" button
- Pagination or infinite scroll

**Wireframe**: To be created

**Status**: Planned ✓

---

### 4. Add/Edit Artwork
**Purpose**: Create new artwork or edit existing

**Layout** (DECIDED):
- **Left side (40%)**: Image upload and management
  - Drag-drop upload area
  - Uploaded images displayed below
  - Reorder images (drag to reorder)
  - Mark primary image
  - Delete images

- **Right side (60%)**: Form fields (scrollable)
  - **Basic Info**: Title*, Description
  - **Organization**: Series (dropdown/create), Group (dropdown)
  - **Clay Details**: Clay type, Firing cone, Firing schedule, Internal notes
  - **Physical Details**: Dimensions, Weight, Year created
  - **Display Settings**: Public toggle, Featured toggle, Availability status

- **Bottom**: Cancel, Save as Draft (optional), Save buttons

- **Mobile**: Stack vertically (images top, form below)

**Wireframe**: `wireframes/add-edit-artwork.md` ✓

**Status**: Planned ✓

---

### 5. Series Management
**Purpose**: Organize artworks into series and groups

**Layout** (DECIDED - Option B: Separate Pages):

**5a. Series List Page**:
- Shows all series as cards
- Each card displays:
  - Series title
  - Year range (e.g., "2024-2025")
  - Artwork count
  - Thumbnail (primary image from a piece in series)
  - Public/Private badge
  - Edit/Delete buttons
- "+ Create Series" button at top
- Drag-drop to reorder series

**5b. Series Detail Page**:
- Header: Series title, description, year range, public/private toggle
- Edit series info button
- Tabs or sections:
  - **Artworks in this series**: List of artworks (can assign more)
  - **Groups**: Create sub-groups, assign artworks to groups
- Drag-drop to reorder groups and artworks
- "+ Add Group" button
- "Assign Artworks" button (select from catalog)

**Wireframe**: To be created

**Status**: Planned ✓

---

### 6. Portfolio Settings
**Purpose**: Manage public-facing portfolio content

**Layout** (DECIDED - Option B: Separate Subpages):

Main navigation leads to subsections:

**6a. Profile Settings**:
- Artist name
- Bio (textarea)
- Artist statement (textarea)
- Profile photo upload
- Contact info (email, phone)
- Social media links (Instagram, Facebook, website, etc.)
- Save button

**6b. Exhibitions Management**:
- List of all exhibitions (past and upcoming)
- Each shows: Title, Venue, Location, Dates
- "+ Add Exhibition" button
- Edit/Delete buttons
- Drag-drop to reorder
- Form: Title, Venue, Location, Start/End dates, Description, Upcoming toggle

**6c. Press Mentions Management**:
- List of press mentions
- Each shows: Title, Publication, Date, Link
- "+ Add Press Mention" button
- Edit/Delete buttons
- Drag-drop to reorder
- Form: Title, Publication, URL, Published date, Excerpt

**6d. Studio/Process Photos**:
- Grid of studio and process images
- Upload photos (drag-drop)
- Each photo: Caption, Category (studio/process/other)
- Drag-drop to reorder
- Delete images

**6e. Techniques & Materials**:
- List of techniques artist uses
- Each: Name, Description
- "+ Add Technique" button
- Edit/Delete buttons
- Drag-drop to reorder
- Form: Technique name, Description

**Wireframe**: To be created

**Status**: Planned ✓

---

## Platform Pages (Multi-Artist Discovery)

### 7. Platform Homepage
**URL**: `claycompanion.com`
**Purpose**: Artist discovery, platform promotion, inspiration hub
**User Type**: Non-authenticated visitors, potential artists, art enthusiasts

**Layout** (DECIDED - Hybrid: Discovery + Marketing):
- **Fixed Navigation Bar**: Logo, Browse Artists, Login, Sign Up
- **Hero Carousel**: Featured artworks (7 sec auto-rotation) with artist attribution overlay
- **Platform Introduction**: Headline, subhead, "Explore Artists" CTA
- **Search & Filter Bar**: Real-time search + filters (clay type, firing type, location)
- **Featured Artists Section**: 3 artist cards (main image + 2-3 thumbnails + "View Profile" CTA)
- **Value Proposition**: "By artists, for artists" mission statement
  - Two columns: For Art Lovers / For Artists (4 bullets each)
  - "Start Your Portfolio" CTA
- **Artist Directory**: 6-column grid (responsive) with "Load More" pagination
- **Footer**: Platform links, copyright, tagline

**Key Features**:
- Real-time search with debouncing (300ms)
- Multi-select filter dropdowns
- Clickable carousel → artist profiles
- Featured artists showcase (3 artists)
- Browseable directory (all artists)

**Positioning**: "By artists, for artists" - discovery, inspiration, connection

**Wireframe**: `wireframes/platform-homepage.md` ✓

**Status**: Fully Planned & Finalized ✓

---

## Public Portfolio Pages (Individual Artist Sites)

### 8. Artist Profile (Landing Page)
**URL**: `claycompanion.com/artist-name`
**Purpose**: First impression, showcase featured work, introduce the artist

**Layout** (DECIDED - Minimal/Editorial with Enhanced Content):
- **Navigation Bar**: Fixed/sticky, Logo/Artist Name, Links (Gallery, About, Process, Exhibitions, Press, Techniques, Contact)
- **Hero Section**: Featured artwork with automatic rotation (5-10 sec when multiple featured pieces)
- **Artist Statement Preview**: 2-3 sentences from artist statement
- **Recent Work Section**: 4-6 thumbnails showing latest public artworks
- **Call to Action**: "View Gallery" or "View All Work" button
- **Footer**: Light grey background (#f8f9fa), Contact info, social links, copyright, "Powered by Clay Companion"

**Vibe**: Clean, minimal, puts the artwork first, editorial/artistic feel

**Decisions**:
1. Featured artwork: Automatic slideshow rotation
2. Navigation: Fixed/sticky (stays on scroll)
3. Content: Hero + statement + recent work grid
4. Footer: Light grey with branding (removable via paid subscription post-MVP)

**Wireframe**: `wireframes/artist-profile.md` ✓

**Status**: Fully Planned & Finalized ✓

---

### 9. Gallery
**URL**: `claycompanion.com/artist-name/gallery`
**Purpose**: Browse and explore all of an artist's public work, organized by series and groups

**Layout** (DECIDED - Single Scrollable Page):
- **Top Section**: Filter pills (horizontal scroll if many)
  - "Featured" (default) | "All" | Individual series names
- **Default View (Featured)**:
  - Curated mix of featured artworks, series, groups
  - Responsive grid: 4-col desktop, 3-col tablet, 1-2-col mobile
  - Image cards with title, year, series name below
- **"All" View**:
  - Organized by series sections (collapsible)
  - Each section: Series header + description + artworks
  - Groups shown as sub-sections within series
  - "Miscellaneous" section for ungrouped artworks at bottom
- **Single Series View**:
  - Click series filter to see only that series
  - Shows ungrouped artworks first, then groups

**Image Cards**:
- **Aspect Ratio**: Square (1:1) thumbnails in gallery grid
- **Crop**: Center crop or object-fit cover for squares
- Hover: Slight zoom (1.05x) on desktop
- Click: Opens lightbox with **original proportions** and full details
- **Metadata**: Title and year always visible below image
- Optional: Series name (if in Featured view)

**Series Sections** (in "All" view):
- Header: Series title + year range
- Description: 2-3 lines
- Expand/collapse toggle
- Ungrouped artworks shown first
- Groups as labeled sub-sections

**Visibility Logic**:
- Items with `is_hidden_from_gallery = true` never appear
- Featured filter shows items where `is_featured = true`
- Must also be `is_public = true`

**Performance**:
- **Infinite scroll**: Load 20-30 images initially, auto-load more at 80% scroll
- Lazy loading with skeleton screens
- Square thumbnails for grid, original proportions in lightbox
- Sort: Newest first (year_created DESC)

**Grid Spacing**: Spacious/generous (MVP default)

**Wireframe**: `wireframes/gallery.md` ✓

**Status**: Fully Planned & Finalized ✓

---

### 10. About
**URL**: `claycompanion.com/artist-name/about`
**Purpose**: Tell the artist's story, share philosophy, and provide background/credentials

**Layout** (DECIDED - Two-Column):
- **Desktop**: Two columns (30/70 split)
  - Left: Portrait photo + Studio photo (optional)
  - Right: All text content (statement, bio, education, awards)
  - Gap: 3-4rem between columns
- **Mobile**: Single column stacked (photo → text → photo → text)

**Content Sections**:
- **Artist Statement** (required):
  - First-person voice ("I", "My")
  - 2-4 paragraphs (200-400 words)
  - Philosophy, inspiration, approach, goals
- **Biography** (required):
  - Third-person voice (use artist name)
  - 2-3 paragraphs (150-300 words)
  - Education, career highlights, current activities, influences
- **Education** (optional):
  - Bulleted list format
  - Degree, field, institution, year
  - Most recent first
- **Awards & Recognition** (optional):
  - Bulleted list format
  - Award name, organization, year
  - Most recent first

**Photos**:
- Portrait: 3:4 or 2:3 aspect ratio (vertical)
- Studio photo: 4:3 or 16:9 (horizontal), optional
- High quality, optimized for web

**Typography**:
- Body text: 18px+ for readability
- Line height: 1.7-1.8
- Max-width: ~650px for optimal reading
- Clear section headers with dividers

**Wireframe**: `wireframes/about.md` ✓

**Status**: Fully Planned & Finalized ✓

---

### 11. Process/Studio
**Purpose**: Behind-the-scenes content

**Status**: To be planned

---

### 12. Exhibitions
**Purpose**: Past and upcoming shows

**Status**: To be planned

---

### 13. Press
**Purpose**: Media mentions and articles

**Status**: To be planned

---

### 14. Techniques & Materials
**Purpose**: Educational content about artist's methods

**Status**: To be planned

---

### 15. Contact
**Purpose**: Display contact information

**Status**: To be planned

---

## Component Library

### Reusable Components to Build
- [ ] Navbar (dashboard and public versions)
- [ ] Footer (public portfolio)
- [ ] Image uploader with drag-drop
- [ ] Image gallery grid
- [ ] Image lightbox/modal
- [ ] Form components (input, textarea, select, etc.)
- [ ] Card components
- [ ] Button variants
- [ ] Loading states
- [ ] Empty states
- [ ] Error states

---

## Design Resources

### Inspiration/References
- (To be added)

### Color Scheme
- (To be decided)

### Typography
- (To be decided)

---

## Next Steps
1. Complete planning for Dashboard Home page
2. Plan remaining dashboard pages
3. Plan public portfolio pages
4. Create wireframes/mockups (optional)
5. Document component specifications
