# Artist Profile Page - Wireframe

**URL**: `claycompanion.com/artist-name`

**Purpose**: Landing page for artist's public portfolio - first impression for visitors

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  Artist Name / Logo        Gallery  About  Process  Exhibitions  Press      │
│                                                  Techniques  Contact          │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│                                                                               │
│                        ╔═════════════════════════════╗                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║      FEATURED ARTWORK       ║                       │
│                        ║      (Large Hero Image)     ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ║                             ║                       │
│                        ╚═════════════════════════════╝                       │
│                                                                               │
│                          "Vessel No. 47" - 2024                               │
│                                                                               │
│                                                                               │
│                   ─────────────────────────────────────                      │
│                                                                               │
│                     My work explores the relationship                         │
│                   between form and function in ceramic art.                  │
│                   Each piece is hand-thrown and glazed with                  │
│                        materials sourced from local clay.                    │
│                                                                               │
│                   ─────────────────────────────────────                      │
│                                                                               │
│                                                                               │
│                          [ View Gallery ]                                    │
│                                                                               │
│                                                                               │
│                                                                               │
│                                                                               │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  hello@artistname.com  |  (555) 123-4567                                    │
│                                                                               │
│  Instagram  Facebook  Twitter  Website                                       │
│                                                                               │
│  © 2024 Artist Name. All rights reserved.                                   │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Tablet Layout (768px - 1024px)

```
┌────────────────────────────────────────────────────────┐
│                                                          │
│  Artist Name                             ☰ Menu         │
│                                                          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                                                          │
│           ╔═══════════════════════════════╗             │
│           ║                               ║             │
│           ║                               ║             │
│           ║     FEATURED ARTWORK          ║             │
│           ║     (Large Hero Image)        ║             │
│           ║                               ║             │
│           ║                               ║             │
│           ╚═══════════════════════════════╝             │
│                                                          │
│              "Vessel No. 47" - 2024                      │
│                                                          │
│        ─────────────────────────────────────            │
│                                                          │
│          My work explores the relationship               │
│        between form and function in ceramic             │
│        art. Each piece is hand-thrown and               │
│        glazed with materials sourced from               │
│                   local clay.                            │
│                                                          │
│        ─────────────────────────────────────            │
│                                                          │
│                [ View Gallery ]                          │
│                                                          │
│                                                          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                                                          │
│  hello@artistname.com  |  (555) 123-4567                │
│  [Instagram] [Facebook] [Twitter] [Website]             │
│  © 2024 Artist Name. All rights reserved.               │
│                                                          │
└────────────────────────────────────────────────────────┘
```

---

## Mobile Layout (320px - 767px)

```
┌───────────────────────────────┐
│                               │
│  Artist Name          ☰ Menu  │
│                               │
└───────────────────────────────┘

┌───────────────────────────────┐
│                               │
│  ╔═══════════════════════╗    │
│  ║                       ║    │
│  ║                       ║    │
│  ║   FEATURED ARTWORK    ║    │
│  ║   (Large Hero Image)  ║    │
│  ║                       ║    │
│  ║                       ║    │
│  ╚═══════════════════════╝    │
│                               │
│   "Vessel No. 47" - 2024      │
│                               │
│  ───────────────────────────  │
│                               │
│  My work explores the         │
│  relationship between form    │
│  and function in ceramic      │
│  art. Each piece is hand-     │
│  thrown and glazed with       │
│  materials sourced from       │
│  local clay.                  │
│                               │
│  ───────────────────────────  │
│                               │
│     [ View Gallery ]          │
│                               │
│                               │
└───────────────────────────────┘

┌───────────────────────────────┐
│                               │
│  hello@artistname.com         │
│  (555) 123-4567               │
│                               │
│  [IG] [FB] [TW] [WEB]         │
│                               │
│  © 2024 Artist Name           │
│                               │
└───────────────────────────────┘
```

---

## Layout Specifications

### Navigation Bar

- **Desktop**:
  - Full horizontal nav with all links visible
  - Artist name/logo on left
  - Links spread across right side
  - Max-width: ~1200px, centered
- **Mobile/Tablet**:
  - Hamburger menu (☰)
  - Slides in from right or drops down
  - Artist name always visible
- **Behavior**:
  - Fixed/sticky on scroll? (TBD)
  - Background: White/off-white or transparent with subtle backdrop
  - Active page indicator (underline or color)

### Hero Section

- **Container**: Max-width ~1200px, centered
- **Image aspect ratio**: 3:2 or 4:3 (landscape orientation preferred)
- **Image behavior**:
  - Responsive (scales with viewport)
  - Maintains aspect ratio
  - High-quality, optimized for web
- **Title placement**:
  - Centered below image
  - Font: Elegant serif or artist's preferred typeface
  - Size: 1.5rem - 2rem
- **Spacing**: Generous whitespace (3-4rem) around hero section

### Artist Statement Preview

- **Width**: Max-width ~650px for optimal readability
- **Alignment**: Centered
- **Font**:
  - Slightly larger than body text (1.125rem - 1.25rem)
  - Serif or elegant sans-serif
  - Line height: 1.6-1.8 for readability
- **Decorative lines**: Optional subtle horizontal rules above/below
- **Spacing**: 2-3rem padding on top/bottom

### Call to Action Button

- **Style**: Primary button (prominent but tasteful)
- **Size**: Large enough to be obvious (~48px height)
- **Colors**: Matches brand/theme (TBD in design phase)
- **Hover state**: Subtle color shift or scale (1.05x)
- **Spacing**: 2rem margin above, 4rem below

### Footer

- **Background**: Light grey (#f8f9fa) or off-white - subtle differentiation
- **Padding**: 3rem vertical, responsive horizontal
- **Content layout**:
  - **Desktop**: Multi-row, centered
    - Row 1: Contact info (email | phone)
    - Row 2: Social links (icon buttons)
    - Row 3: Copyright text
  - **Mobile**: Stacked, centered
- **Social icons**:
  - Size: ~32px
  - Spacing: 0.5rem between
  - Color: Subtle grey, darker on hover
- **Typography**: Smaller than body (0.875rem - 1rem)

---

## Interaction & Behavior

### Featured Artwork Selection

- Artist marks artwork as "Featured" in dashboard
- If multiple featured works exist:
  - **MVP**: Show most recently marked as featured
  - **Post-MVP**: Could add rotation/slideshow
- Artwork data pulled from database:
  - Primary image
  - Title
  - Year created

### Navigation

- All links navigate to respective pages:
  - `/artist-name/gallery`
  - `/artist-name/about`
  - `/artist-name/process`
  - `/artist-name/exhibitions`
  - `/artist-name/press`
  - `/artist-name/techniques`
  - `/artist-name/contact`
- Active page indicator (e.g., underline or color change)
- Smooth transitions between pages

### Artist Statement

- Pulled from artist profile settings (first 2-3 sentences)
- If statement is too long, truncate at sentence boundary
- Could link to full statement on About page

### View Gallery Button

- Links to `/artist-name/gallery`
- Hover state: subtle animation (scale or color shift)
- Focus state for keyboard navigation (accessibility)

### Social Links

- Open in new tab (`target="_blank"`)
- Icon-based with tooltips/aria-labels
- Only show links that artist has configured

---

## Responsive Breakpoints

- **Mobile**: 320px - 767px
  - Single column
  - Hamburger menu
  - Full-width hero image
  - Compact footer

- **Tablet**: 768px - 1024px
  - Hamburger menu or horizontal nav (depends on # of links)
  - Hero image ~80-90% width
  - Footer can start spreading out

- **Desktop**: 1025px+
  - Full horizontal navigation
  - Hero section max-width ~1200px
  - Generous spacing

---

## Complete Layout with Recent Work Section (FINALIZED)

```
┌─────────────────────────────────────────────────────────────┐
│  Navigation Bar (FIXED/STICKY)                               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│             FEATURED ARTWORK (Hero Section)                   │
│             [Automatic Rotation - 5-10 seconds]              │
│             Artist Statement Preview (2-3 sentences)          │
│             [View Gallery]                                    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  "Recent Work" or "Selected Pieces"                          │
│                                                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Image   │  │  Image   │  │  Image   │  │  Image   │   │
│  │          │  │          │  │          │  │          │   │
│  │  Title   │  │  Title   │  │  Title   │  │  Title   │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                               │
│  [Optional: Show 2 more pieces for total of 6]               │
│                                                               │
│                    [View All Work]                            │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  Footer (Light grey background #f8f9fa)                      │
│  Contact | Social Links | Copyright                          │
│  "Powered by Clay Companion"                                 │
└─────────────────────────────────────────────────────────────┘
```

Shows 4-6 recent public artworks below the hero section.

---

## Finalized Decisions

1. **Featured artwork rotation**: ✅ Automatic rotation/slideshow (5-10 seconds) when multiple featured pieces exist

2. **Navigation behavior**: ✅ Fixed/sticky navigation - stays at top on scroll

3. **Additional content**: ✅ Add "Recent Work" section with 4-6 thumbnails below hero section

4. **Artist statement**: ✅ Show 2-3 sentence preview on landing page

5. **Footer styling**: ✅ Light grey background (#f8f9fa) for visual differentiation

6. **Branding**: ✅ "Powered by Clay Companion" in footer
   - **Post-MVP**: Paid subscription option to remove branding + unlock premium features

---

**Status**: Finalized ✓
