# Profile Setup Page - Wireframe

**URL**: `claycompanion.com/onboarding/profile-setup`

**Purpose**: First-time profile setup for new artists after email verification

**Reference Implementation**: See `requirements/wireframes/auth/profile-setup-preview.html` for a complete HTML/CSS reference implementation that matches this wireframe exactly.

---

## Key Design Decisions

1. **Onboarding Focus**: Welcome message and clear progress indication
2. **Required vs Optional**: Clear distinction between required and optional fields
3. **Photo Upload**: Drag-and-drop or click to upload portrait photo
4. **Skip Option**: Allow users to skip and complete later
5. **Progressive Enhancement**: Form works without JavaScript

---

## Shared Components

This page uses the same **Platform Header**, **Platform Footer**, **Auth Page Container**, **CSS Variables/Tokens**, **Common Form Input Pattern**, **Common Button Pattern**, **Common Link Pattern**, **Common Error Message Pattern**, and **Common Success Message Pattern** as defined in `login.md`. Refer to that document for complete specifications.

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Clay Companion                                    [Sign Up]  [Login]        │
│  (Platform Header - Simple, minimal)                                         │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│                                    (Centered)                                │
│                                                                               │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                    Welcome to Clay Companion                         │   │
│  │              Let's set up your artist profile                         │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ ┌───────────────┐  ┌───────────────────────────────────────┐   │   │   │
│  │  │ │ Portrait      │  │ Full Name *                          │   │   │   │
│  │  │ │ Photo *       │  │ ┌─────────────────────────────────┐ │   │   │   │
│  │  │ │               │  │ │ Jane Smith                       │ │   │   │   │
│  │  │ │ [📷 Upload]   │  │ └─────────────────────────────────┘ │   │   │   │
│  │  │ │ or drag here  │  │                                       │   │   │   │
│  │  │ │               │  │ Location                             │   │   │   │
│  │  │ │ [Preview]     │  │ ┌─────────────────────────────────┐ │   │   │   │
│  │  │ │ 120×120px     │  │ │ Portland, OR                     │ │   │   │   │
│  │  │ │               │  │ └─────────────────────────────────┘ │   │   │   │
│  │  │ └───────────────┘  └───────────────────────────────────────┘   │   │   │
│  │  │ (25% width)      (75% width)                                  │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ Bio                                                           │   │   │
│  │  │ ┌─────────────────────────────────────────────────────────┐   │   │   │
│  │  │ │ Tell us about yourself and your work...                 │   │   │   │
│  │  │ │                                                           │   │   │
│  │  │ │                                                           │   │   │
│  │  │ └─────────────────────────────────────────────────────────┘   │   │   │
│  │  │ (Optional - up to 2000 characters)                            │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Complete Setup]                            │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  [Skip for now]                                                      │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                               │
│  (Container: 600px max-width, centered, with padding)                        │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  Footer (Light grey background #F8FAF9)                                      │
│  Contact | About | Terms | Privacy | "Powered by Clay Companion"            │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Tablet Layout (768px - 1024px)

Same structure as desktop, with 90% max-width container.

---

## Mobile Layout (320px - 767px)

Same structure as desktop, with full-width container and 24px padding.

---

## Layout Specifications

### Container

- **Desktop**: 600px max-width, centered with auto margins
- **Tablet**: 90% max-width (540px-600px), centered
- **Mobile**: Full width with 24px (1.5rem) horizontal padding
- **Vertical Spacing**: 80px top margin on desktop, 40px on mobile

### Typography

- **Heading**: H1 (48px/3rem, Bold 700) - "Welcome to Clay Companion"
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - "Let's set up your artist profile"
- **Form Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Required Indicator**: Asterisk (*) in Error Red (#C73030) after label
- **Body Text**: Body (16px/1rem, Regular 400)
- **Helper Text**: Tiny (12px/0.75rem, Regular 400), Slate (#5C6C62)

### Form Elements

#### Portrait Photo, Full Name, and Location Row

**Layout**:
- **Container**: Flexbox row layout with gap
- **Portrait Photo**: 25% width (left side), spans both rows (name and location)
- **Right Column**: 75% width (right side)
  - **Full Name**: Top field in right column
  - **Location**: Bottom field in right column, directly below name
- **Gap**: 16px (1rem) between photo and right column
- **Vertical Gap**: 24px (1.5rem) between Full Name and Location fields
- **Responsive**: On mobile (< 768px), stack vertically (photo on top, name below, location below name)

#### Portrait Photo Upload

**Upload Zone**:
- **Width**: 25% of container (desktop), 100% width (mobile)
- **Default State**:
  - Border: 2px dashed Pale Celadon (#A8C4B5)
  - Border Radius: 8px (0.5rem) - MD
  - Background: Misty White (#F8FAF9)
  - Padding: 24px (1.5rem) vertical, 16px (1rem) horizontal
  - Center-aligned content
  - Min Height: 120px (desktop), 150px (mobile)

- **Drag Over State**:
  - Border: 2px dashed Celadon Green (#6E9180)
  - Background: Celadon Green at 5% opacity
  - Icon: Animated upload icon

- **Content**:
  - Icon: Camera icon (32px) or upload icon
  - Primary text: "Upload Photo" or "Drag and drop photo here"
  - Secondary text: "or click to browse" (Small, Slate)
  - File requirements: "JPG, PNG up to 5MB" (Tiny, Slate)

**Photo Preview** (After Upload):
- **Thumbnail**: 120×120px square (or responsive to container width)
- **Border**: 1px solid Pale Celadon (#A8C4B5), 4px radius
- **Border Radius**: 4px (0.25rem) - SM
- **Position**: Centered in upload zone
- **Remove Button**: X icon in top-right corner of preview
- **Replace Option**: "Change photo" link below preview
- **Max Width**: 100% of upload zone container

#### Full Name Input

- Same specifications as login page (LG size: 48px height, 16px vertical padding)
- **Width**: 75% of container (desktop), 100% width (mobile)
- **Type**: `text`
- **Placeholder**: "Jane Smith"
- **Autocomplete**: `name`
- **Required**: Yes (indicated by asterisk)

#### Location Input

- Same specifications as login page (LG size: 48px height, 16px vertical padding)
- **Width**: 75% of container (desktop), 100% width (mobile)
- **Type**: `text`
- **Placeholder**: "Portland, OR" or "City, State/Country"
- **Autocomplete**: `address-level2` or `address-level1`
- **Required**: No
- **Position**: In right column, directly below Full Name field

#### Bio Textarea

- **Min Height**: 120px (7-8 rows)
- **Padding**: 12px (0.75rem) all sides
- **Font**: Inter, 16px (1rem), Regular 400
- **Line Height**: 1.6
- **Border**: 1px solid Pale Celadon (#A8C4B5) at 50% opacity
- **Border Radius**: 8px (0.5rem) - MD
- **Resize**: Vertical only
- **Max Length**: 2000 characters
- **Character Counter**: Display remaining characters (e.g., "1,847 characters remaining")
- **Placeholder**: "Tell us about yourself and your work..."
- **Required**: No

#### Complete Setup Button

- Same specifications as login page Sign In button
- **Text**: "Complete Setup"
- **Loading State**: "Saving..." or spinner

#### Skip Link

- **Text**: "Skip for now"
- **Color**: Slate (#5C6C62)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Hover**: Underline, color changes to Celadon Green (#6E9180)
- **Position**: Below divider, centered
- **Action**: Navigates to dashboard, allows completing profile later

---

## Error States

### Required Field Missing

- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Full name is required" or "Portrait photo is required"
- **Position**: Below input field, 8px (0.5rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030)

### Invalid File Type

- **Error Message**: Below upload zone
- **Text**: "⚠️ Only JPG and PNG images are supported"
- **Styling**: Same as Common Error Message Pattern

### File Too Large

- **Error Message**: Below upload zone
- **Text**: "⚠️ Image must be under 5MB. Please compress and try again."
- **Styling**: Same as Common Error Message Pattern

### Upload Failed

- **Error Message**: Below upload zone
- **Text**: "⚠️ Upload failed. Please try again."
- **Styling**: Same as Common Error Message Pattern
- **Action**: Retry upload button

### Bio Too Long

- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Bio must be 2000 characters or less"
- **Position**: Below textarea, 8px (0.5rem) spacing
- **Character Counter**: Shows in Error Red when over limit

---

## Success States

### Profile Saved Successfully

- **Redirect**: To dashboard with success flash message
- **Flash Message**: "✓ Profile setup complete! Welcome to Clay Companion."
- **Next Step**: Show "Add Your First Artwork" CTA on dashboard

---

## Interaction & Behavior

### Form Submission

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Saving..." or spinner replaces text
   - Button disabled during submission
   - Form inputs disabled during submission

2. **Success Flow**:
   - Form submits
   - Redirect to `/dashboard`
   - Flash message: "Profile setup complete!"

3. **Error Flow**:
   - Error messages appear below relevant fields
   - Inputs maintain entered values
   - Focus returns to first error field
   - Error messages persist until form is resubmitted or fields are changed

### Photo Upload

1. **Drag and Drop**:
   - User drags file over upload zone
   - Zone highlights (border becomes Celadon Green, dashed)
   - User drops file
   - File uploads, preview appears

2. **Click to Upload**:
   - User clicks upload zone
   - File picker opens
   - User selects file
   - File uploads, preview appears

3. **Upload Progress**:
   - Progress bar shows upload percentage
   - "Uploading... 45%" text
   - Cancel button available

4. **Preview**:
   - Thumbnail appears in upload zone
   - "Change photo" link appears
   - Remove button (X) in top-right of preview

5. **Remove Photo**:
   - Click X button
   - Preview removed
   - Upload zone returns to default state

### Character Counter (Bio)

- **Display**: Below textarea, right-aligned
- **Format**: "X characters remaining" or "X / 2000 characters"
- **Color**: Slate (#5C6C62) default, Error Red (#C73030) when approaching/over limit
- **Updates**: Real-time as user types

### Skip Link

- **Action**: Navigates to `/dashboard`
- **Behavior**: Saves partial profile (email, password already saved)
- **Future Access**: Profile setup available from dashboard settings

### Keyboard Navigation

- **Tab Order**: Portrait Photo Upload → Full Name → Location → Bio → Complete Setup → Skip
- **Note**: Full Name and Location are in the same right column, so they tab sequentially
- **Enter Key**: Submits form when focus is on any input or button
- **Focus Indicators**: 2px solid Celadon Green (#6E9180) outline with 2px offset

### Link Behavior

- **Skip for now**: Navigates to `/dashboard`
- **Change photo**: Reopens file picker
- **Remove photo**: Removes uploaded photo

---

## Responsive Breakpoints

- **Mobile**: 320px - 767px
  - Full-width container with 24px padding
  - Portrait photo, full name, and location stack vertically (photo on top, name below, location below name)
  - All fields: 100% width on mobile
  - Touch-friendly targets (48px minimum height)
  - Photo upload zone: Full width, min-height: 150px

- **Tablet**: 768px - 1024px
  - 90% max-width container
  - Slightly reduced vertical spacing
  - Same form layout as desktop

- **Desktop**: 1024px+
  - 600px max-width container, centered
  - Generous vertical spacing (80px top margin)
  - Optimal reading width for form

---

## Accessibility

### Keyboard Navigation

- **Tab Order**: Logical flow through all interactive elements
- **Focus Indicators**: Visible 2px outline in Celadon Green (#6E9180)
- **Enter Key**: Submits form when focus is on any input or button
- **File Upload**: Keyboard accessible (focusable, Enter to open file picker)

### Screen Readers

- **Form Labels**: Properly associated with inputs using `for` attribute
- **Required Fields**: Announced as "required" by screen readers
- **Error Messages**: Associated with inputs using `aria-describedby`
- **File Upload**: Properly labeled with `aria-label`
- **Character Counter**: Announced to screen readers

### Visual Accessibility

- **Color Contrast**: All text meets WCAG AA (4.5:1 minimum)
- **Focus States**: Visible 2px outline, never rely on color alone
- **Error States**: Use both color and icon/text, not just color
- **Touch Targets**: Minimum 44×44px (48px implemented)
- **Required Indicator**: Asterisk (*) plus "required" in label text for screen readers

### Form Validation

- **Real-time Validation**: Character counter updates as user types
- **Submit Validation**: All required fields checked on submit
- **Error Announcements**: Screen readers announce errors via `aria-live` region

---

## Performance Considerations

- **Form Pre-fill**: Browser autocomplete enabled for name and location
- **No JavaScript Required**: Form works without JS (progressive enhancement)
- **Image Upload**: Client-side validation before upload
- **Loading States**: Visual feedback during submission (spinner, disabled state)
- **Image Compression**: Optional client-side compression before upload

---

## Design System Integration

### Colors Used

- **Primary Button**: Celadon Dark (#527563)
- **Links**: Celadon Green (#6E9180)
- **Text**: Charcoal (#1F2421) primary, Slate (#5C6C62) secondary
- **Borders**: Pale Celadon (#A8C4B5) at 50% opacity
- **Focus**: Celadon Green (#6E9180)
- **Error**: Error Red (#C73030)
- **Success**: Success Green (#0D8F68)
- **Background**: White (#FFFFFF) for form, Misty White (#F8FAF9) for page
- **Upload Zone**: Misty White (#F8FAF9) background

### Spacing

- **Container Padding**: 24px (1.5rem) on mobile, 32px (2rem) on desktop
- **Form Field Spacing**: 24px (1.5rem) between fields (between Location and Bio)
- **Photo/Right Column Gap**: 16px (1rem) between photo and right column
- **Name/Location Gap**: 24px (1.5rem) between Full Name and Location in right column
- **Button Top Margin**: 32px (2rem) from last field
- **Upload Zone Padding**: 24px (1.5rem) vertical, 16px (1rem) horizontal (desktop)

### Typography

- **Font Family**: Inter (Google Fonts)
- **Heading**: H1 (48px/3rem, Bold 700)
- **Subheading**: Body Large (18px/1.125rem, Regular 400)
- **Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body**: Body (16px/1rem, Regular 400)
- **Helper Text**: Tiny (12px/0.75rem, Regular 400)

---

## Finalized Design Decisions

1. ✅ **Photo Upload Zone**: Drag-and-drop with click fallback
   - Modern, intuitive interface
   - Accessible with keyboard navigation

2. ✅ **Required vs Optional**: Clear visual distinction
   - Asterisk (*) for required fields
   - Helper text for optional fields

3. ✅ **Skip Option**: Allow users to complete later
   - Reduces friction in onboarding
   - Profile can be completed from dashboard

4. ✅ **Character Counter**: Real-time feedback for bio
   - Helps users stay within limits
   - Visual feedback on remaining characters

5. ✅ **Mobile-First**: Full-width on mobile, centered on desktop
   - Touch-friendly targets (48px minimum)
   - Responsive typography and spacing

---

**Status**: Finalized ✓
**Date**: 2025-11-06
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`, reusing shared components from `login.md` and file upload patterns from Design System.

