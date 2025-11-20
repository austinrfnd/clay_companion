# Account Settings Page - Wireframe

**URL**: `claycompanion.com/dashboard/settings/account`

**Purpose**: Allow authenticated artists to manage their basic account information: full name, location, and profile photo.

**Reference**: Part of the Settings hub structure.

---

## Key Design Decisions

1. **Focused Form**: Only essential account information
2. **Photo Management**: Drag-and-drop upload with preview
3. **Simple Layout**: Clean, minimal form
4. **Quick Save**: Single save button for all changes
5. **Persistent Sidebar**: Settings menu always visible on left (desktop)

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
│  │                  │  │  Account Settings                            │  │
│  │  Settings Menu   │  │  (H1, 48px/3rem, Bold 700, Charcoal #1F2421)│  │
│  │  (Sidebar)       │  │                                                 │  │
│  │                  │  │  Manage your basic account information.       │  │
│  │  ┌────────────┐  │  │  (Body Large, 18px/1.125rem, Slate #5C6C62)  │  │
│  │  │ 👤 Account │  │  │                                                 │  │
│  │  │    (Active)│  │  │  ┌──────────────────────────────────────┐    │  │
│  │  └────────────┘  │  │  │                                      │    │  │
│  │                  │  │  │  Full Name *                          │    │  │
│  │  ┌────────────┐  │  │  │  (Label: 14px/0.875rem, Medium 500)  │    │  │
│  │  │ 🔒 Privacy │  │  │  │  ┌────────────────────────────────┐  │    │  │
│  │  └────────────┘  │  │  │  │ Jane Smith                     │  │    │  │
│  │                  │  │  │  └────────────────────────────────┘  │    │  │
│  │  ┌────────────┐  │  │  │                                      │    │  │
│  │  │ 📝 Profile │  │  │  │  Location                            │    │  │
│  │  └────────────┘  │  │  │  ┌────────────────────────────────┐  │    │  │
│  │                  │  │  │  │ Portland, Oregon               │  │    │  │
│  │  ┌────────────┐  │  │  │  └────────────────────────────────┘  │    │  │
│  │  │ 🏠 Studio  │  │  │  │                                      │    │  │
│  │  └────────────┘  │  │  │  Profile Photo *                    │    │  │
│  │                  │  │  │  [Photo upload zone - 200×200px]    │    │  │
│  │  ┌────────────┐  │  │  │                                      │    │  │
│  │  │ 🎨 My Work │  │  │  └──────────────────────────────────────┘    │  │
│  │  └────────────┘  │  │                                                 │  │
│  │                  │  │  [Cancel]  [Save Changes]                      │  │
│  │  (240px width)   │  │                                                 │  │
│  └──────────────────┘  └─────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Form Field Specifications

### Text Inputs

**Standard Input**:
- **Height**: 48px (3rem)
- **Padding**: 16px (1rem) vertical, 16px (1rem) horizontal
- **Font**: Inter, 16px (1rem), Regular 400
- **Border**: 1px solid rgba(168, 196, 181, 0.5)
- **Border Radius**: 8px (0.5rem)
- **Background**: White (#FFFFFF)
- **Focus**: 2px solid Celadon Green (#6E9180) outline

### Photo Upload Zone

**Profile Photo**:
- **Size**: 200×200px square (desktop), responsive on mobile
- **Border**: 2px dashed Pale Celadon (#A8C4B5)
- **Border Radius**: 8px (0.5rem)
- **Background**: Misty White (#F8FAF9)
- **Padding**: 24px (1.5rem) all sides
- **Drag Over State**: Border changes to Celadon Green (#6E9180)
- **Preview**: Centered, 200×200px, border radius 4px

---

## Settings Sidebar

**Persistent Menu**: Left sidebar (240px width) with all 5 settings sections
- **Account** (active on this page) - highlighted with background and left border
- **Privacy** - inactive link
- **Profile** - inactive link
- **My Studio** - inactive link
- **My Work** - inactive link

**Active State**: Misty White background (#F8FAF9), 3px left border in Celadon Green (#6E9180)

## Responsive Breakpoints

### Mobile (320px - 767px)
- **Sidebar**: Hidden by default, hamburger menu to toggle
- **Content**: Full width with 24px padding
- **Photo Upload**: Full width, min-height 150px
- **Form Fields**: 100% width

### Tablet (768px - 1023px)
- **Sidebar**: Collapsible, toggle button
- **Content**: Full width when sidebar hidden
- **Photo Upload**: 200×200px

### Desktop (1024px+)
- **Sidebar**: Always visible, 240px fixed width
- **Content**: Remaining width, max-width 800px
- **Photo Upload**: 200×200px

---

## Accessibility

- All inputs have explicit labels
- Photo upload zone: `aria-label="Upload profile photo"`
- Focus indicators: 2px solid Celadon Green outline
- Required fields: Asterisk (*) with `aria-label="required"`

---

**Status**: Finalized ✓  
**Date**: 2025-01-15  
**Design System Compliance**: Follows `requirements/DESIGN_SYSTEM.md` specifications.

