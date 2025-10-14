# Clay Companion - Page Tree Structure

**Last Updated**: 2025-10-14

---

## URL Structure Overview

```
claycompanion.com/
├── [Platform Root - TBD for MVP]
│
└── {artist-name}/                           [Public Portfolio]
    ├── (landing)                            Artist Profile (Landing Page)
    ├── gallery/                             Gallery (All Public Artworks)
    │   └── {artwork-slug}                   Individual Artwork Detail (TBD)
    ├── about/                               About (Bio & Statement)
    ├── process/                             Process/Studio (Behind-the-scenes)
    ├── exhibitions/                         Exhibitions (Past & Upcoming)
    ├── press/                               Press (Media Mentions)
    ├── techniques/                          Techniques & Materials
    └── contact/                             Contact (Display Info)

claycompanion.com/dashboard/                 [Protected Dashboard]
├── login/                                   Login Page
├── (home)                                   Dashboard Home (Activity Feed)
├── catalog/                                 Artworks Catalog
│   ├── (list)                               Catalog List View
│   ├── add/                                 Add New Artwork
│   └── {artwork-id}/edit/                   Edit Artwork
├── series/                                  Series Management
│   ├── (list)                               Series List
│   ├── add/                                 Create New Series
│   └── {series-id}/                         Series Detail Page
│       └── edit/                            Edit Series (optional separate page)
└── settings/                                Portfolio Settings
    ├── profile/                             Profile Settings
    ├── exhibitions/                         Exhibitions Management
    ├── press/                               Press Mentions Management
    ├── studio/                              Studio/Process Photos
    └── techniques/                          Techniques & Materials
```

---

## Detailed Page Breakdown

### 🌐 Public Portfolio Pages
**Base URL**: `claycompanion.com/{artist-name}/`
**Access**: Public (no authentication required)
**Nav**: Shared navigation bar across all public pages

| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Artist Profile** | `/{artist-name}` | Landing page, featured work, intro | ✅ Planned |
| **Gallery** | `/{artist-name}/gallery` | All public artworks, filterable | 🔄 Planning |
| **Artwork Detail** | `/{artist-name}/gallery/{artwork-slug}` | Individual artwork page | ⏳ TBD |
| **About** | `/{artist-name}/about` | Bio, statement, photo | ⏳ To plan |
| **Process/Studio** | `/{artist-name}/process` | Behind-the-scenes photos | ⏳ To plan |
| **Exhibitions** | `/{artist-name}/exhibitions` | Past & upcoming shows | ⏳ To plan |
| **Press** | `/{artist-name}/press` | Media mentions | ⏳ To plan |
| **Techniques** | `/{artist-name}/techniques` | Materials & methods | ⏳ To plan |
| **Contact** | `/{artist-name}/contact` | Contact info display | ⏳ To plan |

---

### 🔒 Dashboard Pages (Protected)
**Base URL**: `claycompanion.com/dashboard/`
**Access**: Authenticated artists only
**Nav**: Dashboard sidebar/top nav

#### Authentication
| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Login** | `/dashboard/login` OR `/login` | Artist login | ✅ Planned |

#### Dashboard Home
| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Dashboard Home** | `/dashboard` | Activity feed, quick actions | ✅ Planned |

#### Catalog Management
| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Catalog List** | `/dashboard/catalog` | View all artworks | ✅ Planned |
| **Add Artwork** | `/dashboard/catalog/add` | Create new artwork | ✅ Planned |
| **Edit Artwork** | `/dashboard/catalog/{artwork-id}/edit` | Edit existing artwork | ✅ Planned |

#### Series Management
| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Series List** | `/dashboard/series` | View all series | ✅ Planned |
| **Create Series** | `/dashboard/series/add` | Create new series | ✅ Planned |
| **Series Detail** | `/dashboard/series/{series-id}` | Manage series & groups | ✅ Planned |

#### Portfolio Settings
| Page | URL | Purpose | Status |
|------|-----|---------|--------|
| **Settings Home** | `/dashboard/settings` | Settings navigation (or redirect to profile) | ✅ Planned |
| **Profile Settings** | `/dashboard/settings/profile` | Artist info, bio, statement | ✅ Planned |
| **Exhibitions** | `/dashboard/settings/exhibitions` | Manage exhibitions | ✅ Planned |
| **Press Mentions** | `/dashboard/settings/press` | Manage press mentions | ✅ Planned |
| **Studio Photos** | `/dashboard/settings/studio` | Upload studio/process images | ✅ Planned |
| **Techniques** | `/dashboard/settings/techniques` | Manage techniques list | ✅ Planned |

---

## Navigation Flow

### Public Portfolio Navigation
**Shared nav bar** on all public pages:
- Artist Name/Logo (links to Artist Profile landing)
- Gallery
- About
- Process
- Exhibitions
- Press
- Techniques
- Contact

**Fixed/sticky navigation** (stays on scroll)

---

### Dashboard Navigation
**Sidebar or Top Nav** on all dashboard pages:
- Dashboard (home)
- Catalog
- Series
- Settings
- View Public Profile (link to public portfolio)
- Logout

---

## Open Questions

### Platform Root Page
**Question**: What should `claycompanion.com` (root domain) show?

**Options**:
- **Option A (MVP - Simple)**: Redirect to artist's portfolio (since single artist for MVP)
- **Option B**: Simple landing page explaining Clay Companion with "Go to Dashboard" link
- **Option C**: Marketing page for Clay Companion platform
- **Option D**: Directory/list of artists (for multi-artist post-MVP)

**Decision**: TBD - need to decide for MVP

---

### Individual Artwork Detail Page
**Question**: Should clicking an artwork in the gallery open a modal/lightbox, or navigate to a dedicated page?

**Options**:
- **Option A**: Lightbox/modal (no separate page URL)
- **Option B**: Dedicated artwork detail page with URL (`/gallery/{artwork-slug}`)

**Decision**: TBD - will decide when planning Gallery page

**Considerations**:
- Option B is better for SEO
- Option B allows sharing individual artwork URLs
- Option A keeps users in the gallery flow
- Could do both: modal by default, with shareable URL

---

### Login URL
**Question**: Should login be at `/login` or `/dashboard/login`?

**Options**:
- **Option A**: `/login` (simpler, cleaner)
- **Option B**: `/dashboard/login` (organized under dashboard)

**Decision**: TBD

---

### Settings Landing
**Question**: What happens when artist visits `/dashboard/settings`?

**Options**:
- **Option A**: Show navigation/overview of all settings sections
- **Option B**: Redirect to `/dashboard/settings/profile` (first subsection)
- **Option C**: No `/settings` route, only subpages directly accessible

**Decision**: TBD

---

## URL Naming Conventions

### Slugs & IDs
- **Artist name**: Lowercase, hyphenated (e.g., `jane-doe-ceramics`)
- **Artwork slug**: Generated from title, lowercase, hyphenated (e.g., `vessel-no-47`)
- **Series ID**: UUID or integer (e.g., `123` or `abc-def-ghi`)
- **Artwork ID**: UUID or integer for editing routes

### URL Style
- Lowercase only
- Hyphens for spaces (not underscores)
- No trailing slashes (or consistent trailing slashes - TBD)

---

## Breadcrumb Navigation

### Public Pages
Most public pages are top-level, so minimal breadcrumbs needed:
```
Artist Name > Gallery
Artist Name > About
```

Individual artwork (if dedicated page):
```
Artist Name > Gallery > "Vessel No. 47"
```

### Dashboard Pages
Dashboard needs clear breadcrumbs:
```
Dashboard > Catalog
Dashboard > Catalog > Add Artwork
Dashboard > Catalog > Edit "Vessel No. 47"
Dashboard > Series > "2024 Collection"
Dashboard > Settings > Profile
```

---

## Navigation States

### Active Page Indicators
- Public nav: Underline or color change for current page
- Dashboard nav: Highlight or background change for current section

### Nested Navigation
- Series detail page might need sub-nav (Artworks tab, Groups tab)
- Settings pages have sub-navigation for subsections

---

## Notes

- All dashboard pages require authentication
- All public portfolio pages are accessible without login
- Public pages pull from database (only show public content)
- Dashboard shows all content (public + private)
- 404 page needed for invalid URLs
- Consider 403/unauthorized page for protected routes

---

## Next Steps

1. Decide on platform root page behavior (`claycompanion.com`)
2. Decide on individual artwork detail page approach
3. Finalize login URL convention
4. Determine settings landing page behavior
5. Continue planning remaining public pages

---

**Status**: Draft - needs decisions on open questions
