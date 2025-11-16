# Clay Companion - Page Structure & Navigation

**Last Updated**: 2025-11-05
**Document Type**: Tech-Agnostic Page Requirements

---

## Overview

This document defines the complete page structure, URL hierarchy, and navigation system for Clay Companion. It is technology-agnostic and focuses on information architecture and user navigation patterns.

---

## URL Structure

### Complete Site Map

```
claycompanion.com/
├── /                                    Platform Homepage (Discovery & Marketing)
├── /about                               Platform About Page
│
└── /{artist-name}/                      [Public Portfolio]
    ├── /                                Artist Profile (Landing Page)
    ├── /gallery                         Gallery (All Public Artworks)
    │   └── /{artwork-slug}              Individual Artwork Detail (Optional/TBD)
    ├── /about                           About (Bio & Statement)
    ├── /process                         Process/Studio (Behind-the-scenes)
    ├── /exhibitions                     Exhibitions (Past & Upcoming)
    ├── /press                           Press (Media Mentions)
    ├── /techniques                      Techniques & Materials (Post-MVP)
    └── /contact                         Contact (Display Info & Instagram)

/login                                   Login Page (OR /dashboard/login)
/signup                                  Signup Page (OR /dashboard/signup)

/dashboard/                              [Protected Dashboard]
├── /                                    Dashboard Home (Activity Feed)
├── /catalog                             Artworks Catalog
│   ├── /                                Catalog List View
│   ├── /add                             Add New Artwork
│   └── /{artwork-id}/edit               Edit Artwork
├── /series                              Series Management
│   ├── /                                Series List
│   ├── /add                             Create New Series
│   └── /{series-id}                     Series Detail Page
│       └── /edit                        Edit Series (Optional)
└── /settings                            Settings Hub
    ├── /                                Settings Index (Dashboard Placeholder)
    ├── /account                         Account Settings
    ├── /privacy                         Privacy Settings (Post-MVP)
    ├── /profile                         Profile Settings
    ├── /studio                          Studio Settings
    ├── /work                            Work Settings
    ├── /exhibitions                     Exhibitions Management
    ├── /press                           Press Management
    └── /techniques                      Techniques (Post-MVP)
```

---

## Page Inventory

### Platform Pages (Public)

**Base URL**: `claycompanion.com/`

| Page | URL | Purpose | Auth Required | Status |
|------|-----|---------|---------------|--------|
| Platform Homepage | `/` | Artist discovery, featured content, platform promotion | No | MVP |
| Platform About | `/about` | Mission, story, features, how it works | No | MVP |

**Page Details**:

**Platform Homepage**:
- Hero carousel with featured artwork
- Search and filters (clay type, firing type, artist, location)
- Featured artists showcase (3 artists)
- Value proposition ("By artists, for artists")
- Artist directory (browseable, filterable grid)
- CTAs: "Explore Artists", "Start Your Portfolio"

**Platform About**:
- Hero with tagline
- What is Clay Companion?
- Who It's For (artists vs art lovers)
- Features showcase (8-card grid)
- How It Works (3-step onboarding)
- Our Story (origin story)
- Final CTA

---

### Artist Portfolio Pages (Public)

**Base URL**: `claycompanion.com/{artist-name}/`

| Page | URL | Purpose | Auth Required | Status |
|------|-----|---------|---------------|--------|
| Artist Profile | `/{artist-name}` | Landing page, featured work, intro | No | MVP |
| Gallery | `/{artist-name}/gallery` | All public artworks, filterable by series | No | MVP |
| Artwork Detail | `/{artist-name}/gallery/{artwork-slug}` | Individual artwork page (optional) | No | TBD |
| About | `/{artist-name}/about` | Bio, statement, photo, education, awards | No | MVP |
| Process/Studio | `/{artist-name}/process` | Behind-the-scenes photos with captions | No | MVP |
| Exhibitions | `/{artist-name}/exhibitions` | Featured exhibitions + chronological history | No | MVP |
| Press | `/{artist-name}/press` | Featured articles + chronological list | No | MVP |
| Techniques | `/{artist-name}/techniques` | Materials & methods educational content | No | Post-MVP |
| Contact | `/{artist-name}/contact` | Contact info, social links, Instagram feed | No | MVP |

**Shared Features**:
- Fixed/sticky navigation bar on all public pages
- Footer with "Powered by Clay Companion" branding
- Responsive design (mobile, tablet, desktop)
- SEO optimized (meta tags, structured data)

---

### Authentication Pages

| Page | URL | Purpose | Auth Required | Status |
|------|-----|---------|---------------|--------|
| Login | `/login` | Artist login | No (redirect if authenticated) | MVP |
| Signup | `/signup` | Artist registration | No (redirect if authenticated) | MVP |
| Password Reset | `/reset-password` | Forgot password flow | No | MVP |

**Note**: URL convention TBD - Could be `/login` or `/dashboard/login` (to be decided)

---

### Dashboard Pages (Protected)

**Base URL**: `claycompanion.com/dashboard/`

| Page | URL | Purpose | Auth Required | Status |
|------|-----|---------|---------------|--------|
| Dashboard Home | `/dashboard` | Activity feed, quick actions, stats | Yes | MVP |
| Catalog List | `/dashboard/catalog` | View all artworks with filters | Yes | MVP |
| Add Artwork | `/dashboard/catalog/add` | Create new artwork | Yes | MVP |
| Edit Artwork | `/dashboard/catalog/{id}/edit` | Edit existing artwork | Yes | MVP |
| Series List | `/dashboard/series` | View all series | Yes | MVP |
| Create Series | `/dashboard/series/add` | Create new series | Yes | MVP |
| Series Detail | `/dashboard/series/{id}` | Manage series, groups, artworks | Yes | MVP |
| Settings Home | `/dashboard/settings` | Settings hub with dashboard placeholder | Yes | MVP |
| Account Settings | `/dashboard/settings/account` | Basic account info (name, location, profile photo) | Yes | MVP |
| Privacy Settings | `/dashboard/settings/privacy` | Password and security settings | Yes | Post-MVP |
| Profile Settings | `/dashboard/settings/profile` | Public profile content (bio, statement, education, awards, social links, contact) | Yes | MVP |
| Studio Settings | `/dashboard/settings/studio` | Studio photos and process page settings | Yes | MVP |
| Work Settings | `/dashboard/settings/work` | Links to catalog, series, exhibitions, press management | Yes | MVP |
| Exhibitions | `/dashboard/settings/exhibitions` | Manage exhibitions | Yes | MVP |
| Press | `/dashboard/settings/press` | Manage press mentions | Yes | MVP |
| Techniques | `/dashboard/settings/techniques` | Manage techniques list | Yes | Post-MVP |

**Shared Features**:
- Sidebar or top navigation on all dashboard pages
- Settings pages use persistent sidebar navigation (no breadcrumbs)
- "View Public Portfolio" link
- Logout option
- Responsive design

---

## Navigation Systems

### Platform Navigation (Public Pages)

**Platform Homepage/About Navigation**:
```
[Logo] Clay Companion
├── Home
├── About
├── Browse Artists
└── [CTA] Start Your Portfolio (signup)
```

---

### Artist Portfolio Navigation

**Fixed/Sticky Navigation Bar** (appears on all artist portfolio pages):

```
[Artist Name/Logo]
├── Gallery
├── About
├── Process
├── Exhibitions
├── Press
├── Techniques (Post-MVP)
└── Contact
```

**Behavior**:
- Fixed to top on scroll (sticky)
- Active page indicator (underline or color change)
- Mobile: Hamburger menu (☰) → Side drawer
- Artist name/logo links back to artist profile landing page

**Footer** (on all artist portfolio pages):
```
Social Media Icons (Instagram, Facebook, etc.)
Quick Links (Gallery, About, Contact)
"Powered by Clay Companion" branding
```

---

### Dashboard Navigation

**Main Dashboard Navigation** (appears on all dashboard pages):

```
[Dashboard]
├── 🏠 Dashboard
├── 📁 Catalog
├── 📚 Series
├── ⚙️ Settings
├── 👁️ View Public Portfolio
└── 🚪 Logout
```

**Settings Hub Navigation** (persistent sidebar on all settings pages):

```
[Settings Sidebar - 240px width]
├── 👤 Account
├── 🔒 Privacy
├── 📝 Profile
├── 🏠 My Studio
└── 🎨 My Work
```

**Behavior**:
- Main dashboard uses top navigation or sidebar
- Settings pages have dedicated persistent sidebar (left side, 240px)
- Active page indicator in settings sidebar (highlighted background, left border)
- Settings sidebar always visible on desktop, collapsible on tablet, hidden on mobile (hamburger toggle)
- Mobile: Collapsible menu or slide-out drawer
- Responsive design

**Breadcrumbs** (on non-settings dashboard pages):
```
Dashboard > Catalog
Dashboard > Catalog > Add Artwork
Dashboard > Series > "2024 Collection"
```

**Note**: Settings pages do NOT use breadcrumbs - they use the persistent sidebar navigation instead.

---

## URL Naming Conventions

### Slug Generation

**Artist Name Slugs**:
- Lowercase only
- Hyphens for spaces (not underscores)
- Remove special characters
- Examples:
  - "Jane Doe" → `jane-doe`
  - "Sarah Martinez-Ceramics" → `sarah-martinez-ceramics`

**Artwork Slugs** (for dedicated artwork pages, if implemented):
- Generated from artwork title
- Lowercase, hyphens for spaces
- Remove special characters
- Append ID if title conflicts
- Examples:
  - "Vessel No. 47" → `vessel-no-47`
  - "Blue Bowl" → `blue-bowl`
  - "Blue Bowl" (second) → `blue-bowl-2` (or use ID)

**URL Style**:
- Lowercase only
- Hyphens (not underscores)
- No trailing slashes (or consistent trailing slashes - choose one)
- Descriptive, human-readable
- SEO-friendly

---

## Page-Level Requirements

### All Pages

**Meta Information**:
- Unique page title (for browser tab and SEO)
- Meta description (for search results)
- Open Graph tags (for social sharing)
- Canonical URL
- Responsive viewport meta tag

**Accessibility**:
- Semantic HTML structure
- Proper heading hierarchy (H1 → H2 → H3, no skipping)
- Skip to main content link
- ARIA landmarks (nav, main, footer)
- Alt text on images
- Focus indicators
- Keyboard navigation

**Performance**:
- Fast load times (< 3s)
- Lazy load images below fold
- Optimize critical rendering path
- Minimize HTTP requests
- Compress assets

---

### Public Pages

**SEO Requirements**:
- Unique meta titles and descriptions per page
- Structured data (Schema.org JSON-LD):
  - Person (artist)
  - CreativeWork (artworks)
  - Event (exhibitions)
- XML sitemap for all public pages
- Robots.txt configuration
- Social sharing preview images

**Caching**:
- Cache public pages for performance
- Cache-control headers
- CDN delivery for global speed

---

### Protected Pages (Dashboard)

**Authentication**:
- Require valid session/token
- Redirect to login if unauthenticated
- Preserve intended destination (redirect back after login)

**Authorization**:
- Verify user has access to requested resource
- Prevent access to other artists' data

**Session Management**:
- Keep session alive during activity
- Show warning before session timeout
- Handle expired sessions gracefully

---

## Route Protection Matrix

| Route Pattern | Public Access | Authenticated Access | Notes |
|---------------|---------------|----------------------|-------|
| `/` | ✅ Yes | ✅ Yes | Platform homepage |
| `/about` | ✅ Yes | ✅ Yes | Platform about |
| `/{artist-name}/*` | ✅ Yes | ✅ Yes | Artist portfolios |
| `/login`, `/signup` | ✅ Yes | ❌ Redirect to dashboard | Auth pages |
| `/dashboard/*` | ❌ Redirect to login | ✅ Yes | Protected dashboard |

---

## Error Pages

### 404 - Not Found

**Scenarios**:
- Invalid artist name: `claycompanion.com/nonexistent-artist`
- Invalid page URL: `claycompanion.com/artist-name/invalid-page`
- Invalid artwork ID: `claycompanion.com/dashboard/catalog/invalid-id/edit`

**Content**:
- "Page not found" message
- Suggestion: "Search for artists" or "Return to homepage"
- Links to platform homepage or search
- Design consistent with site aesthetic

### 403 - Forbidden

**Scenarios**:
- Attempt to access another artist's dashboard
- Attempt to edit another artist's content

**Content**:
- "Access denied" message
- Suggestion: "Please login to your own account"
- Link to login page
- Link to homepage

### 500 - Server Error

**Scenarios**:
- Database connection failure
- Unexpected server errors
- Third-party service failures

**Content**:
- "Something went wrong" message
- Suggestion: "Please try again in a moment"
- Link to homepage
- Contact support option (email or link)

---

## Redirects

### Authentication Redirects

**Unauthenticated User Accesses Dashboard**:
- From: `/dashboard/catalog`
- To: `/login?redirect=/dashboard/catalog`
- After login: Redirect to originally requested page

**Authenticated User Accesses Auth Pages**:
- From: `/login`
- To: `/dashboard`
- Prevents logged-in users from seeing login/signup

### Legacy/Changed URLs (Post-MVP)

**When URLs change**:
- Implement 301 redirects from old to new URLs
- Preserve SEO value and bookmarks
- Update XML sitemap

---

## Open Questions

### Artwork Detail Pages

**Question**: Should clicking artwork in gallery open a modal/lightbox, or navigate to a dedicated page?

**Options**:
- **Option A**: Lightbox/modal (no separate page URL)
  - Pros: Keeps users in gallery flow, simpler implementation
  - Cons: Not shareable, no individual SEO for artworks

- **Option B**: Dedicated artwork detail page with URL (`/{artist-name}/gallery/{artwork-slug}`)
  - Pros: Shareable URLs, better SEO, deep linking
  - Cons: More pages to implement, navigates away from gallery

**Recommendation**: Hybrid approach:
- Default: Click opens lightbox/modal
- URL updates on lightbox open (pushState)
- Direct URL access opens page with lightbox
- Share button in lightbox copies URL
- Best of both worlds: flow + shareable URLs

---

### Login URL Convention

**Question**: Should login be at `/login` or `/dashboard/login`?

**Options**:
- **Option A**: `/login` (and `/signup`, `/reset-password`)
  - Pros: Simpler, shorter, more conventional
  - Cons: Not nested under dashboard

- **Option B**: `/dashboard/login` (and `/dashboard/signup`)
  - Pros: Organized under dashboard namespace
  - Cons: Longer URL, less conventional

**Recommendation**: `/login` (Option A)
- More conventional and expected
- Shorter, easier to remember
- Auth is technically separate from dashboard

---

### Settings Landing Page

**Decision**: `/dashboard/settings` shows a Settings Hub with:
- **Persistent Sidebar**: Left navigation with all 5 settings sections (Account, Privacy, Profile, My Studio, My Work)
- **Main Content Area**: Placeholder for future dashboard content
  - Profile view statistics
  - Friend/connection requests
  - Pending purchases of your work
  - Recent activity feed
  - Notifications
  - Quick actions/widgets
  - Analytics and insights

**Structure**:
- Settings index page (`/dashboard/settings`) serves as the hub
- All settings sub-pages share the same persistent sidebar
- Sidebar provides consistent navigation across all settings pages
- Main content area on index page will be designed in a future phase

---

## Mobile Navigation Considerations

### Artist Portfolio (Mobile)

**Hamburger Menu**:
- Icon: ☰ (three horizontal lines)
- Location: Top right corner
- Tap to open: Slide-out drawer or overlay
- Menu items:
  - Gallery
  - About
  - Process
  - Exhibitions
  - Press
  - Contact
- Tap item to navigate, menu closes
- Tap outside menu to close

**Mobile Footer**:
- Simplified footer on mobile
- Essential links only
- Social media icons (larger tap targets)

### Dashboard (Mobile)

**Main Dashboard Navigation**:
- Hamburger menu or bottom tab bar
- Essential navigation items visible
- "View Portfolio" accessible
- Logout accessible

**Settings Pages (Mobile)**:
- Settings sidebar hidden by default
- Hamburger menu button in header to toggle sidebar
- Sidebar opens as slide-out drawer from left
- All 5 settings sections accessible in drawer
- Active section highlighted in drawer

---

## Accessibility Navigation

### Keyboard Navigation

**Tab Order**:
- Logical tab order through interactive elements
- Skip to main content link (first focusable element)
- Skip nav links for screen readers

**Keyboard Shortcuts**:
- `Tab`: Move to next interactive element
- `Shift + Tab`: Move to previous element
- `Enter/Space`: Activate links and buttons
- `Esc`: Close modals/lightboxes
- `Arrow keys`: Navigate within menus or carousels

### Screen Reader Navigation

**Landmarks**:
- `<header>`: Site header with navigation
- `<nav>`: Navigation menus
- `<main>`: Main page content
- `<aside>`: Sidebars (if any)
- `<footer>`: Site footer

**Heading Structure**:
- One `<h1>` per page (page title)
- Logical `<h2>` - `<h6>` hierarchy
- No skipping levels

**ARIA Labels**:
- `aria-label` on icon-only buttons
- `aria-current="page"` on active nav item
- `aria-expanded` on collapsible menus

---

## Notes

This page structure is technology-agnostic and can be implemented with:
- Server-side routing (traditional multi-page)
- Client-side routing (SPA with framework router)
- Hybrid approach (SSR + client-side hydration)
- Static site generation with dynamic routes

Choose routing approach based on:
- Framework capabilities
- SEO requirements
- Performance needs
- Development team preferences

---

**Document Version**: 1.0 (Tech-Agnostic)
**Source Documents**: Extracted from PAGE_TREE.md, DECISIONS.md, wireframe specs
