# Clay Companion - Decisions Log

This document tracks all major decisions made during planning and development.

---

## Project Decisions

### 🚨 Architecture Change: Multi-Artist Platform

**Decision**: Clay Companion is now a **multi-artist platform** for MVP
**Date**: 2025-10-14
**Rationale**:
- Better market fit - serve multiple artists from day one
- Platform growth potential
- Revenue model: Subscription-based artist accounts
- Each artist gets their own URL: `claycompanion.com/artist-name`
- Platform needs its own homepage for discovery and marketing

**Previous Decision** (now superseded): Single ceramic artist
**Date**: 2025-10-13

---

### MVP Scope

**Included in MVP**:
- Internal catalog system (full artwork management)
- Public portfolio (gallery, about, process, exhibitions, press, techniques, contact)
- Authentication (single artist login)
- Image management and uploads
- Series and grouping organization
- Public/private visibility toggles
- Featured artwork functionality

**Excluded from MVP** (Post-MVP):
- E-commerce/shopping cart
- Blog system
- Contact form with messaging center (just display contact info in MVP)
- Multi-artist platform
- Advanced customization (themes, colors)
- Analytics dashboard
- Paid subscription tier (white-label branding removal + premium features)

**Date**: 2025-10-13

---

## Tech Stack Decisions

### Framework
**Decision**: Next.js 14+ with App Router
**Date**: 2025-10-13
**Rationale**:
- Industry standard
- Server-side rendering for web app
- Built-in API routes for future mobile app
- Serverless-ready
- Great developer experience

### Language
**Decision**: TypeScript
**Date**: 2025-10-13
**Rationale**: Type safety, better IDE support, industry standard

### Database & Backend
**Decision**: Supabase (PostgreSQL)
**Date**: 2025-10-13
**Rationale**:
- All-in-one solution (database + auth + storage)
- Auto-generated APIs
- Serverless-friendly
- Good free tier
- Can use cloud during development, add local setup later

### Styling
**Decision**: Tailwind CSS
**Date**: 2025-10-13
**Rationale**: Fast development, utility-first, industry standard

### Component Library
**Decision**: shadcn/ui
**Date**: 2025-10-13
**Rationale**: Copy-paste components (own the code), accessible, modern

### Form Handling
**Decision**: React Hook Form
**Date**: 2025-10-13
**Rationale**: Best performance, easy validation, TypeScript support

### Image Management
**Decision**: Supabase Storage + react-dropzone + Next.js Image
**Date**: 2025-10-13
**Rationale**:
- Supabase Storage for hosting (integrated with database)
- react-dropzone for drag-drop UX
- Next.js Image for optimization

### Deployment
**Decision**: Vercel
**Date**: 2025-10-13
**Rationale**: Made by Next.js creators, dead simple deployment, serverless

---

## Database Schema Decisions

### Tables Designed
1. `artist_profile` - Single artist information
2. `series` - Collection of related works
3. `artwork_groups` - Sub-groupings within series
4. `artworks` - Individual pieces with full metadata
5. `artwork_images` - Multiple photos per artwork
6. `exhibitions` - Past and upcoming shows
7. `press_mentions` - Media coverage
8. `studio_images` - Process and behind-the-scenes photos
9. `techniques` - Materials and methods used

**Date**: 2025-10-13

---

## Feature Decisions

### Contact Functionality
**Decision**: MVP displays contact info only (no form)
**Post-MVP**: Add contact form with in-app messaging center
**Date**: 2025-10-13

### Content Management
**Decision**: Artists can:
- Drag-and-drop reorder images/galleries
- Toggle public/private for artworks
- Feature/pin artworks to homepage
- Mark availability status (available/sold/commissioned/not for sale)

**Date**: 2025-10-13

### Authentication
**Decision**: Single artist login for MVP
**Future**: Can add multiple users (artist + assistants) post-MVP
**Date**: 2025-10-13

### Blog
**Decision**: Not included in MVP
**Post-MVP**: Full blog system with rich text editor
**Date**: 2025-10-13

---

## Portfolio Content Decisions

### Public Portfolio Sections
**Included**:
- Homepage with featured work
- Gallery (filterable by series)
- About (bio, statement, photo)
- Process/Studio (behind-the-scenes)
- Exhibitions (past and upcoming)
- Press (media mentions)
- Techniques & Materials (educational)
- Contact (display info only)

**Date**: 2025-10-13

### Additional Features Research
Based on research of ceramic artist portfolios, included:
- Artist statement
- Studio/process photos
- Exhibition history
- Press mentions
- Techniques and materials education

**Date**: 2025-10-13

---

## Architecture Decisions

### Mobile App Strategy
**Decision**: Build web app with Next.js first, include API routes for future mobile app
**Post-MVP**: React Native mobile app consuming Next.js APIs
**Rationale**: Single codebase, shared backend (Supabase), APIs ready when needed

**Date**: 2025-10-13

### Local Development
**Decision**: Start with Supabase cloud for development
**Future**: Can migrate to local Supabase setup (with Docker) later
**Rationale**: Simpler to get started, can add local setup once comfortable

**Date**: 2025-10-13

---

## UI/UX Decisions

### Design Approach
**Decision**: Standard template for MVP
**Future**: Allow customization (colors, layouts) post-MVP
**Date**: 2025-10-13

---

### Dashboard UI Decisions

#### Login Page
**Decision**: Simple centered form (email, password, login button)
**Open Questions**:
- Forgot password functionality in MVP? (TBD)
- Remember me checkbox? (TBD)
**Date**: 2025-10-13

#### Dashboard Home
**Decision**: Activity feed showing recent changes
- Shows: "Added artwork X", "Made series Y public", etc.
- Quick action buttons at top (+ Add Artwork, + Add Series, View Catalog)
- Quick stats in header/sidebar
**Date**: 2025-10-13

#### Catalog - Artworks List
**Decision**: List view with horizontal cards (Option C)
- Each card: thumbnail left, title/description/metadata, actions right
- Top: search bar, filters (All/Public/Private, Series), sort options
- "+ Add Artwork" button
**Date**: 2025-10-13

#### Add/Edit Artwork
**Decision**: Split layout
- Left side (40%): Image upload and management (drag-drop, reorder, mark primary)
- Right side (60%): Form fields in sections (Basic, Organization, Clay Details, Physical, Display)
- Bottom: Cancel, Save as Draft (optional), Save buttons
- Mobile: Stack vertically
**Wireframe**: Created at `wireframes/add-edit-artwork.md`
**Date**: 2025-10-13

#### Series Management
**Decision**: Separate pages approach (Option B)
- Series List Page: Cards showing all series
- Series Detail Page: Shows artworks and groups within that series
- Drag-drop reordering at all levels
**Date**: 2025-10-13

#### Portfolio Settings
**Decision**: Separate subpages (Option B, not tabs)
- Profile Settings
- Exhibitions Management
- Press Mentions Management
- Studio/Process Photos
- Techniques & Materials
**Date**: 2025-10-13

---

### Public Portfolio UI Decisions

#### Artist Profile (Landing Page)
**URL Structure**: `claycompanion.com/artist-name`
**Decision**: Minimal/Editorial style with enhanced content
- **Hero section**: Featured artwork with automatic rotation (5-10 seconds if multiple featured)
- **Artist statement**: 2-3 sentence preview
- **Recent work section**: 4-6 thumbnail grid showing latest public pieces
- **Navigation**: Fixed/sticky nav bar (stays on scroll)
- **Footer**: Light grey background (#f8f9fa) with "Powered by Clay Companion" branding
- **Call to Action**: "View Gallery" or "View All Work" button
**Vibe**: Artwork-first, clean, minimal, editorial/artistic
**Wireframe**: Created at `wireframes/artist-profile.md`
**Date**: 2025-10-14

**Detailed Decisions**:
1. Featured artwork rotation: Automatic slideshow (5-10 sec) when multiple featured
2. Navigation: Fixed/sticky at top
3. Content: Hero + statement + recent work grid (4-6 pieces)
4. Artist statement: 2-3 sentence preview
5. Footer: Light grey background for differentiation
6. Branding: "Powered by Clay Companion" in footer (MVP)

#### Platform Homepage
**URL**: `claycompanion.com`
**Decision**: Hybrid approach combining discovery and marketing
- **Overall feel**: Balanced - showcase artwork/artists while promoting platform
- **Goal**: "Discover cool artists. Discover cool artwork. Inspiration."
- **Hero section**: Carousel with featured artwork + artist attribution (7 sec rotation)
- **Search & Filters**: Clay type, firing type, artist name, location
- **Featured Artists**: 3 artists with substantial showcase (main image + 2-3 thumbnails)
- **Value Proposition**: "By artists, for artists" mission statement
- **Artist Directory**: Browseable/filterable grid of all artists (6-col desktop, responsive)
- **Call to Actions**: "Explore Artists", "Start Your Portfolio"
**Wireframe**: Created at `wireframes/platform-homepage.md`
**Date**: 2025-10-14

**Detailed Decisions**:
1. Hero carousel: Featured artworks with clickable artist attribution
2. Search: Real-time with debouncing (300ms)
3. Filters: Multi-select dropdowns (clay type, firing type, location)
4. Featured artists: 3 cards with main image + thumbnails
5. Directory: 6-column grid with "Load More" pagination
6. Value prop: Two-column split (For Art Lovers / For Artists)
7. Positioning: "By artists, for artists"

#### Gallery Page
**URL**: `claycompanion.com/artist-name/gallery`
**Decision**: Single scrollable page with featured filter and series organization
- **Default View**: Featured filter (shows curated selection of featured artworks/series/groups)
- **Layout Type**: Single scrollable page with sectioned content (not separate pages)
- **Organization Depth**: Series → Groups (optional) → Artworks
- **Filter Options**: Featured (default) | All | Individual Series Names
- **Series Display**: Collapsible sections with series header, description, and organized content
- **Groups**: Optional, public-facing, shown as sub-sections within series
- **Ungrouped Work**: Shows in "Miscellaneous" section at bottom
- **Grid Layout**: Responsive (4-col desktop, 3-col tablet, 1-2-col mobile)
- **Image Interaction**: Click to open lightbox with full details
**Wireframe**: Created at `wireframes/gallery.md`
**Date**: 2025-10-14

**Detailed Decisions**:
1. Featured filter: Default view showing curated/featured items
2. Visibility controls: Artists can feature OR hide artworks, groups, and series
3. Series collapse/expand: User can collapse series sections (state saved in localStorage)
4. Groups: External-facing but optional (work can be in series without groups)
5. Image aspect ratio: Square (1:1) thumbnails in gallery, original proportions in lightbox
6. Pagination: Infinite scroll (load 20-30 initially, auto-load more)
7. Metadata: Title and year always visible below images
8. Grid density: Spacious/generous spacing (MVP default)
9. Sort order: Newest first (year_created DESC, created_at DESC)
10. Performance: Lazy loading, square thumbnails for grid, original images for lightbox

**Database Changes**:
- Added `is_featured` flag to artworks, series, and artwork_groups tables
- Added `is_hidden_from_gallery` flag to artworks, series, and artwork_groups tables

#### Remaining Public Pages
**Status**: To be planned next
- About, Process, Exhibitions, Press, Techniques, Contact
**Date**: 2025-10-14

---

## Timeline Decision

**Development Plan**: 9-week roadmap
- Week 1: Setup & foundation
- Week 2-3: Internal catalog core
- Week 4: Advanced catalog features
- Week 5: Portfolio settings
- Week 6-7: Public portfolio
- Week 8: Polish & testing
- Week 9: Deployment

**Date**: 2025-10-13

---

## Open Questions

*(Questions waiting for decisions)*

### Login Page
- [ ] Include "Forgot password" functionality in MVP?
- [ ] Include "Remember me" checkbox?

### Dashboard Home
- [ ] What should artist see first when logging in?
- [ ] Dashboard with widgets, or simple list view?

---

## Post-MVP Monetization

### Paid Subscription Tier
**Concept**: Offer premium subscription to remove Clay Companion branding and unlock advanced features

**Potential Features**:
- Remove "Powered by Clay Companion" footer branding (white-label)
- Custom domain support
- Advanced theme customization (colors, fonts, layouts)
- Priority support
- Analytics dashboard
- Additional storage/bandwidth
- Custom CSS/branding

**Status**: To be explored post-MVP
**Date**: 2025-10-14

---

## Notes

- All decisions are documented here as we make them
- Open questions are tracked until resolved
- This document should be updated whenever a decision is made
