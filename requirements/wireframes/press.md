# Press Page - Wireframe

**URL**: `claycompanion.com/artist-name/press`

**Purpose**: Showcase press coverage, media mentions, articles, reviews, and interviews to establish credibility and visibility

---

## Key Design Decisions

1. **Layout Structure**: Featured press section (top) + Press history list (below)
2. **Featured Section**: 2-3 articles with publication logo/image, title, excerpt, and external link
3. **History Section**: Chronological list organized by year
4. **Images**: Optional publication logos or article screenshots in featured section
5. **External Links**: All press mentions link to original articles (open in new tab)
6. **Organization**: Year (newest first) → Press mentions (newest first within year)

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
│  PRESS                                                                        │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  FEATURED PRESS                                                               │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  ┌─────────────────────────┐                                          │ │
│  │  │                         │                                          │ │
│  │  │   [Publication Logo]    │                                          │ │
│  │  │   Ceramic Arts Monthly  │                                          │
│  │  │                         │                                          │ │
│  │  └─────────────────────────┘                                          │ │
│  │                                                                         │ │
│  │  The New Minimalism: Contemporary Ceramic Artists Redefining Form     │ │
│  │  Ceramic Arts Monthly  |  March 2024                                  │ │
│  │                                                                         │ │
│  │  In this in-depth feature, we explore how contemporary ceramic        │ │
│  │  artists are pushing the boundaries of traditional vessel forms       │ │
│  │  through minimal aesthetics and innovative firing techniques. Artist  │ │
│  │  Sarah Chen's work exemplifies this new movement, combining           │ │
│  │  centuries-old methods with a distinctly modern sensibility.          │ │
│  │                                                                         │ │
│  │  Chen's recent series explores the relationship between positive and  │ │
│  │  negative space, creating vessels that seem to exist in a state of    │ │
│  │  quiet tension. "I'm interested in what's not there as much as what   │ │
│  │  is," she explains. Her pieces feature clean lines, subtle surface    │ │
│  │  textures, and a restrained color palette that allows the clay's      │ │
│  │  natural qualities to shine through.                                  │ │
│  │                                                                         │ │
│  │  The article examines Chen's unique approach to wheel-throwing and    │ │
│  │  hand-building, her experimentation with high-fire reduction glazes,  │ │
│  │  and how her background in architecture influences her ceramic        │ │
│  │  practice. Featured works include pieces from her critically          │ │
│  │  acclaimed "Vessels of Memory" series, which was recently exhibited   │ │
│  │  at the Museum of Contemporary Ceramics in New York.                  │ │
│  │                                                                         │ │
│  │  ┌─────────────────────────────────────────────────────────────────┐ │ │
│  │  │  Read Full Article →                                             │ │ │
│  │  │  (External link - opens in new tab)                              │ │ │
│  │  └─────────────────────────────────────────────────────────────────┘ │ │
│  │                                                                         │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  ┌─────────────────────────┐                                          │ │
│  │  │                         │                                          │ │
│  │  │   [Publication Logo]    │                                          │ │
│  │  │   The New York Times    │                                          │ │
│  │  │                         │                                          │ │
│  │  └─────────────────────────┘                                          │ │
│  │                                                                         │ │
│  │  A Return to Ritual: Ceramic Objects for Daily Life                   │ │
│  │  The New York Times - Home & Design  |  January 2024                  │ │
│  │                                                                         │ │
│  │  As modern life becomes increasingly digital and disconnected,        │ │
│  │  a growing number of people are finding solace in the ritual of       │ │
│  │  using handmade ceramic objects. Sarah Chen is one of several         │ │
│  │  ceramic artists leading this quiet renaissance, creating functional  │ │
│  │  vessels that elevate everyday moments into meaningful experiences.   │ │
│  │                                                                         │ │
│  │  "There's something profound about starting your day by drinking      │ │
│  │  coffee from a cup that someone made with their hands," Chen says     │ │
│  │  from her Brooklyn studio. Her work combines traditional Japanese     │ │
│  │  tea ceremony aesthetics with contemporary American craft...          │ │
│  │                                                                         │ │
│  │  The article highlights how Chen's pieces encourage mindfulness and   │ │
│  │  presence, featuring interviews with collectors who describe how      │ │
│  │  incorporating her work into their daily routines has changed their   │ │
│  │  relationship with simple activities like drinking tea or serving     │ │
│  │  food to guests.                                                      │ │
│  │                                                                         │ │
│  │  ┌─────────────────────────────────────────────────────────────────┐ │ │
│  │  │  Read Full Article →                                             │ │ │
│  │  └─────────────────────────────────────────────────────────────────┘ │ │
│  │                                                                         │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  ┌─────────────────────────┐                                          │ │
│  │  │  [Article Screenshot]   │                                          │ │
│  │  │  or Publication Logo    │                                          │ │
│  │  │                         │                                          │ │
│  │  └─────────────────────────┘                                          │ │
│  │                                                                         │ │
│  │  Studio Visit: Inside the Ceramic Practice of Sarah Chen              │ │
│  │  Hyperallergic  |  November 2023                                      │ │
│  │                                                                         │ │
│  │  In this studio visit, we explore the working methods and creative    │ │
│  │  process of Brooklyn-based ceramic artist Sarah Chen. Her studio,     │ │
│  │  located in a converted industrial space in Sunset Park, reflects     │ │
│  │  both the precision and spontaneity that characterize her work.       │ │
│  │                                                                         │ │
│  │  Chen walks us through her process from initial sketches to finished  │ │
│  │  pieces, demonstrating techniques she's developed over years of       │ │
│  │  experimentation. The article includes insights into her material     │ │
│  │  choices, firing schedules, and how she tests new glaze formulas...   │ │
│  │                                                                         │ │
│  │  ┌─────────────────────────────────────────────────────────────────┐ │ │
│  │  │  Read Full Article →                                             │ │ │
│  │  └─────────────────────────────────────────────────────────────────┘ │ │
│  │                                                                         │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  (2-3 featured press articles max)                                           │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│  PRESS HISTORY                                                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2024                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  • "The New Minimalism: Contemporary Ceramic Artists Redefining Form"       │
│    Ceramic Arts Monthly  |  March 2024                                       │
│    Read Article →                                                            │
│                                                                               │
│  • "A Return to Ritual: Ceramic Objects for Daily Life"                     │
│    The New York Times - Home & Design  |  January 2024                       │
│    Read Article →                                                            │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2023                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  • "Studio Visit: Inside the Ceramic Practice of Sarah Chen"                │
│    Hyperallergic  |  November 2023                                           │
│    Read Article →                                                            │
│                                                                               │
│  • "Ten Emerging Ceramic Artists to Watch"                                  │
│    Ceramics Now Magazine  |  September 2023                                  │
│    Read Article →                                                            │
│                                                                               │
│  • "Vessels of Memory: A Review"                                            │
│    Artforum  |  June 2023                                                    │
│    Read Article →                                                            │
│                                                                               │
│  • "Material Culture: Contemporary Approaches to Clay"                       │
│    Art in America  |  April 2023                                             │
│    Read Article →                                                            │
│                                                                               │
│  • "Spotlight on Brooklyn Clay Artists"                                     │
│    Brooklyn Magazine  |  February 2023                                       │
│    Read Article →                                                            │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2022                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  • "The Resurgence of Functional Ceramics"                                  │
│    Craft Magazine  |  October 2022                                           │
│    Read Article →                                                            │
│                                                                               │
│  • "Interview: Sarah Chen on Tradition and Innovation"                      │
│    Pottery Making Illustrated  |  July 2022                                  │
│    Read Article →                                                            │
│                                                                               │
│  • "American Craft Biennial: Highlights and Trends"                         │
│    American Craft Council Blog  |  November 2022                             │
│    Read Article →                                                            │
│                                                                               │
│  ──────────────────────────────────────────────────────────────────────────│
│  2021                                                                         │
│  ──────────────────────────────────────────────────────────────────────────│
│                                                                               │
│  • "Emerging Artists: Five Ceramicists Pushing Boundaries"                  │
│    Ceramics Monthly  |  May 2021                                             │
│    Read Article →                                                            │
│                                                                               │
│  • "Brooklyn's New Wave of Studio Potters"                                  │
│    The Brooklyn Rail  |  March 2021                                          │
│    Read Article →                                                            │
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
│  PRESS                                                   │
│                                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  FEATURED PRESS                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                          │
│  ┌────────────────────────────────────────────────┐    │
│  │  ┌──────────────────┐                           │    │
│  │  │ Publication Logo │                           │    │
│  │  │ Ceramic Arts Mo. │                           │    │
│  │  └──────────────────┘                           │    │
│  │                                                  │    │
│  │  The New Minimalism: Contemporary Ceramic       │    │
│  │  Artists Redefining Form                        │    │
│  │                                                  │    │
│  │  Ceramic Arts Monthly  |  March 2024            │    │
│  │                                                  │    │
│  │  In this in-depth feature, we explore how       │    │
│  │  contemporary ceramic artists are pushing...    │    │
│  │  (excerpt continues)                            │    │
│  │                                                  │    │
│  │  [Read Full Article →]                          │    │
│  └────────────────────────────────────────────────┘    │
│                                                          │
│  (More featured press...)                               │
│                                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  PRESS HISTORY                                           │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                                          │
│  ────────────────────────────────────────────────────  │
│  2024                                                    │
│  ────────────────────────────────────────────────────  │
│                                                          │
│  • "The New Minimalism: Contemporary Ceramic Artists    │
│    Redefining Form"                                     │
│    Ceramic Arts Monthly  |  March 2024                  │
│    Read Article →                                       │
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
│  PRESS                         │
│                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  FEATURED                      │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                │
│  ┌───────────────────────┐    │
│  │  ┌─────────────────┐  │    │
│  │  │ Publication Logo│  │    │
│  │  │ Ceramic Arts Mo.│  │    │
│  │  └─────────────────┘  │    │
│  │                       │    │
│  │  The New Minimalism:  │    │
│  │  Contemporary Ceramic │    │
│  │  Artists Redefining   │    │
│  │  Form                 │    │
│  │                       │    │
│  │  Ceramic Arts Monthly │    │
│  │  March 2024           │    │
│  │                       │    │
│  │  In this in-depth     │    │
│  │  feature, we explore  │    │
│  │  how contemporary     │    │
│  │  ceramic artists...   │    │
│  │  (excerpt truncated   │    │
│  │  for mobile)          │    │
│  │                       │    │
│  │  [Read Article →]     │    │
│  └───────────────────────┘    │
│                                │
│  (More featured press...)      │
│                                │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│  HISTORY                       │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                │
│  ─────────────────────────    │
│  2024                          │
│  ─────────────────────────    │
│                                │
│  • "The New Minimalism:        │
│    Contemporary Ceramic        │
│    Artists Redefining Form"    │
│    Ceramic Arts Monthly        │
│    March 2024                  │
│    Read Article →              │
│                                │
│  • "A Return to Ritual:        │
│    Ceramic Objects for         │
│    Daily Life"                 │
│    The New York Times          │
│    January 2024                │
│    Read Article →              │
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

### Featured Press Section

#### Section Container

- **Background**: Light background (#f8f9fa) or subtle border
- **Padding**: 2-3rem
- **Margin**: 2rem between featured articles
- **Max featured**: 2-3 articles

#### Each Featured Article Card

- **Publication Logo/Image**:
  - Position: Top of card, centered or left-aligned
  - Size: 150-200px wide (auto height to maintain aspect ratio)
  - Background: White or transparent
  - Border: Optional subtle border
  - Alt text: "[Publication name] logo"
- **Article Title**:
  - Font size: 1.75-2rem (28-32px)
  - Font weight: Bold
  - Color: Primary text color
  - Margin: 1rem top
- **Publication & Date**:
  - Font size: 1.125rem (18px)
  - Font weight: Medium
  - Color: Grey (#666)
  - Format: "Publication Name | Month YYYY"
  - Margin: 0.5rem bottom
- **Excerpt**:
  - Font size: 1rem (16px)
  - Line height: 1.7
  - Color: Body text color
  - Length: 200-300 words (3-4 paragraphs)
  - Margin: 1.5rem top and bottom
- **Link Button**:
  - Text: "Read Full Article →"
  - Style: Primary button or text link with arrow
  - Font size: 1rem (16px)
  - Opens in new tab (target="\_blank" rel="noopener noreferrer")
  - Padding: 0.75rem 1.5rem
  - Border radius: 4-6px
  - Hover state: Darker background or underline

### Press History Section

#### Section Header

- **Text**: "PRESS HISTORY"
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

#### Press Entries

- **Format**: Bulleted list
- **Bullet**: Standard bullet or custom icon
- **Spacing**: 1rem between entries
- **Title**:
  - Font size: 1rem (16px)
  - Font weight: Bold or Medium
  - Color: Primary text
  - Line 1 of entry
- **Publication & Date**:
  - Font size: 1rem (16px)
  - Font weight: Regular
  - Color: Grey (#666)
  - Format: "Publication Name | Month YYYY"
  - Line 2 of entry
- **Link**:
  - Text: "Read Article →"
  - Font size: 0.875-1rem (14-16px)
  - Color: Link color (blue or brand color)
  - Opens in new tab
  - Hover: Underline
  - Line 3 of entry

---

## Content Management (Database)

### Data Structure

**Updated `press_mentions` table** (add these fields):

```sql
-- Existing fields:
id (uuid, primary key)
artist_id (uuid, foreign key → artist_profile)
title (text)
publication (text)
url (text, nullable)
published_date (date)
excerpt (text, nullable) -- Short excerpt 50-100 words
display_order (integer)
created_at (timestamp)
updated_at (timestamp)

-- New fields:
is_featured (boolean, default false)
excerpt_long (text, nullable) -- Longer excerpt 200-300 words for featured articles
```

**Optional new table: `press_images`** (for publication logos or article screenshots):

```sql
CREATE TABLE press_images (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  press_mention_id UUID NOT NULL REFERENCES press_mentions(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  image_type TEXT CHECK (image_type IN ('logo', 'screenshot', 'other')),
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Query Logic

**Featured Press**:

```sql
SELECT pm.*,
  (SELECT json_agg(
    json_build_object(
      'image_url', pi.image_url,
      'image_type', pi.image_type
    ) ORDER BY pi.display_order
  ) FROM press_images pi
  WHERE pi.press_mention_id = pm.id
  ) as images
FROM press_mentions pm
WHERE pm.artist_id = $1
  AND pm.is_featured = true
ORDER BY pm.published_date DESC
LIMIT 3;
```

**Press History**:

```sql
SELECT * FROM press_mentions
WHERE artist_id = $1
ORDER BY
  EXTRACT(YEAR FROM published_date) DESC,
  published_date DESC;
```

**Frontend Grouping Logic**:

1. Group results by year (extracted from `published_date`)
2. Display in chronological order (newest first)
3. Each entry links to external article via `url` field

---

## Typography

- **Page Title**: 2.5-3rem, "Press"
- **Section Headers**: 2rem, "Featured Press", "Press History"
- **Featured Article Title**: 1.75-2rem, bold
- **Featured Publication/Date**: 1.125rem, medium weight, grey
- **Featured Excerpt**: 1rem, line height 1.7
- **Featured Link Button**: 1rem, medium weight
- **Year Header**: 1.5-1.75rem, bold
- **Press Entry Title**: 1rem, bold or medium
- **Press Entry Publication/Date**: 1rem, regular, grey
- **Press Entry Link**: 0.875-1rem, link color

---

## Responsive Breakpoints

### Mobile (320px - 767px)

- Featured: Full-width cards, stacked
- Excerpt: Truncated to 100-150 words on mobile
- History: Compressed spacing, same structure
- Reduce font sizes slightly for readability

### Tablet (768px - 1024px)

- Featured: Slightly reduced padding
- Excerpt: Full 200-300 words
- History: Same layout as desktop

### Desktop (1025px+)

- Featured: Full layout with generous padding
- Excerpt: Full 200-300 words
- History: Single column, clean list

---

## Interaction & Behavior

### External Links

- **Target**: All links open in new tab (target="\_blank")
- **Security**: Add rel="noopener noreferrer" for security
- **Icon**: Arrow icon (→) indicates external link
- **Hover**: Button/link hover states
- **Keyboard**: Accessible via Tab key, Enter to activate

### Featured Cards

- **Spacing**: Generous whitespace between cards
- **Hover**: Optional subtle hover effect on entire card
- **Click**: Only the "Read Full Article" button is clickable

### Press History

- **Static list**: No interactivity in MVP
- **Optional enhancement**: Collapsible year sections
- **Optional enhancement**: Filter by publication type

### Loading States

- Skeleton screens for featured articles
- Fade-in animation when content loads
- Loading indicator for images

---

## Accessibility

### Semantic HTML

- `<main>` for page content
- `<section>` for featured and history sections
- `<article>` for each featured press mention
- `<ul>` and `<li>` for press history list
- Proper heading hierarchy (h1 → h2 → h3)

### Links

- **ARIA**: Use aria-label for external links
- **Screen readers**: Announce "Opens in new tab"
- **Keyboard**: All links accessible via Tab key
- **Focus**: Clear focus indicators on links/buttons

### Images

- **Alt text**: Descriptive
  - "[Publication name] logo"
  - "Screenshot of [Article title] article"
- **Optional**: If image fails to load, show publication name as text

### Contrast & Readability

- Text meets WCAG AA contrast standards
- Sufficient spacing for touch targets (44x44px min)
- Clear visual hierarchy
- Links distinguishable from body text

---

## Dashboard: Manage Press Page

### Form Structure (Dashboard Side)

```
Manage Press

┌─────────────────────────────────────────────────────────┐
│ All Press Mentions                                       │
│                                                          │
│ [+ Add Press Mention]                                    │
│                                                          │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Press Mention 1                                      │ │
│ │                                                      │ │
│ │ Title: [The New Minimalism: Contemporary...  ]      │ │
│ │ Publication: [Ceramic Arts Monthly           ]      │ │
│ │ Published Date: [2024-03-15]                        │ │
│ │ URL: [https://ceramicsmonthly.org/article... ]      │ │
│ │                                                      │ │
│ │ Short Excerpt (50-100 words, for history list):     │ │
│ │ [Textarea - brief excerpt]                          │ │
│ │                                                      │ │
│ │ ☑ Featured Press (show in featured section)         │ │
│ │                                                      │ │
│ │ ┌─────────────────────────────────────────────────┐│ │
│ │ │ Featured Content (only if featured is checked)  ││ │
│ │ │                                                  ││ │
│ │ │ Long Excerpt (200-300 words):                   ││ │
│ │ │ [Large textarea for extended excerpt]           ││ │
│ │ │                                                  ││ │
│ │ │ Publication Logo/Image:                         ││ │
│ │ │ [Upload Image]                                  ││ │
│ │ │                                                  ││ │
│ │ │ ┌──────┐                                        ││ │
│ │ │ │      │                                        ││ │
│ │ │ │ Logo │                                        ││ │
│ │ │ │      │                                        ││ │
│ │ │ └──────┘                                        ││ │
│ │ │ Image Type: [Logo ▼]                            ││ │
│ │ │ [Delete Image]                                  ││ │
│ │ │                                                  ││ │
│ │ └─────────────────────────────────────────────────┘│ │
│ │                                                      │ │
│ │ [Save] [Delete Press Mention]                       │ │
│ └─────────────────────────────────────────────────────┘ │
│                                                          │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ Press Mention 2                                      │ │
│ │ (Same structure...)                                  │ │
│ └─────────────────────────────────────────────────────┘ │
│                                                          │
│ (More press mentions...)                                 │
│                                                          │
└─────────────────────────────────────────────────────────┘

[Save All Changes]
```

### Dashboard Features

- **Add Press Mention**: Button to create new entry
- **Edit/Delete**: Modify or remove press mentions
- **Featured Toggle**: Checkbox to mark for featured section
- **Two Excerpt Fields**:
  - Short excerpt (50-100 words) for history list
  - Long excerpt (200-300 words) for featured section (only visible if featured)
- **Image Upload**: Optional publication logo or article screenshot
  - Only visible when "Featured" is checked
  - Image type dropdown: Logo | Screenshot | Other
  - Single image per press mention (can add more fields if needed)
- **Drag-Drop Reordering**: Reorder press mentions
- **Preview**: See how press page looks on public site
- **Validation**:
  - Title, publication, published_date are required
  - URL is optional (some mentions may not have online articles)
  - Featured press require long_excerpt
  - Short excerpt optional (for list context)

---

## Finalized Decisions

1. ✅ **Featured Section**: 2-3 articles with publication logo, title, excerpt, and external link
2. ✅ **Excerpts**: Short (50-100 words) for history list, long (200-300 words) for featured
3. ✅ **External Links**: All press links open original articles in new tab
4. ✅ **History Section**: Chronological list by year
5. ✅ **Images**: Optional publication logos or article screenshots in featured section
6. ✅ **Organization**: Professional CV-style format for history
7. ✅ **Responsive**: Mobile-friendly layout with truncated excerpts on small screens

---

## Database Schema Changes

**Add to `press_mentions` table**:

- `is_featured` (boolean, default false)
- `excerpt_long` (text, nullable) -- For featured articles

**Optional new table `press_images`**:

- `id` (uuid, primary key)
- `press_mention_id` (uuid, foreign key)
- `image_url` (text)
- `image_type` (text: 'logo' | 'screenshot' | 'other')
- `display_order` (integer)
- `created_at` (timestamp)

---

## Implementation Notes

### Why This Approach?

1. **Featured Section**: Highlights most significant press coverage with full context
2. **Two Excerpt Lengths**: Featured articles get full treatment; history list stays scannable
3. **External Links**: Drives traffic to original articles; establishes credibility
4. **Publication Logos**: Visual interest and brand recognition
5. **Chronological History**: Industry standard CV format; professional and scannable
6. **Flexible**: Works for artists with a few mentions or extensive press coverage
7. **SEO Benefits**: Keywords, backlinks, and credibility signals

### Content Guidelines for Artists

**Featured Press** (2-3 max):

- Most significant or recent articles
- Major publications or in-depth features
- Articles that tell a story about your work
- Long excerpt (200-300 words) that gives context and draws readers in
- Include publication logo if available

**Press History**:

- Comprehensive list of all press mentions
- Format: Title, Publication, Date, Link
- Keep titles concise but descriptive
- Optional short excerpt for context

**Excerpts**:

- Use first 2-3 paragraphs from article, or write summary
- Focus on content about the artist's work
- End with "..." if truncated
- Get permission if reprinting significant portions

**Images**:

- Publication logos: High-res, transparent background preferred
- Article screenshots: Crop to show headline and lead image
- Optimize for web (compress images)

---

**Status**: Finalized ✓
**Date**: 2025-10-23
