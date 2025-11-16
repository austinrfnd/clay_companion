# Password Reset Page - Wireframe

**URL**: `claycompanion.com/reset-password` (request) and `claycompanion.com/reset-password/edit?token=...` (reset form)

**Purpose**: Allow artists to reset their forgotten passwords via email token

**Reference Implementation**: See `requirements/wireframes/auth/password-reset-preview.html` for a complete HTML/CSS reference implementation that matches this wireframe exactly.

---

## Key Design Decisions

1. **Two-Step Flow**: Request page (enter email) and Reset page (enter new password with token)
2. **Centered Layout**: Narrow container (600px max-width) for focused experience
3. **Clear Instructions**: Helpful text explaining the process
4. **Success Confirmation**: Clear confirmation after email sent
5. **Security**: Token-based reset for secure password updates

---

## Shared Components

This page uses the same **Platform Header**, **Platform Footer**, **Auth Page Container**, **CSS Variables/Tokens**, **Common Form Input Pattern**, **Common Button Pattern**, **Common Link Pattern**, **Common Error Message Pattern**, and **Common Success Message Pattern** as defined in `login.md`. Refer to that document for complete specifications.

---

## Step 1: Request Password Reset (Desktop Layout)

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
│  │                        Reset Your Password                           │   │
│  │          Enter your email and we'll send you reset instructions     │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ Email Address                                                  │   │   │
│  │  │ ┌─────────────────────────────────────────────────────────┐   │   │   │
│  │  │ │ artist@example.com                                       │   │   │   │
│  │  │ └─────────────────────────────────────────────────────────┘   │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Send Reset Instructions]                  │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Remember your password? [Sign in]                                   │   │
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

## Step 1: Success Confirmation (After Email Sent)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                        Check Your Email                              │   │
│  │                                                                       │   │
│  │  We've sent password reset instructions to artist@example.com        │   │
│  │                                                                       │   │
│  │  Please check your email and click the link to reset your password. │   │
│  │  The link will expire in 1 hour.                                     │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Resend Email]                              │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Didn't receive the email? Check your spam folder or                 │   │
│  │  [try a different email address]                                      │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
```

---

## Step 2: Reset Password Form (With Token)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                        Create New Password                           │   │
│  │              Enter your new password below                           │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ New Password                                                  │   │   │
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
│  │  │ Confirm New Password                                          │   │   │
│  │  │ ┌─────────────────────────────────────────────────────────┐   │   │   │
│  │  │ │ ••••••••••••••••                              [👁️]    │   │   │   │
│  │  │ └─────────────────────────────────────────────────────────┘   │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Reset Password]                            │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
```

---

## Layout Specifications

### Container

- **Desktop**: 600px max-width, centered with auto margins
- **Tablet**: 90% max-width (540px-600px), centered
- **Mobile**: Full width with 24px (1.5rem) horizontal padding
- **Vertical Spacing**: 80px top margin on desktop, 40px on mobile

### Typography

- **Heading**: H1 (48px/3rem, Bold 700) - "Reset Your Password" or "Create New Password"
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - Instructions
- **Form Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body Text**: Body (16px/1rem, Regular 400)
- **Links**: Body (16px/1rem, Regular 400) in Celadon Green (#6E9180)

### Form Elements

#### Email Input (Step 1)

- Same specifications as login page (LG size: 48px height, 16px vertical padding)
- **Type**: `email`
- **Placeholder**: "artist@example.com"
- **Autocomplete**: `email`

#### Password Inputs (Step 2)

- Same specifications as signup page
- **New Password**: Same as signup password field with strength indicator
- **Confirm Password**: Same styling, no strength indicator
- **Password Visibility Toggle**: Same as login/signup pages

#### Send Reset Instructions Button

- Same specifications as login page Sign In button
- **Text**: "Send Reset Instructions"
- **Loading State**: "Sending..." or spinner

#### Reset Password Button

- Same specifications as login page Sign In button
- **Text**: "Reset Password"
- **Loading State**: "Resetting password..." or spinner

### Links

#### Sign In Link

- **Text**: "Sign in"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Hover**: Underline, color darkens to Celadon Dark (#527563)
- **Position**: Inline with "Remember your password?" text

#### Resend Email Button

- **Style**: Secondary button (outline style)
- **Text**: "Resend Email"
- **Background**: White, border Celadon Dark (#527563), text Celadon Dark
- **Hover**: Light Celadon background (10% opacity)

#### Try Different Email Link

- **Text**: "try a different email address"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Hover**: Underline

---

## Error States

### Invalid Email Format

- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Please enter a valid email address"
- **Position**: Below email input, 8px (0.5rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030)

### Email Not Found

- **Error Message**: Below email input
- **Text**: "⚠️ We couldn't find an account with that email address"
- **Styling**: Same as Common Error Message Pattern

### Invalid or Expired Token

- **Error Message**: Full-width message at top of form
- **Text**: "⚠️ This password reset link is invalid or has expired. Please request a new one."
- **Styling**: Same as Common Error Message Pattern
- **Action**: Link to request new reset

### Passwords Don't Match

- **Error Message**: Below confirm password input
- **Text**: "⚠️ Passwords do not match"
- **Styling**: Same as Common Error Message Pattern
- **Shown**: On blur of confirm password field or form submit

### Weak Password

- Same as signup page - password strength requirements not met

### Field Validation Errors

**Empty Required Fields** (on submit):
- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Email is required" or "Password is required"
- **Position**: Below input field, 8px (0.5rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030)

---

## Success States

### Email Sent Confirmation

**Visual Design**:
- **Container**: Success message container (per Common Success Message Pattern)
- **Icon**: Checkmark (✓)
- **Text**: "✓ We've sent password reset instructions to [email]"
- **Additional Text**: "Please check your email and click the link to reset your password. The link will expire in 1 hour."
- **Button**: "Resend Email" (secondary style)
- **Link**: "Didn't receive the email? Check your spam folder or [try a different email address]"

### Password Reset Success

- **Redirect**: To login page with success flash message
- **Flash Message**: "✓ Your password has been reset successfully. Please sign in with your new password."

---

## Interaction & Behavior

### Step 1: Request Reset

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Sending..." or spinner replaces text
   - Button disabled during submission
   - Form input disabled during submission

2. **Success Flow**:
   - Form submits
   - Show success confirmation page
   - Email sent (simulated in preview)

3. **Error Flow**:
   - Error message appears below email field
   - Input maintains entered value
   - Focus returns to email input
   - Error message persists until form is resubmitted or field is changed

### Step 2: Reset Password

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Resetting password..." or spinner replaces text
   - Button disabled during submission
   - Form inputs disabled during submission

2. **Success Flow**:
   - Form submits
   - Redirect to login page
   - Flash message: "Your password has been reset successfully"

3. **Error Flow**:
   - Error messages appear below relevant fields
   - Inputs maintain entered values
   - Focus returns to first error field
   - Error messages persist until form is resubmitted or fields are changed

### Password Matching Validation

- **Real-time Check**: On blur of confirm password field
- **Visual Feedback**: Error message if passwords don't match
- **Clear on Match**: Error clears when passwords match

### Password Strength Indicator

- Same behavior as signup page
- **Real-time Updates**: Updates as user types
- **Visual Feedback**: Bar color and text change based on requirements met

### Password Visibility Toggle

- Same behavior as login/signup pages
- **Default**: Password hidden (dots/bullets)
- **Click Toggle**: Password revealed as plain text
- **Icon Changes**: Eye → Eye-slash (or vice versa)

### Resend Email

- **Action**: Resends password reset email
- **Confirmation**: "Reset instructions sent again. Please check your email."
- **Rate Limiting**: May show message if requested too frequently

### Keyboard Navigation

- **Tab Order**: Email → Send Button → Sign In (Step 1) or New Password → Confirm Password → Reset Button (Step 2)
- **Enter Key**: Submits form when focus is on any input or button
- **Focus Indicators**: 2px solid Celadon Green (#6E9180) outline with 2px offset

### Link Behavior

- **Sign In**: Navigates to `/login`
- **Try Different Email**: Returns to Step 1 form
- **Resend Email**: Resends reset email

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
- **Password Toggle**: `aria-label="Toggle password visibility"` and `aria-pressed` state
- **Success Messages**: Announced via `aria-live` region

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
- **Secondary Button**: White background, Celadon Dark border/text
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

1. ✅ **Two-Step Flow**: Separate request and reset pages for clarity
   - Clear separation of concerns
   - Better security (token-based reset)

2. ✅ **Password Strength Indicator**: Same as signup page for consistency
   - Users familiar with the pattern
   - Ensures secure passwords

3. ✅ **Success Confirmation**: Clear confirmation after email sent
   - Reduces user anxiety
   - Provides next steps

4. ✅ **Error Handling**: Inline errors below form fields
   - Clear, actionable error messages
   - Visual distinction (red border, error background)

5. ✅ **Mobile-First**: Full-width on mobile, centered on desktop
   - Touch-friendly targets (48px minimum)
   - Responsive typography and spacing

---

**Status**: Finalized ✓
**Date**: 2025-11-06
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`, reusing shared components from `login.md` and password strength patterns from `signup.md`.

