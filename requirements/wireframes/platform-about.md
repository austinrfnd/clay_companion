# Platform About Page - Wireframe

**URL**: `claycompanion.com/about`
**Purpose**: Explain what Clay Companion is, who it's for, why it exists, and how to get started
**User Type**: Non-authenticated visitors, potential artists, curious art lovers

**Created**: 2025-10-24

---

## Design Decisions

### Overall Approach

- **Feel**: Welcoming, mission-driven, community-focused
- **Goal**: Communicate value proposition and inspire artists to join
- **Positioning**: "By artists, for artists" - built by people who understand ceramic art
- **Tone**: Authentic, warm, professional

### Key Sections

1. **Hero**: Mission statement and visual
2. **What is Clay Companion**: Platform explanation
3. **Who It's For**: Artists & Art Lovers (two columns)
4. **Features**: Platform capabilities
5. **How It Works**: Simple 3-4 step process
6. **Story/Origin**: Why it was built (optional for MVP)
7. **Call to Action**: Start portfolio or explore artists

---

## Layout Structure

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         FIXED NAVIGATION BAR                                 │
│  Clay Companion (logo)    Browse Artists | About | Login | Sign Up          │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                           HERO SECTION                                       │
│                                                                               │
│                                                                               │
│              By Artists, For Artists                                          │
│                                                                               │
│           A platform built to help ceramic artists                            │
│         showcase their work and connect with the world                        │
│                                                                               │
│                    [Start Your Portfolio →]                                   │
│                                                                               │
│  [Optional: Background image of ceramics or studio workspace]                │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                      WHAT IS CLAY COMPANION                                  │
│                                                                               │
│     Clay Companion is a portfolio platform designed specifically             │
│     for ceramic artists. We provide tools to catalog your work               │
│     internally and share it beautifully with the world.                      │
│                                                                               │
│     Whether you're creating functional stoneware, sculptural                 │
│     porcelain, or experimental pieces, Clay Companion gives you              │
│     a professional home online.                                              │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         WHO IT'S FOR                                         │
│                                                                               │
│  ┌──────────────────────────────────┐  ┌──────────────────────────────────┐│
│  │                                   │  │                                   ││
│  │      FOR CERAMIC ARTISTS          │  │       FOR ART LOVERS              ││
│  │                                   │  │                                   ││
│  │  Build your online portfolio      │  │  Discover talented ceramic        ││
│  │  • Professional gallery           │  │  artists                          ││
│  │  • Organize by series & groups    │  │  • Browse by style & technique    ││
│  │  • Share your process             │  │  • See behind-the-scenes          ││
│  │  • Manage exhibitions & press     │  │  • Connect directly with artists  ││
│  │  • Control what's public/private  │  │  • Find inspiration               ││
│  │  • Internal catalog for your work │  │  • Explore ceramic art            ││
│  │                                   │  │                                   ││
│  │  [Start Your Portfolio →]         │  │  [Explore Artists →]              ││
│  │                                   │  │                                   ││
│  └──────────────────────────────────┘  └──────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                            FEATURES                                          │
│                                                                               │
│                  Everything You Need to Showcase Your Work                   │
│                                                                               │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐  ┌──────────────┐│
│  │               │  │               │  │               │  │              ││
│  │  📸 Gallery    │  │  📂 Catalog    │  │  🎨 Process    │  │  📰 Press     ││
│  │               │  │               │  │               │  │              ││
│  │  Showcase     │  │  Internal     │  │  Share your   │  │  Highlight   ││
│  │  your best    │  │  tool to      │  │  studio and   │  │  media       ││
│  │  work with a  │  │  catalog      │  │  making       │  │  coverage and││
│  │  beautiful    │  │  everything,  │  │  process with │  │  exhibition  ││
│  │  public       │  │  public or    │  │  photos and   │  │  history     ││
│  │  gallery      │  │  private      │  │  captions     │  │              ││
│  │               │  │               │  │               │  │              ││
│  └───────────────┘  └───────────────┘  └───────────────┘  └──────────────┘│
│                                                                               │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐  ┌──────────────┐│
│  │               │  │               │  │               │  │              ││
│  │  🗂️ Series     │  │  👤 About      │  │  📧 Contact    │  │  🔒 Privacy   ││
│  │               │  │               │  │               │  │              ││
│  │  Organize     │  │  Tell your    │  │  Display your │  │  Control     ││
│  │  work into    │  │  story with   │  │  contact info │  │  what's      ││
│  │  collections  │  │  bio, artist  │  │  and social   │  │  public vs   ││
│  │  and groups   │  │  statement,   │  │  media links  │  │  private     ││
│  │               │  │  education    │  │               │  │              ││
│  └───────────────┘  └───────────────┘  └───────────────┘  └──────────────┘│
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                          HOW IT WORKS                                        │
│                                                                               │
│                Getting started is easy. Here's how:                          │
│                                                                               │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐         │
│  │                 │    │                 │    │                 │         │
│  │       1.        │    │       2.        │    │       3.        │         │
│  │   Sign Up       │ → │  Upload Work    │ → │  Go Live        │         │
│  │                 │    │                 │    │                 │         │
│  │  Create your    │    │  Add your       │    │  Publish your   │         │
│  │  free account   │    │  artworks,      │    │  portfolio and  │         │
│  │  in minutes     │    │  photos, and    │    │  start sharing  │         │
│  │                 │    │  information    │    │                 │         │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘         │
│                                                                               │
│                      [Start Your Portfolio →]                                │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         OUR STORY (Optional)                                 │
│                                                                               │
│     Clay Companion was created by ceramic artists who understood             │
│     the challenges of showcasing ceramic work online. We wanted              │
│     a platform that respected the craft, made catalog management             │
│     easy, and put the artwork first.                                         │
│                                                                               │
│     Built with input from the ceramic community, Clay Companion              │
│     is designed to serve artists at every stage of their practice—           │
│     from emerging makers to established professionals.                       │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                     CALL TO ACTION (Final)                                   │
│                                                                               │
│                  Ready to share your work with the world?                    │
│                                                                               │
│                      [Start Your Portfolio →]                                │
│                                                                               │
│                           or                                                 │
│                                                                               │
│                      [Explore Artists →]                                     │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                          FOOTER                                              │
│                                                                               │
│  Clay Companion                                                              │
│  By artists, for artists                                                     │
│                                                                               │
│  Home  |  Browse Artists  |  About  |  Contact  |  Terms  |  Privacy        │
│                                                                               │
│  © 2025 Clay Companion. All rights reserved.                                │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Tablet Layout (768px - 1024px)

```
┌────────────────────────────────────────────────────────┐
│  Clay Companion                             ☰ Menu     │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                    HERO SECTION                        │
│                                                          │
│        By Artists, For Artists                           │
│                                                          │
│    A platform built to help ceramic artists              │
│  showcase their work and connect with the world          │
│                                                          │
│           [Start Your Portfolio →]                       │
│                                                          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│              WHAT IS CLAY COMPANION                    │
│                                                          │
│  Clay Companion is a portfolio platform...              │
│  (Full text, centered, readable width)                  │
│                                                          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                  WHO IT'S FOR                          │
│                                                          │
│  ┌────────────────────────────────────────────────┐   │
│  │     FOR CERAMIC ARTISTS                        │   │
│  │  • Build your online portfolio                 │   │
│  │  • Professional gallery                        │   │
│  │  • Share your process                          │   │
│  │  [Start Your Portfolio →]                      │   │
│  └────────────────────────────────────────────────┘   │
│                                                          │
│  ┌────────────────────────────────────────────────┐   │
│  │     FOR ART LOVERS                             │   │
│  │  • Discover talented ceramic artists          │   │
│  │  • Browse by style & technique                 │   │
│  │  • Connect directly with artists               │   │
│  │  [Explore Artists →]                           │   │
│  └────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                    FEATURES                            │
│                                                          │
│  (2x4 grid on tablet)                                   │
│  [Gallery] [Catalog]                                    │
│  [Process] [Press]                                      │
│  [Series]  [About]                                      │
│  [Contact] [Privacy]                                    │
└────────────────────────────────────────────────────────┘

(Remaining sections stack vertically)
```

---

## Mobile Layout (<768px)

```
┌──────────────────────────────┐
│  Clay Companion         ☰    │
└──────────────────────────────┘

┌──────────────────────────────┐
│        HERO SECTION          │
│                              │
│  By Artists, For Artists     │
│                              │
│  A platform built to help    │
│  ceramic artists showcase    │
│  their work                  │
│                              │
│  [Start Your Portfolio →]    │
└──────────────────────────────┘

┌──────────────────────────────┐
│   WHAT IS CLAY COMPANION     │
│                              │
│  Clay Companion is a         │
│  portfolio platform...       │
│  (Full text)                 │
└──────────────────────────────┘

┌──────────────────────────────┐
│      WHO IT'S FOR            │
│                              │
│  ┌──────────────────────┐   │
│  │  FOR ARTISTS         │   │
│  │  • Build portfolio   │   │
│  │  • Share process     │   │
│  │  [Start →]           │   │
│  └──────────────────────┘   │
│                              │
│  ┌──────────────────────┐   │
│  │  FOR ART LOVERS      │   │
│  │  • Discover artists  │   │
│  │  • Find inspiration  │   │
│  │  [Explore →]         │   │
│  └──────────────────────┘   │
└──────────────────────────────┘

┌──────────────────────────────┐
│         FEATURES             │
│                              │
│  (Single column stacked)     │
│  [📸 Gallery]                │
│  [📂 Catalog]                │
│  [🎨 Process]                │
│  [📰 Press]                  │
│  [🗂️ Series]                 │
│  [👤 About]                  │
│  [📧 Contact]                │
│  [🔒 Privacy]                │
└──────────────────────────────┘

(Remaining sections stack)
```

---

## Component Details

### 1. Hero Section

- **Headline**: "By Artists, For Artists" (large, bold)
- **Subheading**: 1-2 sentences about the platform
- **CTA Button**: "Start Your Portfolio" (primary button)
- **Background**: Optional background image (ceramics/studio), subtle overlay
- **Height**: 60vh on desktop, 50vh on mobile
- **Style**: Clean, centered text, generous spacing

### 2. What is Clay Companion

- **Max Width**: ~800px, centered
- **Text**: 2-3 paragraphs explaining the platform
- **Font Size**: 18-20px for readability
- **Style**: Simple, clean, focused on message

### 3. Who It's For

- **Layout**: Two equal columns (desktop), stacked (mobile)
- **Cards**: Subtle background or border
- **Content per card**:
  - Audience heading (e.g., "For Ceramic Artists")
  - 5-6 bullet points
  - CTA button specific to audience
- **Icons**: Optional icons for visual interest
- **Spacing**: Generous gap between columns

### 4. Features Grid

- **Layout**: 4 columns × 2 rows (desktop), 2×4 (tablet), 1×8 (mobile)
- **Cards**: Icon + heading + short description
- **Icons**: Emoji or icon set (consistent style)
- **Hover**: Subtle elevation on desktop
- **Size**: Equal height cards
- **Spacing**: Consistent grid gap

### 5. How It Works

- **Layout**: 3 steps, horizontal on desktop, stacked on mobile
- **Each step**:
  - Large number (1, 2, 3)
  - Step title
  - Brief description (1-2 sentences)
- **Arrows**: Between steps on desktop (→)
- **CTA**: "Start Your Portfolio" button below
- **Style**: Clean, simple, visual flow

### 6. Our Story (Optional for MVP)

- **Max Width**: ~800px, centered
- **Text**: 2 paragraphs about origin and mission
- **Style**: Personal, authentic tone
- **Decision**: Include or skip for MVP?

### 7. Final Call to Action

- **Layout**: Centered section
- **Headline**: Action-oriented (e.g., "Ready to share your work?")
- **Buttons**: Two options (Start Portfolio / Explore Artists)
- **Style**: Clear, prominent, encouraging

### 8. Footer

- **Content**: Standard footer links
- **Style**: Consistent with other pages
- **Background**: Light grey

---

## Content Guidelines

### Tone & Voice

- **Authentic**: Written by people who understand ceramic art
- **Welcoming**: Inclusive, encouraging
- **Professional**: Trustworthy but not corporate
- **Concise**: Clear and to-the-point

### Key Messages

1. Built specifically for ceramic artists
2. Professional portfolio + internal catalog
3. Easy to use
4. Community-focused
5. "By artists, for artists"

### Avoid

- Generic tech/startup jargon
- Over-promising features
- Comparing to competitors
- Too much text (keep it scannable)

---

## Technical Notes

### SEO

- **Title**: "About Clay Companion | Portfolio Platform for Ceramic Artists"
- **Meta Description**: "Clay Companion is a portfolio platform built specifically for ceramic artists. Showcase your work, organize your catalog, and connect with art lovers."
- **H1**: "By Artists, For Artists"
- **H2s**: Section headings (What is Clay Companion, Who It's For, etc.)

### Performance

- **Images**: Lazy load, optimized
- **Animations**: Subtle fade-ins on scroll (optional)
- **Fast load**: Minimal assets, server-side rendering

### Accessibility

- **Headings**: Proper hierarchy (H1 → H2 → H3)
- **Contrast**: WCAG AA compliant
- **Alt text**: All images and icons
- **Keyboard nav**: All interactive elements

---

## Open Questions

1. **Our Story Section**: Include in MVP or save for later?
   - **Lean toward**: Include (adds authenticity and connection)

2. **Team Section**: Show founders/team members?
   - **Lean toward**: Skip for MVP (can add later)

3. **Testimonials**: Include artist testimonials?
   - **Decision**: Skip for MVP (need real users first)

4. **Pricing**: Mention pricing or subscription model?
   - **Decision**: Not in MVP (free for all artists initially)

5. **Contact**: Include contact info or form?
   - **Decision**: Add simple contact link in footer

6. **Background Images**: Use photos or keep minimal?
   - **Lean toward**: Hero background image only, rest minimal

---

## MVP Content Sections (Final)

**Confirmed for MVP**:

1. ✅ Hero (mission + CTA)
2. ✅ What is Clay Companion (explanation)
3. ✅ Who It's For (artists + art lovers)
4. ✅ Features (8 key features)
5. ✅ How It Works (3 steps)
6. ✅ Our Story (brief, 2 paragraphs)
7. ✅ Final CTA
8. ✅ Footer

**Post-MVP**:

- Team section
- Artist testimonials
- Pricing information
- Extended origin story
- FAQ section

---

## Design References

- **Mission-driven platforms**: Patreon About page, Etsy About
- **Portfolio platforms**: Behance About, Cargo Collective
- **Clean layouts**: Stripe About, Linear About
- **Community focus**: Kickstarter About, Dribbble About

---

## Notes

- Keep it concise - visitors should understand the platform in 30 seconds
- Lead with value proposition ("By artists, for artists")
- Clear CTAs throughout (Start Portfolio / Explore Artists)
- Mobile-first design (many visitors on phones)
- Authentic, warm tone (not corporate)
- Focus on ceramic artists specifically (differentiation)

---

**Status**: Planned and ready for implementation
