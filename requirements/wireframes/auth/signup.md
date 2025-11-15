# Signup Page - Wireframe

**URL**: `claycompanion.com/signup`

**Purpose**: Register new artists to create accounts and start building their portfolios

**Reference Implementation**: See `requirements/wireframes/auth/signup-preview.html` for a complete HTML/CSS reference implementation that matches this wireframe exactly.

---

## Key Design Decisions

1. **Centered Layout**: Narrow container (600px max-width) for focused, distraction-free signup
2. **Password Strength Indicator**: Real-time visual feedback on password requirements
3. **Clear Requirements**: Visible password requirements list
4. **Terms Acceptance**: Required checkbox for terms of service
5. **Progressive Enhancement**: Form works without JavaScript, enhanced with JS

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
│  │                        Create Your Account                           │   │
│  │                    Start building your portfolio today               │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ Email Address                                                  │   │   │
│  │  │ ┌─────────────────────────────────────────────────────────┐   │   │   │
│  │  │ │ artist@example.com                                       │   │   │   │
│  │  │ └─────────────────────────────────────────────────────────┘   │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ Password                                                       │   │   │
│  │  │ ┌─────────────────────────────────────────────────────────┐   │   │   │
│  │  │ │ ••••••••••••••••                              [👁️]    │   │   │   │
│  │  │ └─────────────────────────────────────────────────────────┘   │   │   │
│  │  │                                                                 │   │   │
│  │  │ Password Strength: [████░░░░░░] Medium                         │   │   │
│  │  │                                                                 │   │   │
│  │  │ Requirements:                                                   │   │   │
│  │  │ ✓ 8-30 characters                                              │   │   │
│  │  │ ✓ Uppercase and lowercase letters                              │   │   │
│  │  │ ✓ At least one number                                          │   │   │
│  │  │ ✗ At least one special character                               │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ ☐ I agree to the Terms of Service and Privacy Policy          │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Create Account]                            │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Already have an account? [Sign in]                                  │   │
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

- **Heading**: H1 (48px/3rem, Bold 700) - "Create Your Account"
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - "Start building your portfolio today"
- **Form Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body Text**: Body (16px/1rem, Regular 400)
- **Links**: Body (16px/1rem, Regular 400) in Celadon Green (#6E9180)

### Form Elements

#### Email Input

- Same specifications as login page (LG size: 48px height, 16px vertical padding)
- **Type**: `email`
- **Placeholder**: "artist@example.com"
- **Autocomplete**: `email`

#### Password Input

- Same specifications as login page (LG size: 48px height, 16px vertical padding)
- **Type**: `password` (with toggle to `text`)
- **Placeholder**: "Create a password"
- **Autocomplete**: `new-password`
- **Password Visibility Toggle**: Same as login page

#### Password Strength Indicator

**Visual Design**:
- **Position**: Below password input, 8px (0.5rem) margin top
- **Bar**: Horizontal progress bar showing strength level
- **Width**: 100% of container
- **Height**: 4px
- **Border Radius**: Full (9999px)
- **Background**: Pale Celadon (#A8C4B5) at 30% opacity
- **Fill Colors**:
  - Weak: Error Red (#C73030)
  - Medium: Warning Orange (#D68500)
  - Strong: Success Green (#0D8F68)
- **Text**: "Password Strength: [Bar] Weak/Medium/Strong"
- **Font**: Inter, 12px (0.75rem), Regular 400, Slate (#5C6C62)
- **Spacing**: 4px (0.25rem) between bar and text

**Strength Levels**:
- **Weak**: 0-2 requirements met
- **Medium**: 3 requirements met
- **Strong**: 4 requirements met

#### Password Requirements List

**Visual Design**:
- **Position**: Below password strength indicator, 8px (0.5rem) margin top
- **List Style**: None (no bullets)
- **Font**: Inter, 12px (0.75rem), Regular 400
- **Line Height**: 1.5
- **Spacing**: 4px (0.25rem) between items

**Requirement Items**:
- **Met**: Checkmark (✓) in Success Green (#0D8F68), text in Charcoal (#1F2421)
- **Unmet**: X (✗) in Slate (#5C6C62), text in Slate (#5C6C62)
- **Icon Spacing**: 8px (0.5rem) between icon and text

**Requirements**:
1. 8-30 characters
2. Uppercase and lowercase letters
3. At least one number
4. At least one special character

#### Terms of Service Checkbox

- **Type**: `checkbox`
- **Size**: 20px × 20px
- **Border**: 2px solid Pale Celadon (#A8C4B5)
- **Border Radius**: 4px (0.25rem) - SM per Design System
- **Checked State**: Background Celadon Green (#6E9180) per Design System Checkbox spec, white checkmark
- **Label**: "I agree to the Terms of Service and Privacy Policy"
- **Label Font**: Inter, 14px (0.875rem), Regular 400, Charcoal (#1F2421)
- **Label Link**: "Terms of Service" and "Privacy Policy" are clickable links in Celadon Green (#6E9180)
- **Spacing**: 8px (0.5rem) between checkbox and label
- **Required**: Must be checked to submit form

#### Create Account Button

- Same specifications as login page Sign In button
- **Text**: "Create Account"
- **Loading State**: "Creating account..." or spinner

### Links

#### Sign In Link

- **Text**: "Sign in"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Hover**: Underline, color darkens to Celadon Dark (#527563)
- **Position**: Inline with "Already have an account?" text

---

## Error States

### Invalid Email Format

- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Please enter a valid email address"
- **Position**: Below email input, 8px (0.5rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030)

### Email Already Exists

- **Error Message**: Below email input
- **Text**: "⚠️ This email is already registered. [Sign in] instead?"
- **Styling**: Same as Common Error Message Pattern
- **Link**: "Sign in" is clickable, Celadon Green (#6E9180)

### Weak Password

- **Error Message**: Below password requirements
- **Text**: "⚠️ Password does not meet all requirements"
- **Styling**: Same as Common Error Message Pattern
- **Shown**: On form submit if password is weak

### Terms Not Accepted

- **Error Message**: Below checkbox
- **Text**: "⚠️ You must agree to the Terms of Service and Privacy Policy"
- **Styling**: Same as Common Error Message Pattern
- **Shown**: On form submit if checkbox unchecked

### Field Validation Errors

**Empty Required Fields** (on submit):
- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Email is required" or "Password is required"
- **Position**: Below input field, 8px (0.5rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030)

---

## Interaction & Behavior

### Form Submission

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Creating account..." or spinner replaces text
   - Button disabled during submission
   - Form inputs disabled during submission

2. **Success Flow**:
   - Form submits
   - Redirect to email verification confirmation page
   - Flash message: "Account created! Please check your email to verify your account."

3. **Error Flow**:
   - Error messages appear below relevant fields
   - Inputs maintain entered values
   - Focus returns to first error field
   - Error messages persist until form is resubmitted or fields are changed

### Password Strength Indicator

- **Real-time Updates**: Updates as user types
- **Visual Feedback**: Bar color and text change based on requirements met
- **Requirements Check**: Each requirement updates from ✗ to ✓ as it's met
- **No JavaScript**: Falls back gracefully if JS disabled (requirements still shown)

### Password Visibility Toggle

- Same behavior as login page
- **Default**: Password hidden (dots/bullets)
- **Click Toggle**: Password revealed as plain text
- **Icon Changes**: Eye → Eye-slash (or vice versa)

### Terms Checkbox

- **Default**: Unchecked
- **Required**: Form cannot submit if unchecked
- **Links**: "Terms of Service" and "Privacy Policy" open in new tab
- **Accessibility**: Proper label association

### Keyboard Navigation

- **Tab Order**: Email → Password → Terms Checkbox → Create Account → Sign In
- **Enter Key**: Submits form when focus is on any input or button
- **Focus Indicators**: 2px solid Celadon Green (#6E9180) outline with 2px offset

### Link Behavior

- **Sign In**: Navigates to `/login`
- **Terms of Service**: Navigates to `/terms` (opens in new tab)
- **Privacy Policy**: Navigates to `/privacy` (opens in new tab)

---

## Responsive Breakpoints

- **Mobile**: 320px - 767px
  - Full-width container with 24px padding
  - Stacked layout (no side-by-side elements)
  - Touch-friendly targets (48px minimum height)
  - Larger text for readability

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
- **Enter Key**: Submits form from any input field

### Screen Readers

- **Form Labels**: Properly associated with inputs using `for` attribute
- **Error Messages**: Associated with inputs using `aria-describedby`
- **Password Requirements**: Announced to screen readers
- **Terms Checkbox**: Properly labeled with accessible link text
- **Password Toggle**: `aria-label="Toggle password visibility"` and `aria-pressed` state

### Visual Accessibility

- **Color Contrast**: All text meets WCAG AA (4.5:1 minimum)
- **Focus States**: Visible 2px outline, never rely on color alone
- **Error States**: Use both color and icon/text, not just color
- **Touch Targets**: Minimum 44×44px (48px implemented)

### Form Validation

- **Real-time Validation**: On blur for email format, on input for password strength
- **Submit Validation**: All required fields checked on submit
- **Error Announcements**: Screen readers announce errors via `aria-live` region

---

## Performance Considerations

- **Form Pre-fill**: Browser autocomplete enabled for email
- **No JavaScript Required**: Form works without JS (progressive enhancement)
- **Fast Submission**: Minimal client-side validation, server handles most checks
- **Loading States**: Visual feedback during submission (spinner, disabled state)

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
- **Warning**: Warning Orange (#D68500)
- **Background**: White (#FFFFFF) for form, Misty White (#F8FAF9) for page

### Spacing

- **Container Padding**: 24px (1.5rem) on mobile, 32px (2rem) on desktop
- **Form Field Spacing**: 24px (1.5rem) between fields
- **Button Top Margin**: 32px (2rem) from last field
- **Password Strength Spacing**: 8px (0.5rem) below password input
- **Requirements List Spacing**: 8px (0.5rem) below strength indicator

### Typography

- **Font Family**: Inter (Google Fonts)
- **Heading**: H1 (48px/3rem, Bold 700)
- **Subheading**: Body Large (18px/1.125rem, Regular 400)
- **Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body**: Body (16px/1rem, Regular 400)
- **Small Text**: Tiny (12px/0.75rem, Regular 400) for requirements and strength indicator

---

## Finalized Design Decisions

1. ✅ **Password Strength Indicator**: Real-time visual feedback with progress bar and requirements checklist
   - Helps users create secure passwords
   - Clear visual feedback on requirements

2. ✅ **Terms Checkbox**: Required acceptance with clickable links
   - Legal compliance
   - Clear, accessible implementation

3. ✅ **Progressive Enhancement**: Form works without JavaScript
   - Accessibility and reliability
   - Enhanced experience with JS

4. ✅ **Error Handling**: Inline errors below form fields
   - Clear, actionable error messages
   - Visual distinction (red border, error background)

5. ✅ **Mobile-First**: Full-width on mobile, centered on desktop
   - Touch-friendly targets (48px minimum)
   - Responsive typography and spacing

---

**Status**: Finalized ✓
**Date**: 2025-11-06
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`, reusing shared components from `login.md`.

