# Artist's About Page - Wireframe

**URL**: `claycompanion.com/artist-name/about`

**Purpose**: Tell the artist's story, share their philosophy, and provide background/credentials

---

## Key Design Decisions

1. **Layout Style**: Two-column (photo left, text right) on desktop, stacked on mobile
2. **Content Sections**: Artist Statement, Biography, Education (optional), Awards (optional)
3. **Visual Elements**: Portrait photo + optional studio/workspace photo
4. **Tone**: Artist statement in first-person, bio in third-person
5. **Length**: Concise, scannable - 2-3 paragraphs per section

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
│  ABOUT                                                                        │
│                                                                               │
│                                                                               │
│  ┌───────────────────────┐    ┌────────────────────────────────────────┐   │
│  │                       │    │  Sarah Martinez                        │   │
│  │                       │    │  Brooklyn, New York                    │   │
│  │                       │    │                                        │   │
│  │     PORTRAIT          │    │  ────────────────────────────────────  │   │
│  │      PHOTO            │    │                                        │   │
│  │                       │    │  ARTIST STATEMENT                      │   │
│  │    (Professional      │    │                                        │   │
│  │     headshot or       │    │  My work explores the relationship    │   │
│  │   artist at work)     │    │  between form and function in         │   │
│  │                       │    │  ceramic art. Each piece is hand-     │   │
│  │                       │    │  thrown and glazed with materials     │   │
│  │                       │    │  sourced from local clay bodies.      │   │
│  │                       │    │                                        │   │
│  └───────────────────────┘    │  I am drawn to the imperfections      │   │
│                                │  that emerge during the firing        │   │
│  ┌───────────────────────┐    │  process—the unexpected color         │   │
│  │                       │    │  variations, the subtle cracks, the   │   │
│  │                       │    │  organic warping that transforms my   │   │
│  │   STUDIO PHOTO        │    │  original design. These "flaws" add   │   │
│  │   (Optional)          │    │  character and tell the story of the  │   │
│  │                       │    │  piece's creation.                    │   │
│  │  (Artist in studio    │    │                                        │   │
│  │   or workspace shot)  │    │  Through my vessels, bowls, and       │   │
│  │                       │    │  sculptures, I aim to create objects  │   │
│  │                       │    │  that bring warmth and beauty to      │   │
│  └───────────────────────┘    │  everyday moments.                    │   │
│                                │                                        │   │
│                                │  ────────────────────────────────────  │   │
│                                │                                        │   │
│                                │  BIOGRAPHY                             │   │
│                                │                                        │   │
│                                │  Sarah Martinez is a ceramic artist   │   │
│                                │  based in Brooklyn, New York. She     │   │
│                                │  received her MFA in Ceramics from    │   │
│                                │  Rhode Island School of Design and    │   │
│                                │  her BFA from Alfred University.      │   │
│                                │                                        │   │
│                                │  Her work has been exhibited at       │   │
│                                │  galleries across the United States   │   │
│                                │  and is held in private collections   │   │
│                                │  internationally. She currently       │   │
│                                │  teaches ceramics at Pratt Institute  │   │
│                                │  and maintains a studio practice in   │   │
│                                │  Red Hook, Brooklyn.                  │   │
│                                │                                        │   │
│                                │  Martinez's practice is influenced by │   │
│                                │  both traditional Japanese pottery    │   │
│                                │  and contemporary minimalist design.  │   │
│                                │  She is particularly interested in    │   │
│                                │  how functional objects can serve as  │   │
│                                │  contemplative spaces in daily life.  │   │
│                                │                                        │   │
│                                │  ────────────────────────────────────  │   │
│                                │                                        │   │
│                                │  EDUCATION                             │   │
│                                │                                        │   │
│                                │  • MFA, Ceramics                       │   │
│                                │    Rhode Island School of Design, 2015│   │
│                                │                                        │   │
│                                │  • BFA, Ceramic Art                    │   │
│                                │    Alfred University, 2012            │   │
│                                │                                        │   │
│                                │  • Apprenticeship                      │   │
│                                │    Studio Kura, Fukuoka, Japan, 2013  │   │
│                                │                                        │   │
│                                │  ────────────────────────────────────  │   │
│                                │                                        │   │
│                                │  AWARDS & RECOGNITION                  │   │
│                                │                                        │   │
│                                │  • Emerging Artist Grant               │   │
│                                │    New York Foundation for the Arts,  │   │
│                                │    2023                               │   │
│                                │                                        │   │
│                                │  • Best in Show                        │   │
│                                │    National Ceramic Exhibition, 2021  │   │
│                                │                                        │   │
│                                │  • Artist Residency                    │   │
│                                │    Watershed Center for the Ceramic   │   │
│                                │    Arts, 2019                         │   │
│                                │                                        │   │
│                                └────────────────────────────────────────┘   │
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
│                                                          │
│  ABOUT                                                   │
│                                                          │
│  ┌────────────────┐   ┌──────────────────────────┐     │
│  │                │   │  Sarah Martinez          │     │
│  │   PORTRAIT     │   │  Brooklyn, New York      │     │
│  │     PHOTO      │   │                          │     │
│  │                │   │  ───────────────────────  │     │
│  └────────────────┘   └──────────────────────────┘     │
│                                                          │
│  ┌────────────────────────────────────────────────┐     │
│  │  ARTIST STATEMENT                              │     │
│  │                                                │     │
│  │  My work explores the relationship...          │     │
│  │  (Full statement text)                         │     │
│  └────────────────────────────────────────────────┘     │
│                                                          │
│  ┌─────────────┐                                        │
│  │  STUDIO     │                                        │
│  │   PHOTO     │                                        │
│  └─────────────┘                                        │
│                                                          │
│  ┌────────────────────────────────────────────────┐     │
│  │  BIOGRAPHY                                     │     │
│  │  (Full bio text)                               │     │
│  └────────────────────────────────────────────────┘     │
│                                                          │
│  ┌────────────────────────────────────────────────┐     │
│  │  EDUCATION                                     │     │
│  │  • List items...                               │     │
│  └────────────────────────────────────────────────┘     │
│                                                          │
│  ┌────────────────────────────────────────────────┐     │
│  │  AWARDS & RECOGNITION                          │     │
│  │  • List items...                               │     │
│  └────────────────────────────────────────────────┘     │
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
│  ABOUT                         │
│                                │
│  ┌───────────────────────┐    │
│  │                       │    │
│  │     PORTRAIT PHOTO    │    │
│  │                       │    │
│  └───────────────────────┘    │
│                                │
│  Sarah Martinez                │
│  Brooklyn, New York            │
│                                │
│  ─────────────────────────     │
│                                │
│  ARTIST STATEMENT              │
│                                │
│  My work explores the          │
│  relationship between form     │
│  and function in ceramic       │
│  art. Each piece is hand-      │
│  thrown and glazed with        │
│  materials sourced from        │
│  local clay bodies.            │
│                                │
│  (Full statement continues)    │
│                                │
│  ─────────────────────────     │
│                                │
│  ┌───────────────────────┐    │
│  │   STUDIO PHOTO        │    │
│  └───────────────────────┘    │
│                                │
│  ─────────────────────────     │
│                                │
│  BIOGRAPHY                     │
│                                │
│  Sarah Martinez is a           │
│  ceramic artist based in       │
│  Brooklyn, New York...         │
│                                │
│  (Full bio continues)          │
│                                │
│  ─────────────────────────     │
│                                │
│  EDUCATION                     │
│                                │
│  • MFA, Ceramics               │
│    Rhode Island School of      │
│    Design, 2015                │
│                                │
│  • BFA, Ceramic Art            │
│    Alfred University, 2012     │
│                                │
│  ─────────────────────────     │
│                                │
│  AWARDS & RECOGNITION          │
│                                │
│  • Emerging Artist Grant       │
│    New York Foundation for     │
│    the Arts, 2023              │
│                                │
│  • Best in Show                │
│    National Ceramic            │
│    Exhibition, 2021            │
│                                │
└───────────────────────────────┘
```

---

## Layout Specifications

### Page Container

- **Max-width**: ~1200px, centered
- **Padding**: 4-6rem vertical, 2-3rem horizontal
- **Background**: White or off-white

### Two-Column Layout (Desktop)

- **Left Column (Photos)**: 30-35% width
  - Portrait photo first
  - Studio photo below (with spacing)
  - Photos sticky on scroll (optional)
- **Right Column (Text)**: 65-70% width
  - All text content flows here
  - Clear section breaks with horizontal rules
- **Gap between columns**: 3-4rem

### Portrait Photo

- **Aspect Ratio**: 3:4 or 2:3 (vertical portrait)
- **Style**: Professional but approachable
- **Size**: Large enough to see facial features clearly
- **Crop**: Center on face, minimal background
- **Border/Shadow**: Optional subtle shadow for depth

### Studio Photo (Optional)

- **Aspect Ratio**: 4:3 or 16:9 (horizontal)
- **Content**: Artist in workspace, tools, workspace overview
- **Size**: Slightly smaller than portrait
- **Placement**: Below portrait with 2-3rem spacing

### Typography

- **Page Title**: Large (2.5-3rem), artist name or "About"
- **Section Headers**: Medium (1.5-2rem), uppercase or bold
  - "Artist Statement", "Biography", "Education", "Awards"
- **Body Text**:
  - Font size: 1.125rem (18px) for readability
  - Line height: 1.7-1.8
  - Max-width: ~650px for optimal reading
- **Location/Subtitle**: Smaller (1rem), lighter color

### Artist Statement Section

- **Voice**: First-person ("I", "My")
- **Length**: 2-4 paragraphs (200-400 words)
- **Content**: Philosophy, inspiration, approach, goals
- **Tone**: Personal, reflective, authentic

### Biography Section

- **Voice**: Third-person (use artist name)
- **Length**: 2-3 paragraphs (150-300 words)
- **Content**:
  - Educational background
  - Career highlights
  - Current activities (teaching, studio location)
  - Influences or artistic lineage
- **Tone**: Professional, factual, accomplishment-focused

### Education Section (Optional)

- **Format**: Bulleted list
- **Each item includes**:
  - Degree type (MFA, BFA, etc.)
  - Field of study
  - Institution name
  - Year
- **Order**: Most recent first
- **Additional**: Apprenticeships, workshops, residencies

### Awards Section (Optional)

- **Format**: Bulleted list
- **Each item includes**:
  - Award name
  - Granting organization
  - Year
- **Order**: Most recent first
- **Alternative name**: "Awards & Recognition" or "Honors"

### Section Dividers

- **Style**: Horizontal rules or extra spacing
- **Color**: Light grey (#e0e0e0) or similar
- **Thickness**: 1-2px
- **Length**: Full width or 60% centered

---

## Responsive Breakpoints

### Mobile (320px - 767px)

- Single column stacked layout
- Portrait photo at top (full width or centered)
- Text sections below
- Studio photo between statement and bio
- Reduced font sizes slightly
- Reduced padding/spacing

### Tablet (768px - 1024px)

- Hybrid layout: Photos at top, text below
- OR: Narrower two-column (photo 40%, text 60%)
- Maintain readability with proper line lengths

### Desktop (1025px+)

- Full two-column layout (30/70 split)
- Photos on left, text on right
- Generous spacing
- Optional sticky photos on scroll

---

## Content Management (Database)

### Data Structure

Content pulled from `artist_profile` table:

- `full_name` - Artist name
- `bio` - Biography text (third-person)
- `artist_statement` - Statement text (first-person)
- `profile_photo_url` - Portrait image
- `location` - City, State/Country (optional)

Additional fields needed (update schema):

- `studio_photo_url` - Workspace/studio image (optional)
- `education` - JSON array of education entries
- `awards` - JSON array of award entries

### Optional Education/Awards Format (JSON)

```json
"education": [
  {
    "degree": "MFA",
    "field": "Ceramics",
    "institution": "Rhode Island School of Design",
    "year": 2015
  }
]

"awards": [
  {
    "title": "Emerging Artist Grant",
    "organization": "New York Foundation for the Arts",
    "year": 2023
  }
]
```

---

## Interaction & Behavior

### Image Loading

- Progressive loading with blur-up technique
- Lazy load studio photo (below fold)
- High-quality images (but optimized for web)

### Text Readability

- Comfortable line length (60-80 characters)
- Adequate line height for scanning
- Clear visual hierarchy with headers

### Sticky Photos (Optional Enhancement)

- On desktop, photos stick to viewport as user scrolls
- Creates dynamic effect while reading text
- Only if page is long enough to benefit

### Edit Mode (Dashboard)

- Separate form for editing About content
- WYSIWYG or markdown editor for statement/bio
- Image upload for portrait and studio photos
- Add/edit/remove education and awards entries

---

## Accessibility

### Semantic HTML

- `<main>` for page content
- `<section>` for each content section
- Proper heading hierarchy (h1 → h2 → h3)
- `<figure>` and `<figcaption>` for images

### Images

- Alt text for portrait: "Portrait of [Artist Name]"
- Alt text for studio: "[Artist Name]'s studio workspace"
- Decorative borders/shadows via CSS, not images

### Contrast & Readability

- Text color meets WCAG AA standards
- Sufficient contrast for section headers
- Readable font sizes (minimum 16px body)

---

## Dashboard: Edit About Page

### Form Structure (Dashboard Side)

```
Edit About Page

┌─────────────────────────────────────┐
│ Profile Photo                        │
│ [Current photo preview]              │
│ [Upload New Photo]                   │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Studio Photo (Optional)              │
│ [Current photo preview or empty]     │
│ [Upload Photo]                       │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Location (Optional)                  │
│ [Brooklyn, New York        ]         │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Artist Statement                     │
│ [Text area - large]                  │
│ Character count: 387/500 (optional)  │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Biography                            │
│ [Text area - large]                  │
│ Character count: 245/500 (optional)  │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Education (Optional)                 │
│                                      │
│ ┌─────────────────────────────────┐ │
│ │ Degree: [MFA              ]     │ │
│ │ Field:  [Ceramics         ]     │ │
│ │ School: [RISD             ]     │ │
│ │ Year:   [2015             ]     │ │
│ │ [Remove]                        │ │
│ └─────────────────────────────────┘ │
│                                      │
│ [+ Add Education]                    │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Awards & Recognition (Optional)      │
│                                      │
│ ┌─────────────────────────────────┐ │
│ │ Award:  [Grant Name       ]     │ │
│ │ Org:    [Foundation       ]     │ │
│ │ Year:   [2023             ]     │ │
│ │ [Remove]                        │ │
│ └─────────────────────────────────┘ │
│                                      │
│ [+ Add Award]                        │
└─────────────────────────────────────┘

[Cancel]  [Save Changes]
```

---

## Finalized Decisions

1. ✅ **Layout**: Two-column (photos left, text right) on desktop, stacked on mobile
2. ✅ **Content Sections**: Artist Statement, Biography, Education (optional), Awards (optional)
3. ✅ **Photos**: Portrait (required) + Studio photo (optional)
4. ✅ **Tone**: First-person for statement, third-person for bio
5. ✅ **Length**: Concise and scannable (2-3 paragraphs per section)
6. ✅ **Typography**: Large, readable body text (18px+), clear hierarchy
7. ✅ **Education/Awards**: Optional sections, bulleted list format, stored as JSON

---

## Database Schema Updates Needed

Add to `artist_profile` table:

- `studio_photo_url` (text, nullable) - Studio/workspace image
- `location` (text, nullable) - City, State/Country
- `education` (jsonb, nullable) - Array of education entries
- `awards` (jsonb, nullable) - Array of awards/recognition entries

Note: `bio` and `artist_statement` fields already exist in schema.

---

**Status**: Finalized ✓
**Date**: 2025-10-14
