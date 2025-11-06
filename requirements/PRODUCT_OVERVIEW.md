# Clay Companion - Product Overview

**Last Updated**: 2025-11-05
**Document Type**: Tech-Agnostic Product Requirements

---

## What is Clay Companion?

Clay Companion is a **multi-artist portfolio platform** specifically designed for ceramic artists. It provides professional online portfolios with built-in artwork catalog management, allowing artists to showcase their work and manage their practice from a single platform.

---

## Vision & Mission

**By Artists, For Artists**

Clay Companion is built to serve the ceramic arts community with tools that understand the unique needs of ceramic artists - from glaze recipes and firing schedules to series organization and exhibition history.

**Core Goals**:
- Make professional online portfolios accessible to ceramic artists
- Provide powerful catalog management tools for studio practice
- Build a discovery platform for art lovers and collectors
- Support the ceramic arts community with purpose-built tools

---

## Target Users

### Primary: Ceramic Artists
- Professional ceramic artists who need portfolio websites
- Artists managing multiple series, exhibitions, and artworks
- Artists who want to showcase their process and practice
- Artists seeking discoverability and professional presentation

### Secondary: Art Lovers & Collectors
- People discovering ceramic artwork and artists
- Collectors researching artists and their work
- Gallery owners and curators
- Ceramic enthusiasts and students

---

## Platform Architecture

### Multi-Artist Platform
- Each artist gets their own URL: `claycompanion.com/artist-name`
- Platform homepage for artist discovery and marketing
- Unified platform with individual artist portfolios
- Subscription-based artist accounts (future monetization)

### Dual Interface
1. **Public Portfolio** - Artist's professional website
2. **Private Dashboard** - Internal catalog and management tools

---

## MVP Scope

### Included in MVP

**Internal Catalog System**:
- Full artwork management (add, edit, organize)
- Multiple images per artwork
- Series and group organization
- Public/private visibility toggles
- Featured artwork curation
- Ceramic-specific metadata (clay type, firing, glazes, etc.)

**Public Portfolio**:
- Professional artist landing page
- Gallery with series filtering
- About page (bio, statement, education, awards)
- Process/Studio photos (behind-the-scenes)
- Exhibition history
- Press mentions
- Contact information

**Authentication**:
- Single artist login
- Secure account management
- Password reset functionality

**Image Management**:
- Multiple photo uploads per artwork
- Image reordering
- Primary image selection

### Excluded from MVP (Post-MVP)

- E-commerce/shopping cart functionality
- Blog system
- Contact form with messaging center (display contact info only)
- Advanced customization (custom themes, colors, layouts)
- Analytics dashboard
- Paid subscription tier (white-label branding removal)
- Custom domain support
- Techniques & Materials page

---

## Key Features

### For Artists (Dashboard)

**Artwork Cataloging**:
- Comprehensive artwork database
- Ceramic-specific metadata fields:
  - Clay body type (Stoneware, Porcelain, Earthenware, etc.)
  - Firing temperature and cone (Cone 6, Cone 10, etc.)
  - Firing schedule (Reduction, Oxidation, etc.)
  - Glaze descriptions and recipes
  - Dimensions and weight
  - Year created
  - Internal private notes
- Availability status (Available, Sold, Commissioned, Not for Sale)

**Organization**:
- Series management (collections of related work)
- Optional groups within series (sub-collections)
- Drag-and-drop reordering
- Featured artwork selection

**Content Management**:
- Profile editing (bio, statement, photo)
- Exhibition management (past and upcoming)
- Press mention tracking
- Studio/process photo galleries
- Contact settings

**Visibility Controls**:
- Public/private toggles for artworks, series, groups
- Featured flags for highlighting specific work
- Hidden flags to keep items internal-only

### For Public Visitors

**Artist Portfolio**:
- Professional landing page with featured work
- Complete gallery with filtering by series
- Artist biography and statement
- Behind-the-scenes studio/process photos
- Exhibition history (chronological with featured section)
- Press mentions (chronological with featured section)
- Contact information

**Discovery** (Platform Level):
- Browse all artists on the platform
- Search and filter functionality
- Featured artists showcase
- Featured artwork carousel

---

## Content Structure

### Portfolio Pages (Public)
Each artist's portfolio includes:
1. **Artist Profile** - Landing page with featured work
2. **Gallery** - All public artworks, filterable by series
3. **About** - Bio, statement, photo, education, awards
4. **Process/Studio** - Behind-the-scenes photos with captions
5. **Exhibitions** - Featured exhibitions + chronological history
6. **Press** - Featured articles + chronological list
7. **Contact** - Contact info and social media links

### Dashboard Pages (Private)
Artist management interface:
1. **Dashboard Home** - Activity feed and quick actions
2. **Catalog** - Full artwork list with search/filter
3. **Add/Edit Artwork** - Comprehensive artwork form
4. **Series Management** - Organize artworks into collections
5. **Settings** - Profile, exhibitions, press, studio photos, contact

---

## Design Philosophy

### Artwork-First
The design recedes into the background, allowing ceramic artwork to take center stage. Gallery-like minimalism with generous spacing and clean presentation.

### Professional Yet Authentic
Not corporate or generic - professional tools built by and for artists. Authentic voice and artist-centric language throughout.

### Accessible
WCAG AA accessibility compliance as a minimum standard. Universal design principles for all users.

---

## Data Model Concepts

### Core Entities
- **Artist Profile** - Artist account and public profile information
- **Artworks** - Individual ceramic pieces with full metadata
- **Series** - Collections of related artworks
- **Artwork Groups** - Optional sub-groupings within series
- **Artwork Images** - Multiple photos per artwork
- **Exhibitions** - Past and upcoming shows
- **Exhibition Images** - Photos for featured exhibitions
- **Press Mentions** - Media coverage and articles
- **Studio Images** - Process and behind-the-scenes photos
- **Techniques** - Materials and methods (Post-MVP)

### Key Relationships
- One artist has many artworks, series, exhibitions, press mentions
- One series has many artworks and groups
- One artwork belongs to one series (optional) and one group (optional)
- One artwork has many images
- One exhibition has many images (for featured exhibitions)

---

## User Workflows

### Artist Onboarding
1. Create account (email/password)
2. Set up profile (name, bio, photo)
3. Add first artwork with images
4. Organize into series (optional)
5. Set visibility (public/private)
6. Preview public portfolio
7. Share portfolio URL

### Catalog Management
1. Add artwork with metadata
2. Upload multiple images
3. Assign to series/group
4. Set availability status
5. Toggle public/private
6. Feature on homepage
7. Reorder in catalog/gallery

### Portfolio Building
1. Complete profile (bio, statement, photo)
2. Add exhibitions and press
3. Upload studio/process photos
4. Set contact information
5. Feature key artworks
6. Organize gallery by series
7. Preview and publish

### Public Discovery
1. Visit platform homepage
2. Browse featured artists/artwork
3. Search or filter by criteria
4. Click into artist portfolio
5. Explore gallery and series
6. View artwork details
7. Contact artist

---

## Technical Requirements (High-Level)

### Authentication & Security
- Secure user authentication
- Session management
- Password reset functionality
- Row-level data access control

### Image Storage & Optimization
- Multiple image upload support
- Image optimization and resizing
- Fast image delivery
- Storage management

### Performance
- Fast page load times (<3s)
- Image lazy loading
- Responsive design (mobile, tablet, desktop)
- Search engine optimization (SEO)

### Data Management
- Relational database for structured data
- Full CRUD operations for all entities
- Data validation and integrity
- Backup and recovery

---

## Success Metrics (Future)

### For Artists
- Time to create first portfolio (< 30 minutes)
- Number of artworks cataloged
- Portfolio views and engagement
- Contact inquiries received

### For Platform
- Number of active artists
- Total artworks published
- Visitor engagement (time on site, pages per visit)
- Artist retention and growth

---

## Future Enhancements (Post-MVP)

### Artist Features
- E-commerce integration (sell artwork directly)
- Blog/news section
- Contact form with in-app messaging
- Advanced customization (colors, layouts, fonts)
- Analytics dashboard
- Custom domain support
- Paid tier (white-label, premium features)

### Platform Features
- Advanced search and filtering
- Artist-to-artist networking
- Techniques & Materials educational content
- Mobile app (iOS/Android)
- Social features (follow, like, comment)
- Print-on-demand services

### Studio Management
- Kiln schedule tracking
- Glaze recipe database
- Inventory management
- Commission tracking
- Test tile documentation

---

## Competitive Differentiation

**Why Clay Companion vs. Generic Portfolio Builders?**

1. **Ceramic-Specific**: Built for clay artists with fields for firing, glazes, clay bodies
2. **Dual Purpose**: Public portfolio + private catalog management
3. **Community Platform**: Multi-artist discovery, not just single artist sites
4. **Artist-Centric**: By artists, for artists - understanding the unique needs
5. **Affordable**: Accessible pricing for working artists

---

## Constraints & Considerations

### MVP Constraints
- Single artist login (no multi-user accounts per artist)
- Display-only contact info (no contact form with messaging)
- No e-commerce functionality
- Standard template design (no custom themes)
- No blog or news section
- No custom domain support

### Design Constraints
- Must work on mobile, tablet, desktop
- Fast load times even with many high-res images
- Accessible to users with disabilities
- SEO-friendly for artist discoverability

### Business Constraints
- Free tier for MVP (monetization post-MVP)
- Scalable architecture for growth
- Cost-effective hosting and storage

---

## Open Questions

### Artwork Detail Pages
- Should clicking artwork in gallery open a modal/lightbox?
- Or navigate to dedicated page with shareable URL?
- Consider: SEO benefits vs. UX flow

### Settings Navigation
- Should `/dashboard/settings` show overview or redirect to first subsection?
- How to handle breadcrumb navigation in nested settings?

### Login URL Convention
- Should login be at `/login` or `/dashboard/login`?
- What's more intuitive for artists?

---

## Notes

This document intentionally avoids technical implementation details (frameworks, databases, languages) to remain technology-agnostic. The focus is on **what** Clay Companion does and **why**, not **how** it's built technically.

When selecting a new tech stack, refer to this document for product requirements, then choose technologies that best serve these needs within your constraints (development speed, cost, scalability, maintainability).

---

**Document Version**: 1.0 (Tech-Agnostic)
**Source Documents**: Extracted from DECISIONS.md, FEATURES.md, PAGE_TREE.md
