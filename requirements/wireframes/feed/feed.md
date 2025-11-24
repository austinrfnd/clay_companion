# Feed Page Wireframe

**Last Updated**: 2025-11-22
**Changes**: Updated mobile menu to full-width overlay pattern, recommended badge positioning, SVG icons
**Status**: Ready for Implementation
**Preview**: [feed-preview.html](feed-preview.html)

---

## Overview

The Feed page is the default dashboard view after login. It displays updates from followed artists in chronological order, with recommendations when the feed is sparse.

---

## Page Structure

### Desktop Layout

**Two-Column Layout**:
- **Left Column (Feed)**: ~70% width, max-width: 800px
- **Right Column (Sidebar)**: 320px fixed width
- **Gap**: 24px between columns

**Header**:
- Clay Companion logo (left)
- Navigation: My Work | Settings | Sign Out (right)

**Feed Column**:
- Hamburger menu button (mobile only, left of "Feed" heading)
- "Feed" heading with Refresh button (SVG icon)
- Feed items (cards) with 40px spacing
- Load More button at bottom

**Sidebar**:
- Suggested Artists section
- Your Stats section

---

## Feed Item Cards

### Artwork Card

**Structure**:
```
┌─────────────────────────────────────┐
│ [Avatar] Artist Name    2h ago    │
├─────────────────────────────────────┤
│                                     │
│      [Large Artwork Image]          │
│      (16:9 aspect ratio)            │
│                                     │
├─────────────────────────────────────┤
│ Title                               │
│ 2024 • Stoneware • Cone 10         │
│ Part of "Series Name"              │
│ [View Artwork →]                   │
└─────────────────────────────────────┘
```

**Elements**:
- Artist avatar (40px circle)
- Artist name (clickable → portfolio)
- Timestamp ("2 hours ago")
- Artwork image (clickable → artwork detail)
- Title, metadata, series info
- "View Artwork" button

---

### Studio Image Card

**Structure**:
```
┌─────────────────────────────────────┐
│ [Avatar] Name [Recommended] 5h ago │
│ [Follow] button                     │
├─────────────────────────────────────┤
│                                     │
│   [Studio Image] [Process Badge]   │
│   (4:3 aspect ratio)                │
│                                     │
├─────────────────────────────────────┤
│ Caption text (truncated to 2 lines)│
│ [View Studio Page →]                │
└─────────────────────────────────────┘
```

**Elements**:
- Artist avatar and name
- "Recommended" badge (positioned to the right of artist name, inline)
- Follow button (if not following)
- Studio image with category badge overlay
- Caption (max 2 lines, ellipsis)
- "View Studio Page" button

---

### Exhibition Card

**Structure**:
```
┌─────────────────────────────────────┐
│ [Avatar] Artist Name    1 day ago  │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ New Exhibition                │  │
│ │ "Exhibition Title"            │  │
│ │ Venue Name                    │  │
│ │ Jan 15 - Feb 28, 2025        │  │
│ │ [Solo Badge]                  │  │
│ │                               │  │
│ │ [Exhibition Thumbnail]        │  │
│ └───────────────────────────────┘  │
│ [View Exhibition →]                │
└─────────────────────────────────────┘
```

**Elements**:
- Nested card design (exhibition info in inner card)
- Exhibition type badge (Solo / Group / Online)
- Image thumbnail (if available)
- "View Exhibition" button

---

### Press Mention Card

**Structure**:
```
┌─────────────────────────────────────┐
│ [Avatar] Artist Name    3 days ago │
├─────────────────────────────────────┤
│ ┌───────────────────────────────┐  │
│ │ "Article Title"                │  │
│ │ Publication Name               │  │
│ │ Published: Dec 1, 2024        │  │
│ │                               │  │
│ │ Excerpt text (2-3 lines)...   │  │
│ └───────────────────────────────┘  │
│ [Read Article →]                    │
└─────────────────────────────────────┘
```

**Elements**:
- Text-focused card (no image)
- Article title, publication, date
- Excerpt (truncated to 2-3 lines)
- "Read Article" button (external link)

---

## Mobile Menu Overlay

### Structure (Mobile Only)

**Full-Width Overlay**:
```
┌─────────────────────────────────────┐
│ Menu                          [X]   │  ← Header (sticky)
├─────────────────────────────────────┤
│                                     │
│  Suggested Artists                  │
│  ─────────────────────────────      │
│  [Avatar] Artist One                │
│  Portland, OR                       │
│  [Follow]                           │
│  ─────────────────────────────      │
│  [Avatar] Artist Two                │
│  Seattle, WA                        │
│  [Follow]                           │
│                                     │
│  Your Stats                         │
│  ─────────────────────────────      │
│  • 12 Artworks                      │
│  • 45 Followers                     │
│  • 8 Following                       │
│                                     │
└─────────────────────────────────────┘
```

**Elements**:
- **Header**: "Menu" title (left) + X close button (right)
- **Full-width**: 100% viewport width
- **Sections**: Suggested Artists, Your Stats (same as desktop sidebar)
- **Backdrop**: Dark overlay behind menu (50% opacity)
- **Animation**: Slides down from top (0.3s ease transition)
- **Scroll**: Menu content scrollable if needed

---

## Sidebar Components

### Suggested Artists

**Structure**:
```
┌─────────────────────┐
│ Suggested Artists   │
├─────────────────────┤
│ [Avatar] Name       │
│ Location            │
│ [Follow]            │
├─────────────────────┤
│ [Avatar] Name       │
│ Location            │
│ [Follow]            │
└─────────────────────┘
```

**Elements**:
- Artist avatar (32px circle)
- Artist name (clickable)
- Location
- Follow button

---

### Your Stats

**Structure**:
```
┌─────────────────────┐
│ Your Stats          │
├─────────────────────┤
│ • 12 Artworks       │
│ • 45 Followers      │
│ • 8 Following       │
└─────────────────────┘
```

**Elements**:
- Simple list with counts
- Clickable (future: link to detail pages)

---

## Empty States

### New User (No Follows)

**Structure**:
```
┌─────────────────────────────────────┐
│         [Icon]                      │
│                                     │
│  Welcome to Clay Companion!        │
│                                     │
│  Start following artists to see    │
│  their latest work...               │
│                                     │
│  [Discover Artists →]               │
│                                     │
│  ─────────────────────────────      │
│                                     │
│  Suggested Artists:                 │
│  [Artist cards with Follow buttons]│
└─────────────────────────────────────┘
```

---

### Sparse Feed (Few Follows)

**Structure**:
```
┌─────────────────────────────────────┐
│ [Regular feed items from followed] │
│                                     │
│  ─────────────────────────────      │
│                                     │
│  Recommended for You                │
│                                     │
│  [Recommended artist cards...]      │
└─────────────────────────────────────┘
```

---

## Design System Compliance

### Colors
- **Background**: Mist (#F5F7F6)
- **Card Background**: White (#FFFFFF)
- **Border**: Pale Celadon (#E8EDEA)
- **Text**: Charcoal (#1F2421)
- **Secondary Text**: Slate (#6B7280)
- **Accent**: Celadon Green (#6E9180)
- **Buttons**: Celadon Dark (#527563)

### Typography
- **Font**: Inter (Google Fonts)
- **Headings**: 700 weight
- **Body**: 400 weight
- **Labels**: 500-600 weight

### Spacing
- **Card Gap**: 40px (2.5rem)
- **Card Padding**: 24px (1.5rem)
- **Border Radius**: 8px (0.5rem)

### Interactions
- **Hover**: Subtle shadow elevation
- **Click**: Smooth transitions
- **Loading**: Skeleton loaders
- **Empty States**: Helpful CTAs

---

## Responsive Behavior

### Desktop (> 1024px)
- Two-column layout (feed + sidebar)
- Full sidebar visible on right (320px fixed width)
- Hamburger menu hidden
- Refresh button visible (SVG icon)
- Mobile menu overlay hidden

### Tablet (768px - 1024px)
- Single column layout
- Sidebar hidden by default
- Hamburger menu visible
- Full-width overlay menu when opened

### Mobile (< 768px)
- Single column (sidebar hidden by default)
- Hamburger menu button (top-left, next to "Feed" heading)
- Sidebar appears as full-width overlay that slides down from top
- Mobile header with "Menu" title and X close button (top right)
- Dark overlay backdrop (50% opacity)
- Body scroll locked when menu is open
- Full-width cards
- Stacked layout
- Tap overlay or X button to close sidebar

---

## Accessibility

- **Keyboard Navigation**: Tab through cards, Enter to open, Escape to close menu
- **Screen Readers**: Proper ARIA labels (`aria-label`, `aria-expanded` on hamburger button)
- **Focus Indicators**: Clear focus states on all interactive elements
- **Alt Text**: All images have descriptive alt text
- **Color Contrast**: WCAG AA compliance (4.5:1 minimum)
- **Touch Targets**: Minimum 44px × 44px for all buttons (hamburger, close, follow)

---

## Interactive Elements

### Follow Button
- **Not Following**: "Follow" (Celadon Dark background)
- **Following**: "Following" (outline style)
- **Hover**: Darker background or border change

### View Buttons
- **Style**: Outline button (border, transparent background)
- **Hover**: Fill with Celadon Green
- **Text**: "View [Content Type] →"

### Refresh Button
- **Style**: Outline button in header (right side)
- **Icon**: SVG refresh icon (Heroicons style)
- **Action**: Reload feed content
- **Hover**: Background fill, border color change

### Hamburger Menu Button (Mobile)
- **Style**: Bordered button with hamburger icon (SVG)
- **Position**: Left of "Feed" heading
- **Size**: 2.5rem × 2.5rem (44px touch target)
- **Hover**: Background fill, border color change
- **Action**: Opens full-width overlay menu

### Mobile Menu Overlay
- **Style**: Full-width overlay (100% width, slides down from top)
- **Header**: "Menu" title (left) + X close button (right)
- **Animation**: Slides down with smooth transition (0.3s ease)
- **Backdrop**: Dark overlay (rgba(0, 0, 0, 0.5))
- **Close Methods**: X button, tap backdrop, or resize to desktop
- **Body Scroll**: Locked when menu is open

---

## Data Requirements

### Feed Items
- Artist ID, name, avatar
- Content type (artwork, studio_image, exhibition, press_mention)
- Content ID and metadata
- Timestamp (relative: "2 hours ago")
- Recommendation flag (if recommended)

### Sidebar
- Suggested artists (from recommendation engine)
- Current artist stats (artworks count, followers, following)

---

## Next Steps

1. Review HTML preview
2. Implement in Rails views
3. Add Stimulus controllers for interactions
4. Connect to feed API endpoints

---

**See Also**:
- Product Definition: `requirements/feed/FEED_PRODUCT_DEFINITION.md`
- Implementation Plan: `requirements/feed/FEED_IMPLEMENTATION_PLAN.md`
- Visual Mockup: `requirements/feed/FEED_VISUAL_MOCKUP.md`
- Post-MVP Features: `requirements/POST_MVP_FEATURES.md#social--community-features-post-mvp-phase`

