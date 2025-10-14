# Add/Edit Artwork Page - Wireframe

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Dashboard > Catalog > Add Artwork                                    [User]│
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│  ┌────────────────────────────────┐  ┌──────────────────────────────────┐  │
│  │                                │  │                                  │  │
│  │   IMAGE UPLOAD AREA            │  │  Title *                         │  │
│  │                                │  │  ┌────────────────────────────┐  │  │
│  │   ╔══════════════════════════╗ │  │  │                            │  │  │
│  │   ║                          ║ │  │  └────────────────────────────┘  │  │
│  │   ║   Drag & Drop Images     ║ │  │                                  │  │
│  │   ║         Here             ║ │  │  Description                     │  │
│  │   ║                          ║ │  │  ┌────────────────────────────┐  │  │
│  │   ║   or Click to Browse     ║ │  │  │                            │  │  │
│  │   ║                          ║ │  │  │                            │  │  │
│  │   ╚══════════════════════════╝ │  │  │                            │  │  │
│  │                                │  │  │                            │  │  │
│  │   Uploaded Images:             │  │  └────────────────────────────┘  │  │
│  │                                │  │                                  │  │
│  │   ┌────┐ ┌────┐ ┌────┐        │  │  Series                          │  │
│  │   │ 🖼️ │ │ 🖼️ │ │ 🖼️ │        │  │  ┌────────────────────────────┐  │  │
│  │   │[1] │ │[2] │ │[3] │        │  │  │ Select or create new...  ▼ │  │  │
│  │   └────┘ └────┘ └────┘        │  │  └────────────────────────────┘  │  │
│  │   [⭐Primary] [🗑️Delete]       │  │                                  │  │
│  │                                │  │  Group (within series)           │  │
│  │   (Drag to reorder)            │  │  ┌────────────────────────────┐  │  │
│  │                                │  │  │ Select group...          ▼ │  │  │
│  │                                │  │  └────────────────────────────┘  │  │
│  │                                │  │                                  │  │
│  └────────────────────────────────┘  │  ─────────────────────────────   │  │
│                                       │                                  │  │
│                                       │  Clay Details                    │  │
│                                       │                                  │  │
│                                       │  Clay Type                       │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │                            │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │                                  │  │
│                                       │  Firing Cone                     │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │                            │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │                                  │  │
│                                       │  Firing Schedule                 │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │                            │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │                                  │  │
│                                       │  Internal Notes (Private)        │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │                            │  │  │
│                                       │  │                            │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │                                  │  │
│                                       │  ─────────────────────────────   │  │
│                                       │                                  │  │
│                                       │  Physical Details                │  │
│                                       │                                  │  │
│                                       │  Dimensions     Weight           │  │
│                                       │  ┌───────────┐ ┌──────────────┐ │  │
│                                       │  │           │ │              │ │  │
│                                       │  └───────────┘ └──────────────┘ │  │
│                                       │                                  │  │
│                                       │  Year Created                    │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │ 2024                       │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │                                  │  │
│                                       │  ─────────────────────────────   │  │
│                                       │                                  │  │
│                                       │  Display Settings                │  │
│                                       │                                  │  │
│                                       │  ☐ Make Public                   │  │
│                                       │  ☐ Feature on Homepage           │  │
│                                       │                                  │  │
│                                       │  Availability Status             │  │
│                                       │  ┌────────────────────────────┐  │  │
│                                       │  │ Available              ▼   │  │  │
│                                       │  └────────────────────────────┘  │  │
│                                       │  (Available, Sold, Commissioned, │  │
│                                       │   Not for Sale)                  │  │
│                                       │                                  │  │
│                                       └──────────────────────────────────┘  │
│                                                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │         [Cancel]                          [Save as Draft] [Save]     │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Layout Notes

### Left Side - Image Upload (40% width)
- Primary drag-drop zone at top
- Shows uploaded images below in a row
- Each thumbnail has:
  - Order number [1], [2], [3]
  - Primary star indicator
  - Delete button
- Drag images to reorder

### Right Side - Form (60% width)
- Scrollable if form is long
- Grouped into logical sections:
  1. Basic Info (Title, Description)
  2. Organization (Series, Group)
  3. Clay Details (Type, Cone, Schedule, Notes)
  4. Physical Details (Dimensions, Weight, Year)
  5. Display Settings (Public, Featured, Availability)

### Bottom - Actions
- Left: Cancel button
- Right: Save as Draft (optional), Save button

## Responsive Behavior
- On mobile/tablet: Stack vertically (images on top, form below)

---

## Alternative Layout Option

If you want to see images while filling form on mobile:

```
┌────────────────────────────────┐
│ [Images] [Form Details] [More] │  ← Tabs
├────────────────────────────────┤
│                                │
│   Tab content here             │
│                                │
└────────────────────────────────┘
```

Would you like to see this layout, or stick with the side-by-side approach?
