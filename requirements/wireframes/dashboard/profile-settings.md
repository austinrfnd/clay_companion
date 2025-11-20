# Profile Settings Page - Wireframe

**URL**: `claycompanion.com/dashboard/settings/profile`

**Purpose**: Allow authenticated artists to edit their public profile content: biography, artist statement, education, awards, social links, and contact information.

**Reference**: Part of the Settings hub structure. This page focuses on public-facing profile content (not account basics or studio photos).

---

## Key Design Decisions

1. **Focused Content**: Public-facing profile content only (not account basics or studio photos)
2. **Sectioned Layout**: Clear visual separation between different content types
3. **Dynamic Lists**: Education, awards, and other links can be added/removed dynamically
4. **Character Counters**: Real-time feedback for bio and artist statement textareas
5. **Progressive Enhancement**: Form works without JavaScript, enhanced with Stimulus
6. **Persistent Sidebar**: Settings menu always visible on left (desktop)

---

## Shared Components

This page uses the same **Design System Colors**, **Typography**, **Spacing**, **Form Input Patterns**, **Button Patterns**, and **Accessibility Standards** as defined in the auth wireframes and `requirements/DESIGN_SYSTEM.md`.

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
│  │                  │  │  Profile Settings                             │  │
│  │  Settings Menu   │  │  (H1, 48px/3rem, Bold 700, Charcoal #1F2421)│  │
│  │  (Sidebar)       │  │                                                 │  │
│  │                  │  │  Manage your public profile content:          │  │
│  │  ┌────────────┐  │  │  biography, education, awards, and social     │  │
│  │  │ 👤 Account │  │  │  links.                                       │  │
│  │  └────────────┘  │  │  (Body Large, 18px/1.125rem, Slate #5C6C62)  │  │
│  │                  │  │                                                 │  │
│  │  ┌────────────┐  │  │  ┌──────────────────────────────────────┐    │  │
│  │  │ 🔒 Privacy │  │  │  │ About Content                         │    │  │
│  │  └────────────┘  │  │  │ (H2, 36px/2.25rem, Bold 700)         │    │  │
│  │                  │  │  │                                      │    │  │
│  │  ┌────────────┐  │  │  │  Biography                            │    │  │
│  │  │ 📝 Profile │  │  │  │  [Textarea - 120px min-height]       │    │  │
│  │  │    (Active)│  │  │  │  Character counter: X / 2,000        │    │  │
│  │  └────────────┘  │  │  │                                      │    │  │
│  │                  │  │  │  Artist Statement                    │    │  │
│  │  ┌────────────┐  │  │  │  [Textarea - 120px min-height]       │    │  │
│  │  │ 🏠 Studio  │  │  │  │  Character counter: X / 2,000        │    │  │
│  │  └────────────┘  │  │  └──────────────────────────────────────┘    │  │
│  │                  │  │                                                 │  │
│  │  ┌────────────┐  │  │  [Education, Awards, Social Links, Contact    │  │
│  │  │ 🎨 My Work │  │  │   sections continue...]                      │  │
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
- **Height**: 48px (3rem) - Touch-friendly
- **Padding**: 16px (1rem) vertical, 16px (1rem) horizontal
- **Font**: Inter, 16px (1rem), Regular 400
- **Border**: 1px solid rgba(168, 196, 181, 0.5) - Pale Celadon at 50% opacity
- **Border Radius**: 8px (0.5rem) - MD
- **Background**: White (#FFFFFF)
- **Focus**: 2px solid Celadon Green (#6E9180) outline, 2px offset
- **Error**: 2px solid Error Red (#C73030) border

**Disabled Input** (Email):
- **Background**: Misty White (#F8FAF9)
- **Text Color**: Slate (#5C6C62)
- **Cursor**: not-allowed
- **Border**: 1px solid rgba(168, 196, 181, 0.3)

### Textareas

**Biography & Artist Statement**:
- **Min Height**: 120px (7.5rem) - ~7-8 lines
- **Padding**: 12px (0.75rem) all sides
- **Font**: Inter, 16px (1rem), Regular 400
- **Line Height**: 1.6
- **Resize**: Vertical only
- **Max Length**: 2000 characters
- **Border**: Same as text inputs
- **Character Counter**: Right-aligned below textarea, 12px, Slate (#5C6C62)


### Dynamic List Items

**Education/Awards/Other Links Entries**:
- **Container**: White background, 1px solid Pale Celadon border, 8px border radius
- **Padding**: 16px (1rem) all sides
- **Margin Bottom**: 16px (1rem) between entries
- **Remove Button**: Text link, 14px, Slate (#5C6C62), underline on hover

### Buttons

**Primary Button** (Save Changes):
- **Background**: Celadon Dark (#527563)
- **Text**: White (#FFFFFF), 16px (1rem), Medium 500
- **Padding**: 12px (0.75rem) vertical, 24px (1.5rem) horizontal
- **Border Radius**: 8px (0.5rem) - MD
- **Height**: 48px (3rem)
- **Hover**: Slightly darker background
- **Focus**: 2px Celadon Green outline, 2px offset

**Secondary Button** (Cancel):
- **Background**: Transparent
- **Text**: Slate (#5C6C62), 16px (1rem), Medium 500
- **Border**: 1px solid Pale Celadon (#A8C4B5)
- **Padding**: Same as primary
- **Hover**: Misty White background

**Add Button** (+ Add Education, + Add Award, + Add Link):
- **Text**: Celadon Green (#6E9180), 14px (0.875rem), Medium 500
- **Background**: Transparent
- **Hover**: Underline
- **Icon**: Plus sign (+) before text

---

## Section Spacing

- **Between Sections**: 48px (3rem) vertical spacing
- **Within Sections**: 24px (1.5rem) between form fields
- **Section Headings**: 32px (2rem) margin bottom
- **Form Actions**: 48px (3rem) top margin from last section

---

## Typography

- **Page Title (H1)**: 48px (3rem), Bold 700, Charcoal (#1F2421)
- **Section Headings (H2)**: 36px (2.25rem), Bold 700, Charcoal (#1F2421)
- **Labels**: 14px (0.875rem), Medium 500, Charcoal (#1F2421)
- **Helper Text**: 12px (0.75rem), Regular 400, Slate (#5C6C62)
- **Body Text**: 16px (1rem), Regular 400, Charcoal (#1F2421)
- **Button Text**: 16px (1rem), Medium 500
- **Link Text**: 14px (0.875rem), Celadon Green (#6E9180)

---

## Colors

- **Background**: Misty White (#F8FAF9) for page, White (#FFFFFF) for form sections
- **Text**: Charcoal (#1F2421) primary, Slate (#5C6C62) secondary
- **Borders**: Pale Celadon (#A8C4B5) at 50% opacity
- **Focus**: Celadon Green (#6E9180)
- **Error**: Error Red (#C73030)
- **Links**: Celadon Green (#6E9180)
- **Buttons**: Celadon Dark (#527563) for primary

---

## Settings Sidebar

**Persistent Menu**: Left sidebar (240px width) with all 5 settings sections
- **Account** - inactive link
- **Privacy** - inactive link
- **Profile** (active on this page) - highlighted with background and left border
- **My Studio** - inactive link
- **My Work** - inactive link

**Active State**: Misty White background (#F8FAF9), 3px left border in Celadon Green (#6E9180)

**Menu Item Specifications**:
- **Height**: 48px (3rem) - Touch-friendly
- **Padding**: 12px (0.75rem) vertical, 16px (1rem) horizontal
- **Icon**: 20px icon on left
- **Text**: 14px (0.875rem), Medium 500
- **Inactive**: Slate (#5C6C62) text and icon
- **Active**: Charcoal (#1F2421) text, Celadon Green (#6E9180) icon
- **Hover**: Misty White background at 50% opacity

## Responsive Breakpoints

### Mobile (320px - 767px)

- **Sidebar**: Hidden by default, hamburger menu to toggle
- **Content**: Full width with 24px (1.5rem) padding
- **Sections**: Stack vertically, full width
- **Form Fields**: 100% width
- **Dynamic Lists**: Full width entries
- **Typography**: Slightly reduced (H1: 36px, H2: 30px)

### Tablet (768px - 1024px)

- **Sidebar**: Collapsible, toggle button
- **Content**: Full width when sidebar hidden, remaining width when visible
- **Sections**: Same as desktop but slightly reduced spacing
- **Form Fields**: Full width within container

### Desktop (1024px+)

- **Sidebar**: Always visible, 240px fixed width
- **Content**: Remaining width, max-width 800px
- **Sections**: Full layout as specified
- **Form Fields**: Full width within container

---

## Accessibility

### ARIA Labels

- All form inputs have explicit `aria-label` or associated `<label>` elements
- Photo upload zones: `aria-label="Upload profile photo"` or `aria-label="Upload studio photo"`
- Dynamic list items: `aria-label="Education entry 1"`, etc.
- Remove buttons: `aria-label="Remove education entry"`

### Keyboard Navigation

- **Tab Order**: Logical flow through all form fields
- **Photo Upload**: Tab-accessible, Enter key to open file picker
- **Dynamic Lists**: Tab through all fields in entry, then to Add button
- **Remove Buttons**: Tab-accessible, Enter key to remove
- **Focus Indicators**: 2px solid Celadon Green outline, 2px offset on all interactive elements

### Screen Reader Support

- **Section Headings**: Proper heading hierarchy (H1 → H2)
- **Form Groups**: Use `<fieldset>` and `<legend>` for grouped fields (education, awards)
- **Error Messages**: Associated with inputs via `aria-describedby`
- **Character Counters**: Announced to screen readers
- **Required Fields**: Asterisk (*) with `aria-label="required"`

### Focus States

- **All Interactive Elements**: 2px solid Celadon Green (#6E9180) outline
- **Offset**: 2px from element edge
- **Visible**: Always visible on keyboard focus (focus-visible)

---

## Error States

### Validation Errors

**Inline Error Display**:
- **Position**: Below input field, 8px (0.5rem) spacing
- **Text**: Error Red (#C73030), 12px (0.75rem)
- **Icon**: Error icon (optional) before message
- **Border**: Input border changes to 2px solid Error Red (#C73030)
- **ARIA**: `aria-invalid="true"` on input, `aria-describedby` pointing to error message

**Common Error Messages**:
- "Full name is required"
- "Profile photo is required"
- "Invalid URL format"
- "Year must be between 1900 and current year"
- "Biography exceeds 2,000 character limit"
- "File must be JPG or PNG"
- "File size must be under 5MB"

### Flash Messages

**Success Message** (after save):
- **Type**: Success (green)
- **Message**: "Profile updated successfully"
- **Position**: Top of page, below header
- **Auto-dismiss**: After 5 seconds (dismissible)

**Error Message** (on save failure):
- **Type**: Error (red)
- **Message**: "Unable to save profile. Please check for errors."
- **Position**: Top of page, below header

---

## JavaScript/Stimulus Controllers

### Character Counter Controller

**Reuse**: `character_counter_controller.js` (from profile setup)

**Functionality**:
- Real-time character count for bio and artist statement
- Visual feedback when approaching limit
- Error state when over limit

### Dynamic List Controller

**New**: `dynamic_list_controller.js`

**Functionality**:
- Add new entries (education, awards, other links)
- Remove entries
- Reorder entries (optional, for future enhancement)
- Form field cloning
- Validation (ensure required fields in entries)

---

## Form Submission

### Save Changes Flow

1. User clicks "Save Changes" button
2. Form validates (client-side and server-side)
3. If valid:
   - Show loading state on button ("Saving...")
   - Submit form via PATCH request
   - On success: Show success flash message, stay on page
   - On error: Show error flash message, display inline errors
4. If invalid:
   - Display inline error messages
   - Focus first error field
   - Prevent form submission

### Cancel Flow

1. User clicks "Cancel" button
2. Warn if unsaved changes (optional, for future enhancement)
3. Navigate to dashboard

### Preview Public Profile Flow

1. User clicks "Preview Public Profile" link
2. Opens public portfolio in new tab/window
3. Shows how profile appears to visitors

---

## Data Validation

### Client-Side (JavaScript)

- URL format validation (must start with http:// or https://)
- Year validation (1900 to current year)
- Character count limits (bio, artist statement)
- File type validation (JPG, PNG only)
- File size validation (max 5MB)

### Server-Side (Rails)

- Full name: Required, max 100 characters
- Email: Display only, not editable
- Location: Optional, max 100 characters
- Bio: Optional, max 2000 characters
- Artist Statement: Optional, max 2000 characters
- Education: Array of objects with institution, degree, year (all required in entry)
- Awards: Array of objects with title, organization, year (all required in entry)
- URLs: Valid HTTP/HTTPS format (if provided)
- Contact Email: Valid email format (if provided)
- Phone: Optional, max 20 characters

---

## Empty States

### No Education Entries

- Show "+ Add Education" button
- Helper text: "Add your educational background (optional)"

### No Awards

- Show "+ Add Award" button
- Helper text: "Add awards and recognition (optional)"

### No Other Links

- Show "+ Add Link" button
- Helper text: "Add additional social or portfolio links (optional)"


---

## Loading States

### Form Submission

- **Button State**: "Saving..." text, disabled, spinner icon
- **Form State**: All inputs disabled during submission
- **No Navigation**: Prevent navigation during save

---

## Finalized Design Decisions

1. ✅ **Focused Content**: Public-facing profile content only
2. ✅ **Sectioned Layout**: Clear visual separation with H2 headings
3. ✅ **Dynamic Lists**: Add/remove functionality for education, awards, links
4. ✅ **Character Counters**: Real-time feedback for textareas
5. ✅ **Progressive Enhancement**: Form works without JavaScript
6. ✅ **Accessibility**: Full WCAG AA compliance
7. ✅ **Responsive**: Mobile-first design with breakpoints

---

## Database Schema

All fields already exist in `artists` table:
- `full_name` (string, required)
- `email` (string, required, not editable)
- `location` (string, optional)
- `bio` (text, optional, max 2000)
- `artist_statement` (text, optional, max 2000)
- `education` (jsonb, optional, array of objects)
- `awards` (jsonb, optional, array of objects)
- `contact_email` (string, optional)
- `contact_phone` (string, optional)
- `website_url` (string, optional)
- `instagram_url` (string, optional)
- `facebook_url` (string, optional)
- `other_links` (jsonb, optional, array of objects)

---

**Status**: Finalized ✓  
**Date**: 2025-01-15  
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md` and reuses patterns from auth wireframes.

