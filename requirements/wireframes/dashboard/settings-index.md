# Settings Index Page - Wireframe

**URL**: `claycompanion.com/dashboard/settings`

**Purpose**: Central hub for artists to access all settings sections. Provides navigation to Account, Privacy, Profile, My Studio, and My Work settings.

**Reference**: This wireframe provides the main settings navigation structure.

---

## Key Design Decisions

1. **Card-Based Navigation**: Each settings section is a card with icon, title, description, and link
2. **Clear Organization**: Logical grouping of related settings
3. **Quick Access**: Direct links to most common settings
4. **Visual Hierarchy**: Clear distinction between sections

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Clay Companion                    [Dashboard] [Settings ▼] [Sign Out]      │
│  (Dashboard Header - Navigation)                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│  ┌──────────────────┐  ┌──────────────────────────────────────────────┐  │
│  │                  │  │  Settings                                      │  │
│  │  Settings Menu   │  │  (H1, 48px/3rem, Bold 700, Charcoal #1F2421) │  │
│  │  (Sidebar)       │  │                                                 │  │
│  │                  │  │  ┌──────────────────────────────────────┐    │  │
│  │  ┌────────────┐  │  │  │                                      │    │  │
│  │  │ 👤 Account │  │  │  │  Dashboard Placeholder               │    │  │
│  │  │    (Active)│  │  │  │  (H2, 36px/2.25rem, Bold 700)        │    │  │
│  │  └────────────┘  │  │  │                                      │    │  │
│  │                  │  │  │  This area will display dashboard    │    │  │
│  │  ┌────────────┐  │  │  │  information such as:                │    │  │
│  │  │ 🔒 Privacy │  │  │  │                                      │    │  │
│  │  └────────────┘  │  │  │  • Profile view statistics           │    │  │
│  │                  │  │  │  • Friend/connection requests        │    │  │
│  │  ┌────────────┐  │  │  │  • Pending purchases of your work    │    │  │
│  │  │ 📝 Profile │  │  │  │  • Recent activity                   │    │  │
│  │  └────────────┘  │  │  │  • Notifications                     │    │  │
│  │                  │  │  │                                      │    │  │
│  │  ┌────────────┐  │  │  │  (Body, 16px/1rem, Regular 400,      │    │  │
│  │  │ 🏠 Studio  │  │  │  │   Slate #5C6C62)                     │    │  │
│  │  └────────────┘  │  │  │                                      │    │  │
│  │                  │  │  │  [Content to be designed in future]  │    │  │
│  │  ┌────────────┐  │  │  │                                      │    │  │
│  │  │ 🎨 My Work │  │  │  └──────────────────────────────────────┘    │  │
│  │  └────────────┘  │  │                                                 │  │
│  │                  │  │                                                 │  │
│  │  (240px width)   │  │                                                 │  │
│  └──────────────────┘  └─────────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Settings Sidebar Menu

### Menu Structure

**Position**: Left sidebar, persistent across all settings pages  
**Width**: 240px (desktop), hidden/collapsible on mobile  
**Background**: White (#FFFFFF)  
**Border**: 1px solid rgba(168, 196, 181, 0.3) on right

### Sidebar Header (Optional)

- **Text**: "Settings" (14px, Semibold 600, Charcoal #1F2421)
- **Text Transform**: Uppercase, letter spacing 0.05em
- **Padding**: 16px (1rem) vertical, 24px (1.5rem) horizontal
- **Border Bottom**: 1px solid rgba(168, 196, 181, 0.3)

### Section Headers (For Grouping)

- **Text**: Section name (12px, Semibold 600, Slate #5C6C62)
- **Text Transform**: Uppercase, letter spacing 0.05em
- **Padding**: 8px (0.5rem) vertical, 24px (1.5rem) horizontal
- **Margin Top**: 8px (0.5rem) for first section

### Menu Items

Each menu item is a clickable link with:
- **Icon**: 20px (1.25rem) Lucide icon on left, 12px (0.75rem) gap from text
- **Text**: Section name (14px)
- **Height**: 44px (2.75rem) - Touch-friendly
- **Padding**: 12px (0.75rem) vertical, 24px (1.5rem) horizontal
- **Margin**: 2px (0.125rem) vertical between items
- **Transition**: All properties, 150ms duration

### Active State

- **Background**: Misty White (#F8FAF9)
- **Left Border**: 3px solid Celadon Green (#6E9180)
- **Text Color**: Charcoal (#1F2421)
- **Font Weight**: Semibold 600
- **Icon Color**: Celadon Green (#6E9180)

### Inactive State

- **Background**: Transparent
- **Text Color**: Slate (#5C6C62)
- **Font Weight**: Medium 500
- **Icon Color**: Slate (#5C6C62)
- **Hover**: Background changes to Misty White at 70% opacity

### Focus State

- **Outline**: None (removed default)
- **Ring**: 2px solid Celadon Green (#6E9180)
- **Ring Offset**: 2px
- **Visible**: On keyboard navigation only (`:focus-visible`)

### Section Dividers

- **Height**: 1px
- **Background**: Pale Celadon at 30% opacity
- **Margin**: 8px (0.5rem) vertical, 24px (1.5rem) horizontal

### Menu Items List

**Account & Security Section**:
1. **Account** (`/dashboard/settings/account`)
   - Icon: User (Lucide)
   - Active when on Account Settings page
   - Content: Full name, Location, Profile photo

2. **Privacy** (`/dashboard/settings/privacy`)
   - Icon: Lock (Lucide)
   - Active when on Privacy Settings page
   - Content: Password change, Email change (Post-MVP)

**Content & Portfolio Section**:
3. **Profile** (`/dashboard/settings/profile`)
   - Icon: FileText (Lucide)
   - Active when on Profile Settings page
   - Content: Biography, Artist statement, Education, Awards, Social links, Contact info

4. **My Studio** (`/dashboard/settings/studio`)
   - Icon: Home (Lucide)
   - Active when on Studio Settings page
   - Content: Studio photo, Studio/Process photos, Process page settings

5. **My Work** (`/dashboard/settings/work`)
   - Icon: Image (Lucide)
   - Active when on Work Settings page
   - Content: Links to Catalog, Series, Exhibitions, Press management

### Icon System

- **Library**: Lucide Icons (as per design system)
- **Size**: 20px (1.25rem) square
- **Stroke Width**: 2px
- **Color**: Inherits from parent (Celadon Green for active, Slate for inactive)
- **Accessibility**: `aria-hidden="true"` on icon SVG (text label provides meaning)


---

## Main Content Area

### Content Layout

When on Settings Index page, the main content area is a **placeholder** for future dashboard content.

**Placeholder Content**:
- **Title**: "Dashboard Placeholder" (H2, 36px/2.25rem, Bold 700)
- **Description**: List of potential future content types
- **Style**: Centered or left-aligned, informational text
- **Background**: White (#FFFFFF)
- **Padding**: 24px (1.5rem) all sides

**Future Content Ideas** (to be designed later):
- Profile view statistics (how many people are viewing your profile)
- Friend/connection requests
- Pending purchases of your work
- Recent activity feed
- Notifications
- Quick actions/widgets
- Analytics and insights

### Layout

**Desktop (1024px+)**:
- **Sidebar**: 240px fixed width, left side
- **Content**: Remaining width, max-width 1200px
- **Placeholder**: Centered or left-aligned informational content

**Tablet (768px - 1023px)**:
- **Sidebar**: Collapsible/hidden, toggle button
- **Content**: Full width when sidebar hidden
- **Placeholder**: Full width

**Mobile (320px - 767px)**:
- **Sidebar**: Hidden by default, hamburger menu to toggle
- **Content**: Full width
- **Placeholder**: Full width with padding

---

## Typography

- **Page Title (H1)**: 48px (3rem), Bold 700, Charcoal (#1F2421)
- **Placeholder Title (H2)**: 36px (2.25rem), Bold 700, Charcoal (#1F2421)
- **Menu Item Text**: 14px (0.875rem), Medium 500
- **Body Text**: 16px (1rem), Regular 400, Slate (#5C6C62)
- **Placeholder List**: 16px (1rem), Regular 400, Slate (#5C6C62)

---

## Colors

- **Background**: Misty White (#F8FAF9) for page, White (#FFFFFF) for cards
- **Text**: Charcoal (#1F2421) for headings, Slate (#5C6C62) for body
- **Borders**: Pale Celadon (#A8C4B5) at 30% opacity
- **Links**: Celadon Green (#6E9180)
- **Hover**: Celadon Green border, subtle shadow

---

## Accessibility

### ARIA Labels

- Each card: `role="article"` or `role="link"`
- Card links: `aria-label="Manage Account settings"` etc.
- Icons: `aria-hidden="true"` (decorative)

### Keyboard Navigation

- **Tab Order**: Through each card link
- **Enter Key**: Activates card link
- **Focus Indicators**: 2px solid Celadon Green outline, 2px offset

### Screen Reader Support

- **Semantic HTML**: Use `<section>` for main container, `<article>` or `<a>` for cards
- **Headings**: Proper hierarchy (H1 for page title)
- **Descriptive Links**: Link text clearly describes destination

---

## Responsive Breakpoints

### Mobile (320px - 767px)

- **Container**: Full width with 24px (1.5rem) padding
- **Cards**: Stacked vertically, full width
- **Typography**: Slightly reduced (H1: 36px, card title: 20px)
- **Icon Size**: 40px (2.5rem)

### Tablet (768px - 1023px)

- **Container**: 90% max-width, centered
- **Grid**: 2 columns
- **Cards**: Equal width

### Desktop (1024px+)

- **Container**: 1200px max-width, centered
- **Grid**: 3 columns (or 4 with My Work spanning 2)
- **Cards**: Equal width, 300px each

---

## Empty States

If any section has incomplete setup, show a badge or indicator:
- **Badge**: "Setup Required" or "Incomplete" in Warning Orange (#D68500)
- **Position**: Top-right corner of card
- **Size**: Small badge, 12px text

---

## Finalized Design Decisions

1. ✅ **Persistent Sidebar Menu**: Consistent navigation across all settings pages
2. ✅ **Active State Indication**: Clear visual feedback for current section
3. ✅ **Placeholder Content**: Main area reserved for future dashboard content (stats, notifications, activity)
4. ✅ **Responsive Design**: Sidebar collapses/hides on mobile, toggleable on tablet
5. ✅ **Accessibility**: Full keyboard navigation and screen reader support

## Future Content Planning

The main content area on the Settings Index page will be designed to display:

- **Profile Statistics**: View counts, visitor analytics
- **Social Activity**: Friend/connection requests, new followers
- **Commerce**: Pending purchases, sales notifications
- **Activity Feed**: Recent updates, comments, interactions
- **Quick Actions**: Common tasks, shortcuts
- **Notifications**: System alerts, important updates

**Note**: This content will be designed in a future phase. For now, a simple placeholder indicates the intended purpose.

---

**Status**: Finalized ✓  
**Date**: 2025-01-15  
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`.

