# Email Confirmation - Wireframe

**Email Subject**: "Confirmation instructions" (or "Verify your Clay Companion account")

**Purpose**: Welcome new artists and provide email verification link to activate their account

**Reference Implementation**: See `requirements/wireframes/auth/email-confirmation-preview.html` for a complete HTML/CSS email template that matches this wireframe exactly.

---

## Key Design Decisions

1. **Branded HTML Email**: Clean, minimal design matching website aesthetic with design system colors
2. **Clear CTA**: Prominent verification button with clear call-to-action
3. **Logo Integration**: Ceramic "C" logo in header for brand recognition
4. **Email Client Compatibility**: Table-based layout with inline CSS for maximum compatibility
5. **Mobile Responsive**: Optimized for mobile email clients (Gmail, Apple Mail, Outlook)
6. **Accessibility**: WCAG AA compliant colors, clear link styling, alt text for images

---

## Email Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  [Ceramic C Logo]  Clay Companion                             │
│  (Header - White background, logo + text)                    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                                                               │
│  Welcome to Clay Companion!                                  │
│                                                               │
│  You're one step away from managing your ceramic portfolio.  │
│  Please confirm your email address to activate your account. │
│                                                               │
│  Email: artist@example.com                                   │
│                                                               │
│  ┌─────────────────────────────────────────────────────┐   │
│  │     [Confirm my account]                             │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                               │
│  Or copy and paste this link into your browser:              │
│  https://claycompanion.com/email/verify/abc123...          │
│                                                               │
│  This link will expire in 24 hours.                          │
│                                                               │
│  If you didn't create an account, you can safely ignore      │
│  this email.                                                 │
│                                                               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  Need help? Contact us at support@claycompanion.com         │
│  © 2025 Clay Companion. All rights reserved.                 │
│  (Footer - Light grey background)                            │
└─────────────────────────────────────────────────────────────┘
```

---

## Content Sections

### Header Section

**Specifications**:
- **Background**: White (#FFFFFF)
- **Padding**: 24px (1.5rem) vertical, 32px (2rem) horizontal
- **Border**: 1px solid rgba(168, 196, 181, 0.3) on bottom
- **Layout**: Table-based, centered content

**Logo**:
- **Image**: Ceramic "C" logo (placeholder: [C logo image])
- **Size**: 32px height (maintains aspect ratio)
- **Alt Text**: "Clay Companion"
- **Link**: Links to homepage (https://claycompanion.com)
- **Alignment**: Left-aligned in header

**Brand Text**:
- **Text**: "Clay Companion" (next to logo)
- **Font**: Inter, 20px (1.25rem), Semibold 600
- **Color**: Charcoal (#1F2421)
- **Fallback**: Arial, Helvetica, sans-serif

### Body Section

**Container**:
- **Max Width**: 600px
- **Background**: White (#FFFFFF)
- **Padding**: 32px (2rem) horizontal, 24px (1.5rem) vertical
- **Centered**: Auto margins

**Greeting**:
- **Text**: "Welcome to Clay Companion!"
- **Font**: Inter, 24px (1.5rem), Semibold 600 (H4 per Design System)
- **Color**: Charcoal (#1F2421)
- **Margin Bottom**: 16px (1rem)

**Main Message**:
- **Text**: "You're one step away from managing your ceramic portfolio. Please confirm your email address to activate your account."
- **Font**: Inter, 16px (1rem), Regular 400 (Body per Design System)
- **Color**: Charcoal (#1F2421)
- **Line Height**: 1.6
- **Margin Bottom**: 24px (1.5rem)

**Email Display**:
- **Label**: "Email:"
- **Email Value**: Dynamic (`@email` variable)
- **Font**: Inter, 16px (1rem), Regular 400
- **Color**: Slate (#5C6C62) for label, Charcoal (#1F2421) for email
- **Margin Bottom**: 32px (2rem)

**Call-to-Action Button**:
- **Text**: "Confirm my account"
- **Background**: Celadon Dark (#527563) - WCAG AA compliant
- **Text Color**: White (#FFFFFF)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Padding**: 12px (0.75rem) vertical, 24px (1.5rem) horizontal
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Border**: None
- **Width**: Full width of container (max 600px)
- **Display**: Block-level button (table cell with padding)
- **Link**: Dynamic confirmation URL (`confirmation_url(@resource, confirmation_token: @token)`)
- **Margin**: 32px (2rem) top and bottom
- **Text Alignment**: Center

**Alternative Link Text**:
- **Text**: "Or copy and paste this link into your browser:"
- **Font**: Inter, 14px (0.875rem), Regular 400 (Small per Design System)
- **Color**: Slate (#5C6C62)
- **Margin Top**: 24px (1.5rem)
- **Margin Bottom**: 8px (0.5rem)

**Confirmation URL**:
- **Text**: Full confirmation URL (wrapped, breakable)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Color**: Celadon Green (#6E9180)
- **Text Decoration**: Underline
- **Word Break**: break-all (for long URLs)
- **Margin Bottom**: 24px (1.5rem)

**Expiry Notice**:
- **Text**: "This link will expire in 24 hours."
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Color**: Slate (#5C6C62)
- **Margin Bottom**: 24px (1.5rem)

**Security Notice**:
- **Text**: "If you didn't create an account, you can safely ignore this email."
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Color**: Slate (#5C6C62)
- **Margin Top**: 24px (1.5rem)

### Footer Section

**Specifications**:
- **Background**: Misty White (#F8FAF9)
- **Padding**: 24px (1.5rem) all sides
- **Text Alignment**: Center
- **Border**: 1px solid rgba(168, 196, 181, 0.3) on top

**Support Link**:
- **Text**: "Need help? Contact us at support@claycompanion.com"
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Color**: Slate (#5C6C62)
- **Email Link**: Celadon Green (#6E9180), underline
- **Margin Bottom**: 16px (1rem)

**Copyright**:
- **Text**: "© 2025 Clay Companion. All rights reserved."
- **Font**: Inter, 12px (0.75rem), Regular 400 (Tiny per Design System)
- **Color**: Slate (#5C6C62)

---

## Email-Specific Considerations

### Inline CSS Requirements

All styles must be inline for email client compatibility:
- No external stylesheets
- No `<style>` tags in `<head>` (some clients strip them)
- All styles applied directly to elements via `style` attribute
- Table-based layout for structure

### Email Client Compatibility

**Supported Clients**:
- Gmail (web, iOS, Android)
- Apple Mail (macOS, iOS)
- Outlook (Windows, web, Mac)
- Yahoo Mail
- Other major email clients

**Compatibility Notes**:
- Use table-based layout for structure
- Avoid CSS Grid and Flexbox (limited support)
- Use `align` and `valign` attributes on table cells
- Test background colors (some clients strip them)
- Use web-safe fonts with fallbacks

### Mobile Responsiveness

**Mobile Email Client Considerations**:
- Max width: 600px (standard email width)
- Text size: Minimum 14px for readability
- Button size: Minimum 44px height (touch target)
- Padding: Adequate spacing for touch
- Single column layout (no side-by-side elements)

**Responsive Techniques**:
- Use `max-width` on table containers
- Use percentage widths for flexible elements
- Avoid fixed pixel widths where possible
- Test on mobile email clients

### Accessibility

**Color Contrast**:
- All text meets WCAG AA (4.5:1 minimum)
- Celadon Dark (#527563) on White: 4.5:1 ✅
- Charcoal (#1F2421) on White: 15.2:1 ✅
- Slate (#5C6C62) on White: 7.1:1 ✅

**Link Styling**:
- Links clearly styled (Celadon Green, underline)
- Button links have sufficient contrast
- Link text is descriptive ("Confirm my account" not "Click here")

**Image Alt Text**:
- Logo has descriptive alt text: "Clay Companion"
- Images are decorative or have meaningful alt text

---

## CSS Variables/Tokens (Reference)

For implementation reference, these are the design system tokens:

```css
/* Design System Colors */
--celadon-green: #6E9180;
--celadon-dark: #527563;
--charcoal: #1F2421;
--slate: #5C6C62;
--pale-celadon: #A8C4B5;
--misty-white: #F8FAF9;
--white: #FFFFFF;
```

**Note**: In email templates, these must be converted to inline styles with hex values.

---

## Typography Specifications

**Headings**:
- **H4 (Email Title)**: 24px (1.5rem), Semibold 600, Charcoal (#1F2421)
- **Font Stack**: Inter, Arial, Helvetica, sans-serif

**Body Text**:
- **Body**: 16px (1rem), Regular 400, Charcoal (#1F2421)
- **Small**: 14px (0.875rem), Regular 400, Slate (#5C6C62)
- **Tiny**: 12px (0.75rem), Regular 400, Slate (#5C6C62)

**Links**:
- **Color**: Celadon Green (#6E9180)
- **Text Decoration**: Underline
- **Hover**: Slightly darker (not applicable in email, but for reference)

**Buttons**:
- **Font**: Inter, 16px (1rem), Semibold 600
- **Color**: White (#FFFFFF) on Celadon Dark (#527563)

---

## Spacing Specifications

**Container Padding**:
- **Horizontal**: 32px (2rem)
- **Vertical**: 24px (1.5rem)

**Section Spacing**:
- **Between paragraphs**: 16px (1rem)
- **Between sections**: 24px (1.5rem)
- **Button margins**: 32px (2rem) top and bottom

**Header/Footer Padding**:
- **Header**: 24px (1.5rem) vertical, 32px (2rem) horizontal
- **Footer**: 24px (1.5rem) all sides

---

## Devise Variables

The email template will use these Devise-provided variables:

- `@email` - The email address being confirmed
- `@resource` - The Artist resource object
- `@token` - The confirmation token
- `confirmation_url(@resource, confirmation_token: @token)` - Helper method to generate confirmation URL

**Example Usage**:
```erb
<%= @email %>
<%= link_to 'Confirm my account', confirmation_url(@resource, confirmation_token: @token) %>
```

---

## Implementation Checklist

When implementing this email template:

### HTML Structure
- [ ] Table-based layout for email client compatibility
- [ ] Inline CSS for all styles
- [ ] Semantic HTML where possible
- [ ] Proper alt text for logo image

### Content
- [ ] Dynamic email address display
- [ ] Confirmation button with proper URL
- [ ] Alternative text link for confirmation URL
- [ ] Expiry notice (24 hours)
- [ ] Security notice for non-account creators

### Styling
- [ ] Design system colors (Celadon Green palette)
- [ ] Inter font with fallbacks
- [ ] Proper spacing (design system tokens)
- [ ] Button styling (Celadon Dark background, white text)
- [ ] Link styling (Celadon Green, underline)

### Email Client Compatibility
- [ ] Test in Gmail (web, mobile)
- [ ] Test in Apple Mail
- [ ] Test in Outlook
- [ ] Verify table-based layout works
- [ ] Verify inline CSS works
- [ ] Test on mobile email clients

### Accessibility
- [ ] Color contrast meets WCAG AA (4.5:1)
- [ ] Descriptive link text
- [ ] Alt text for images
- [ ] Clear button labels

### Testing
- [ ] Test with letter_opener in development
- [ ] Verify confirmation link works
- [ ] Test email rendering in multiple clients
- [ ] Verify mobile responsiveness

---

## Reference Files

- **HTML/CSS Reference**: `requirements/wireframes/auth/email-confirmation-preview.html` - Complete working email template
- **Design System**: `requirements/DESIGN_SYSTEM.md` - Full design token specifications
- **Existing Template**: `app/views/devise/mailer/confirmation_instructions.html.erb` - Current Devise template
- **Auth Development Plan**: `requirements/auth/auth-development-plan.md` - Phase 6 details

---

## Design System Compliance

This email wireframe has been verified to align with specifications in `requirements/DESIGN_SYSTEM.md`:

- ✅ Color palette and usage guidelines (Celadon Green scheme)
- ✅ Typography scale and font weights (Inter font family)
- ✅ Spacing scale (4px base unit)
- ✅ Button specifications (Celadon Dark, 8px border radius)
- ✅ Link styling (Celadon Green, underline)
- ✅ Accessibility requirements (WCAG AA color contrast)

---

**Status**: Finalized ✓
**Date**: 2025-11-16
**Last Updated**: 2025-11-16

