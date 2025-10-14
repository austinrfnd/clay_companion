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

## Public Portfolio Pages

### 7. Homepage (Public Landing)
**Purpose**: First impression, showcase featured work, introduce the artist

**Layout** (DECIDED - Option C: Minimal/Editorial):
- **Navigation Bar**: Logo/Artist Name, Links (Gallery, About, Process, Exhibitions, Press, Techniques, Contact)
- **Hero Section**: Single large featured artwork image with title
- **Artist Statement Preview**: 2-3 sentences from artist statement
- **Call to Action**: "View Gallery" button or "Explore My Work"
- **Footer**: Contact info, social links, copyright

**Vibe**: Clean, minimal, puts the artwork first, editorial/artistic feel

**Wireframe**: To be created

**Status**: Planned ✓

**NEXT**: Continue planning remaining public pages (Gallery, About, Process, etc.)

---

### 8. Gallery
**Purpose**: Showcase public artworks

**Status**: TO BE PLANNED NEXT SESSION

**Questions to Resolve**:
- [ ] Layout: Masonry grid, equal-height grid, or list?
- [ ] Filtering: By series, year, or both?
- [ ] Image modal/lightbox behavior
- [ ] Show artwork details on hover or click?

---

### 9. About
**Purpose**: Artist bio and statement

**Status**: To be planned

---

### 10. Process/Studio
**Purpose**: Behind-the-scenes content

**Status**: To be planned

---

### 11. Exhibitions
**Purpose**: Past and upcoming shows

**Status**: To be planned

---

### 12. Press
**Purpose**: Media mentions and articles

**Status**: To be planned

---

### 13. Techniques & Materials
**Purpose**: Educational content about artist's methods

**Status**: To be planned

---

### 14. Contact
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
