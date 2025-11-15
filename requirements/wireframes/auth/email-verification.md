# Email Verification Page - Wireframe

**URL**: `claycompanion.com/verify-email` (confirmation page) and `claycompanion.com/verify-email/confirm?token=...` (verification link)

**Purpose**: Confirm email addresses for new artist accounts and handle email verification flow

**Reference Implementation**: See `requirements/wireframes/auth/email-verification-preview.html` for a complete HTML/CSS reference implementation that matches this wireframe exactly.

---

## Key Design Decisions

1. **Confirmation-Focused**: Clear success/error states with helpful messaging
2. **Centered Layout**: Narrow container (600px max-width) for focused experience
3. **Clear Instructions**: Helpful text explaining next steps
4. **Resend Option**: Easy way to resend verification email if needed
5. **Minimal Interaction**: Mostly informational with clear CTAs

---

## Shared Components

This page uses the same **Platform Header**, **Platform Footer**, **Auth Page Container**, **CSS Variables/Tokens**, **Common Button Pattern**, **Common Link Pattern**, **Common Error Message Pattern**, and **Common Success Message Pattern** as defined in `login.md`. Refer to that document for complete specifications.

---

## State 1: Verification Sent (After Signup)

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
│  │                    Verify Your Email Address                         │   │
│  │                                                                       │   │
│  │  ✓ We've sent a verification email to artist@example.com             │   │
│  │                                                                       │   │
│  │  Please check your email and click the verification link to           │   │
│  │  activate your account. The link will expire in 24 hours.           │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Resend Verification Email]                │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Didn't receive the email? Check your spam folder or                 │   │
│  │  [try a different email address]                                      │   │
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

## State 2: Verification Success (After Clicking Link)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                    Email Verified Successfully                       │   │
│  │                                                                       │   │
│  │  ✓ Your email address has been verified!                             │   │
│  │                                                                       │   │
│  │  You can now access all features of your account.                   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Continue to Dashboard]                    │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
```

---

## State 3: Verification Error (Invalid/Expired Token)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                    Verification Link Invalid                         │   │
│  │                                                                       │   │
│  │  ⚠️ This verification link is invalid or has expired.                 │   │
│  │                                                                       │   │
│  │  Verification links expire after 24 hours for security reasons.      │   │
│  │  Please request a new verification email.                            │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Resend Verification Email]                │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Already verified? [Sign in]                                         │   │
│  │                                                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
```

---

## State 4: Already Verified

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                       │   │
│  │                    Email Already Verified                            │   │
│  │                                                                       │   │
│  │  ✓ This email address has already been verified.                     │   │
│  │                                                                       │   │
│  │  You can access your account by signing in.                          │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                        [Sign In]                              │   │   │
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

- **Heading**: H1 (48px/3rem, Bold 700) - "Verify Your Email Address" or state-specific heading
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - Instructions (when needed)
- **Body Text**: Body (16px/1rem, Regular 400)
- **Links**: Body (16px/1rem, Regular 400) in Celadon Green (#6E9180)

### Success Message Container

**Visual Design**:
- **Padding**: 12px (0.75rem) all sides
- **Background**: rgba(13, 143, 104, 0.1) - 10% opacity Success Green
- **Border**: 1px solid Success Green (#0D8F68)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Color**: Success Green (#0D8F68)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Line Height**: 1.5
- **Icon**: Checkmark (✓) before text
- **Margin**: 24px (1.5rem) below heading

### Error Message Container

**Visual Design**:
- **Padding**: 12px (0.75rem) all sides
- **Background**: rgba(199, 48, 48, 0.1) - 10% opacity Error Red
- **Border**: 1px solid Error Red (#C73030)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Color**: Error Red (#C73030)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Line Height**: 1.5
- **Icon**: Warning emoji (⚠️) before text
- **Margin**: 24px (1.5rem) below heading

### Buttons

#### Primary Button (Continue to Dashboard, Sign In)

- Same specifications as login page Sign In button
- **Text**: "Continue to Dashboard" or "Sign In"
- **Loading State**: "Loading..." or spinner

#### Secondary Button (Resend Email)

- **Style**: Secondary button (outline style)
- **Text**: "Resend Verification Email"
- **Background**: White, border Celadon Dark (#527563), text Celadon Dark
- **Hover**: Light Celadon background (10% opacity)
- **Loading State**: "Sending..." or spinner

### Links

#### Try Different Email Link

- **Text**: "try a different email address"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Hover**: Underline

#### Sign In Link

- **Text**: "Sign in"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Hover**: Underline, color darkens to Celadon Dark (#527563)
- **Position**: Inline with "Already verified?" text

---

## Error States

### Invalid or Expired Token

- **Error Message**: Full-width message container
- **Text**: "⚠️ This verification link is invalid or has expired."
- **Additional Text**: "Verification links expire after 24 hours for security reasons. Please request a new verification email."
- **Styling**: Same as Common Error Message Pattern
- **Action**: "Resend Verification Email" button

### Email Not Found

- **Error Message**: Full-width message container
- **Text**: "⚠️ We couldn't find an account with that email address"
- **Styling**: Same as Common Error Message Pattern

---

## Success States

### Email Sent Confirmation

**Visual Design**:
- **Container**: Success message container (per Common Success Message Pattern)
- **Icon**: Checkmark (✓)
- **Text**: "✓ We've sent a verification email to [email]"
- **Additional Text**: "Please check your email and click the verification link to activate your account. The link will expire in 24 hours."
- **Button**: "Resend Verification Email" (secondary style)
- **Link**: "Didn't receive the email? Check your spam folder or [try a different email address]"

### Email Verified Success

**Visual Design**:
- **Container**: Success message container (per Common Success Message Pattern)
- **Icon**: Checkmark (✓)
- **Text**: "✓ Your email address has been verified!"
- **Additional Text**: "You can now access all features of your account."
- **Button**: "Continue to Dashboard" (primary style)

### Already Verified

**Visual Design**:
- **Container**: Success message container (per Common Success Message Pattern)
- **Icon**: Checkmark (✓)
- **Text**: "✓ This email address has already been verified."
- **Additional Text**: "You can access your account by signing in."
- **Button**: "Sign In" (primary style)

---

## Interaction & Behavior

### Resend Verification Email

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Sending..." or spinner replaces text
   - Button disabled during submission

2. **Success Flow**:
   - Button resets to normal state
   - Success message: "Verification email sent again. Please check your email."
   - May show rate limiting message if requested too frequently

3. **Error Flow**:
   - Error message appears
   - Button resets to normal state

### Continue to Dashboard

- **Action**: Redirects to `/dashboard`
- **Only Available**: After successful verification

### Sign In

- **Action**: Navigates to `/login`
- **Available**: In error states or already verified state

### Try Different Email

- **Action**: Returns to signup page or allows email change
- **Context**: When email not received

### Keyboard Navigation

- **Tab Order**: Button → Links (logical flow)
- **Enter Key**: Activates button when focused
- **Focus Indicators**: 2px solid Celadon Green (#6E9180) outline with 2px offset

### Link Behavior

- **Sign In**: Navigates to `/login`
- **Try Different Email**: Returns to signup or email change form
- **Resend Email**: Resends verification email

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
  - Same layout as desktop

- **Desktop**: 1024px+
  - 600px max-width container, centered
  - Generous vertical spacing (80px top margin)
  - Optimal reading width

---

## Accessibility

### Keyboard Navigation

- **Tab Order**: Logical flow through all interactive elements
- **Focus Indicators**: Visible 2px outline in Celadon Green (#6E9180)
- **Enter Key**: Activates button when focused

### Screen Readers

- **Success Messages**: Announced via `aria-live` region
- **Error Messages**: Announced via `aria-live` region
- **Button Labels**: Descriptive text ("Resend Verification Email" not just "Resend")

### Visual Accessibility

- **Color Contrast**: All text meets WCAG AA (4.5:1 minimum)
- **Focus States**: Visible 2px outline, never rely on color alone
- **Error States**: Use both color and icon/text, not just color
- **Touch Targets**: Minimum 44×44px (48px implemented)

---

## Performance Considerations

- **No JavaScript Required**: Page works without JS (progressive enhancement)
- **Fast Loading**: Minimal content, quick to render
- **Loading States**: Visual feedback during button actions (spinner, disabled state)

---

## Design System Integration

### Colors Used

- **Primary Button**: Celadon Dark (#527563)
- **Secondary Button**: White background, Celadon Dark border/text
- **Links**: Celadon Green (#6E9180)
- **Text**: Charcoal (#1F2421) primary, Slate (#5C6C62) secondary
- **Success**: Success Green (#0D8F68)
- **Error**: Error Red (#C73030)
- **Background**: White (#FFFFFF) for form, Misty White (#F8FAF9) for page

### Spacing

- **Container Padding**: 24px (1.5rem) on mobile, 32px (2rem) on desktop
- **Message Container Margin**: 24px (1.5rem) below heading
- **Button Top Margin**: 32px (2rem) from last content
- **Link Spacing**: 16px (1rem) between related elements

### Typography

- **Font Family**: Inter (Google Fonts)
- **Heading**: H1 (48px/3rem, Bold 700)
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - when needed
- **Body**: Body (16px/1rem, Regular 400)
- **Message Text**: Small (14px/0.875rem, Regular 400)

---

## Finalized Design Decisions

1. ✅ **Multiple States**: Handles all verification scenarios clearly
   - Email sent confirmation
   - Verification success
   - Invalid/expired token
   - Already verified

2. ✅ **Clear Messaging**: Helpful instructions for each state
   - Reduces user confusion
   - Provides next steps

3. ✅ **Resend Option**: Easy way to request new verification email
   - Handles email delivery issues
   - User-friendly recovery path

4. ✅ **Minimal Interaction**: Mostly informational pages
   - Simple, focused experience
   - Clear CTAs for next steps

5. ✅ **Mobile-First**: Full-width on mobile, centered on desktop
   - Touch-friendly targets (48px minimum)
   - Responsive typography and spacing

---

**Status**: Finalized ✓
**Date**: 2025-11-06
**Design System Compliance**: This wireframe follows all specifications in `requirements/DESIGN_SYSTEM.md`, reusing shared components from `login.md`.

