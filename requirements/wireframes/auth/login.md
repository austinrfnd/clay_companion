# Login Page - Wireframe

**URL**: `claycompanion.com/login`

**Purpose**: Authenticate artists to access their dashboard and portfolio management tools

**Reference Implementation**: See `requirements/wireframes/auth/login-preview.html` for a complete HTML/CSS reference implementation that matches this wireframe exactly.

---

## Key Design Decisions

1. **Centered Layout**: Narrow container (600px max-width) for focused, distraction-free login
2. **Minimal Design**: Clean form with generous spacing, following gallery-like aesthetic
3. **Clear CTAs**: Primary login button, secondary links for password reset and signup
4. **Error Handling**: Inline validation with clear error messages
5. **Accessibility**: Full keyboard navigation, ARIA labels, visible focus states

---

## Shared Components (All Auth Pages)

The following components should be **identical across all authentication pages** (login, signup, password reset, email verification, profile setup):

### Platform Header

**Specifications**:
- **Background**: White (#FFFFFF)
- **Border**: 1px solid rgba(168, 196, 181, 0.3) on bottom
- **Padding**: 16px (1rem) vertical, 24px (1.5rem) horizontal
- **Max Width**: 1440px, centered with auto margins
- **Layout**: Flexbox, space-between alignment

**Logo**:
- **Text**: "Clay Companion"
- **Font**: Inter, 20px (1.25rem), Semibold 600
- **Color**: Charcoal (#1F2421)
- **Link**: Navigates to homepage

**Header Links** (Right Side):
- **Links**: "Sign Up", "Login" (or appropriate for current page)
- **Font**: Inter, 14px (0.875rem), Medium 500
- **Color**: Slate (#5C6C62) default
- **Hover**: Celadon Green (#6E9180) text, rgba(168, 196, 181, 0.1) background
- **Padding**: 8px (0.5rem) vertical, 16px (1rem) horizontal
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Gap**: 16px (1rem) between links
- **Transition**: 150ms ease - Fast transition per Design System

### Platform Footer

**Specifications**:
- **Background**: Misty White (#F8FAF9)
- **Border**: 1px solid rgba(168, 196, 181, 0.3) on top
- **Padding**: 24px (1.5rem) all sides
- **Text Alignment**: Center
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Color**: Slate (#5C6C62)

**Footer Links**:
- **Links**: "Contact", "About", "Terms", "Privacy"
- **Color**: Slate (#5C6C62) default
- **Hover**: Celadon Green (#6E9180)
- **Gap**: 16px (1rem) between links
- **Layout**: Flexbox, centered, wrap enabled
- **Margin Bottom**: 8px (0.5rem) before "Powered by" text

**Powered By Text**:
- **Text**: "Powered by Clay Companion"
- **Color**: Slate (#5C6C62)

### Auth Page Container

**Specifications** (Applies to all auth forms):
- **Max Width**: 600px (desktop), 90% (tablet), 100% (mobile)
- **Background**: White (#FFFFFF)
- **Border Radius**: 4px (0.25rem) - SM per Design System (default for cards)
- **Padding**: 48px (3rem) vertical, 32px (2rem) horizontal (desktop)
- **Padding Mobile**: 32px (2rem) vertical, 24px (1.5rem) horizontal
- **Centered**: Auto margins, flexbox centering
- **Vertical Spacing**: 80px (5rem) top margin (desktop), 40px (2.5rem) (mobile)

### CSS Variables/Tokens

Use these exact CSS custom properties for consistency:

```css
:root {
  --celadon-green: #6E9180;
  --celadon-dark: #527563;
  --charcoal: #1F2421;
  --slate: #5C6C62;
  --pale-celadon: #A8C4B5;
  --misty-white: #F8FAF9;
  --white: #FFFFFF;
  --error-red: #C73030;
  --success-green: #0D8F68;
  --warning-orange: #D68500;
  --info-blue: #2563EB;
}
```

### Common Form Input Pattern

**All text inputs** (email, password, text, etc.) should follow this pattern:

- **Height**: 48px (3rem) - LG size per Design System, minimum touch target
- **Padding**: 16px (1rem) vertical, 12px (0.75rem) horizontal - per Design System LG input specs
- **Font**: Inter, 16px (1rem), Regular 400
- **Color**: Charcoal (#1F2421)
- **Background**: White (#FFFFFF)
- **Border**: 1px solid Pale Celadon (#A8C4B5) - per Design System (50% opacity for default state)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Placeholder Color**: Slate at 60% opacity - per Design System
- **Hover**: Border becomes full opacity Pale Celadon (#A8C4B5)
- **Focus**: 2px solid Celadon Green (#6E9180), no outline
- **Error**: 2px solid Error Red (#C73030)
- **Transition**: 200ms ease for all state changes - Base transition per Design System

### Common Button Pattern

**Primary Buttons** (Submit, Sign In, Sign Up, etc.):

- **Width**: 100% of container
- **Height**: 48px (3rem) - minimum touch target
- **Background**: Celadon Dark (#527563)
- **Text Color**: White (#FFFFFF)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Border**: None
- **Border Radius**: 8px (0.5rem) - MD per Design System - MD
- **Shadow**: 0 1px 2px rgba(31, 36, 33, 0.05) - SM shadow per Design System
- **Hover**: Background #3f5a4d (darken by ~5%)
- **Active**: Background #2d3f35 (darken by ~10%), scale(0.98)
- **Focus**: 2px solid Celadon Green (#6E9180) outline with 2px offset
- **Disabled**: Pale Celadon (#A8C4B5) background, rgba(92, 108, 98, 0.5) text, cursor not-allowed
- **Transition**: 150ms ease - Fast transition per Design System

**Loading State**:
- Button text changes to "Signing in..." or shows spinner
- Button disabled during submission
- All form inputs disabled during submission

### Common Link Pattern

**Text Links** (Forgot password, Sign up, etc.):

- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 14px (0.875rem) or 16px (1rem) depending on context
- **Weight**: Regular 400 (or Semibold 600 for emphasis)
- **Text Decoration**: None (default)
- **Hover**: Underline, color darkens to Celadon Dark (#527563)
- **Transition**: 150ms ease - Fast transition per Design System

### Common Error Message Pattern

**Error Container** (Inline form errors):

- **Display**: Block (when visible)
- **Margin Top**: 8px (0.5rem) from input field
- **Padding**: 12px (0.75rem) all sides
- **Background**: rgba(199, 48, 48, 0.1) - 10% opacity Error Red
- **Border**: 1px solid Error Red (#C73030)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Color**: Error Red (#C73030)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Line Height**: 1.5
- **Icon**: Warning emoji (⚠️) or error icon before text

**Implementation Note**: This pattern should be created as a reusable component/helper. The app currently does not have an established error message pattern, so this wireframe defines the standard.

**Rails Helper Suggestion**:
```ruby
# app/helpers/application_helper.rb
def error_message(message, field_id: nil)
  content_tag :div, 
    class: "error-message mt-2 p-3 bg-error/10 border border-error rounded-md text-error text-sm",
    id: field_id ? "#{field_id}_error" : nil,
    role: "alert",
    aria: { live: "polite" } do
    "⚠️ #{message}".html_safe
  end
end
```

**Tailwind Classes** (for consistency):
- Container: `mt-2 p-3 bg-error/10 border border-error rounded-md text-error text-sm`
- Icon: Use emoji or SVG icon before text

### Common Success Message Pattern

**Success Container** (Flash messages, confirmations):

- **Display**: Block (when visible)
- **Margin**: Appropriate spacing from related content
- **Padding**: 12px (0.75rem) all sides
- **Background**: rgba(13, 143, 104, 0.1) - 10% opacity Success Green
- **Border**: 1px solid Success Green (#0D8F68)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Color**: Success Green (#0D8F68)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Line Height**: 1.5
- **Icon**: Checkmark (✓) or success icon before text

**Implementation Note**: This pattern should be created as a reusable component/helper for flash messages.

**Rails Helper Suggestion**:
```ruby
# app/helpers/application_helper.rb
def flash_message(type, message)
  return if message.blank?
  
  bg_color = case type.to_sym
             when :notice, :success then "bg-success/10 border-success text-success"
             when :alert, :error then "bg-error/10 border-error text-error"
             when :warning then "bg-warning/10 border-warning text-warning"
             when :info then "bg-info/10 border-info text-info"
             else "bg-slate/10 border-slate text-slate"
             end
  
  icon = case type.to_sym
         when :notice, :success then "✓"
         when :alert, :error then "⚠️"
         when :warning then "⚠️"
         when :info then "ℹ️"
         else ""
         end
  
  content_tag :div, 
    class: "flash-message p-3 border rounded-md text-sm #{bg_color}",
    role: "alert",
    aria: { live: "polite" } do
    "#{icon} #{message}".html_safe
  end
end
```

**Tailwind Classes**:
- Success: `p-3 bg-success/10 border border-success rounded-md text-success text-sm`
- Error: `p-3 bg-error/10 border border-error rounded-md text-error text-sm`
- Warning: `p-3 bg-warning/10 border border-warning rounded-md text-warning text-sm`
- Info: `p-3 bg-info/10 border border-info rounded-md text-info text-sm`

### Common Divider Pattern

**Horizontal Dividers** (between sections):

- **Height**: 1px
- **Background**: rgba(168, 196, 181, 0.3) - 30% opacity Pale Celadon
- **Border**: None
- **Margin**: 32px (2rem) vertical

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
│  │                            Welcome Back                              │   │
│  │                    Sign in to manage your portfolio                   │   │
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
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │ ☐ Remember me                                                  │   │   │
│  │  │                                                                 │   │   │
│  │  │                    [Forgot password?]                          │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ┌───────────────────────────────────────────────────────────────┐   │   │
│  │  │                    [Sign In]                                  │   │   │
│  │  └───────────────────────────────────────────────────────────────┘   │   │
│  │                                                                       │   │
│  │  ────────────────────────────────────────────────────────────────    │   │
│  │                                                                       │   │
│  │  Don't have an account? [Sign up]                                    │   │
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

```
┌────────────────────────────────────────────────────────┐
│  Clay Companion                    [Sign Up]  [Login]  │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                                                        │
│                    (Centered)                         │
│                                                        │
│  ┌──────────────────────────────────────────────┐    │
│  │                                               │    │
│  │              Welcome Back                     │    │
│  │      Sign in to manage your portfolio         │    │
│  │                                               │    │
│  │  ┌────────────────────────────────────────┐  │    │
│  │  │ Email Address                          │  │    │
│  │  │ ┌──────────────────────────────────┐  │  │    │
│  │  │ │ artist@example.com                │  │  │    │
│  │  │ └──────────────────────────────────┘  │  │    │
│  │  └────────────────────────────────────────┘  │    │
│  │                                               │    │
│  │  ┌────────────────────────────────────────┐  │    │
│  │  │ Password                                │  │    │
│  │  │ ┌──────────────────────────────────┐  │  │    │
│  │  │ │ ••••••••••••••          [👁️]     │  │  │    │
│  │  │ └──────────────────────────────────┘  │  │    │
│  │  └────────────────────────────────────────┘  │    │
│  │                                               │    │
│  │  ┌────────────────────────────────────────┐  │    │
│  │  │ ☐ Remember me                          │  │    │
│  │  │                                         │  │    │
│  │  │              [Forgot password?]         │  │    │
│  │  └────────────────────────────────────────┘  │    │
│  │                                               │    │
│  │  ┌────────────────────────────────────────┐  │    │
│  │  │            [Sign In]                    │  │    │
│  │  └────────────────────────────────────────┘  │    │
│  │                                               │    │
│  │  ─────────────────────────────────────────    │    │
│  │                                               │    │
│  │  Don't have an account? [Sign up]             │    │
│  │                                               │    │
│  └──────────────────────────────────────────────┘    │
│                                                        │
│  (Container: 90% max-width, centered)                  │
│                                                        │
└────────────────────────────────────────────────────────┘
```

---

## Mobile Layout (320px - 767px)

```
┌───────────────────────────────┐
│  Clay Companion      ☰ Menu   │
└───────────────────────────────┘

┌───────────────────────────────┐
│                               │
│        (Centered)             │
│                               │
│  ┌─────────────────────────┐ │
│  │                         │ │
│  │      Welcome Back       │ │
│  │  Sign in to manage     │ │
│  │    your portfolio      │ │
│  │                         │ │
│  │  ┌───────────────────┐ │ │
│  │  │ Email Address     │ │ │
│  │  │ ┌───────────────┐ │ │ │
│  │  │ │artist@example │ │ │ │
│  │  │ │.com           │ │ │ │
│  │  │ └───────────────┘ │ │ │
│  │  └───────────────────┘ │ │
│  │                         │ │
│  │  ┌───────────────────┐ │ │
│  │  │ Password          │ │ │
│  │  │ ┌───────────────┐ │ │ │
│  │  │ │•••••••• [👁️] │ │ │ │
│  │  │ └───────────────┘ │ │ │
│  │  └───────────────────┘ │ │
│  │                         │ │
│  │  ┌───────────────────┐ │ │
│  │  │ ☐ Remember me    │ │ │
│  │  │                   │ │ │
│  │  │ [Forgot password?]│ │ │
│  │  └───────────────────┘ │ │
│  │                         │ │
│  │  ┌───────────────────┐ │ │
│  │  │   [Sign In]       │ │ │
│  │  └───────────────────┘ │ │
│  │                         │ │
│  │  ────────────────────    │ │
│  │                         │ │
│  │  Don't have an account? │ │
│  │        [Sign up]        │ │
│  │                         │ │
│  └─────────────────────────┘ │
│                               │
│  (Full width with padding)     │
│                               │
└───────────────────────────────┘
```

---

## Layout Specifications

### Container

- **Desktop**: 600px max-width, centered with auto margins
- **Tablet**: 90% max-width (540px-600px), centered
- **Mobile**: Full width with 24px (1.5rem) horizontal padding
- **Vertical Spacing**: 80px top margin on desktop, 40px on mobile

### Typography

- **Heading**: H1 (48px/3rem, Bold 700) - "Welcome Back"
- **Subheading**: Body Large (18px/1.125rem, Regular 400) - "Sign in to manage your portfolio"
- **Form Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body Text**: Body (16px/1rem, Regular 400)
- **Links**: Body (16px/1rem, Regular 400) in Celadon Green (#6E9180)

### Form Elements

#### Email Input

- **Type**: `email`
- **Placeholder**: "artist@example.com"
- **Width**: 100% of container
- **Height**: 48px (3rem) - LG size per Design System, minimum touch target
- **Padding**: 12px (0.75rem) horizontal, 16px (1rem) vertical - per Design System LG input specs
- **Border**: 1px solid Pale Celadon (#A8C4B5) at 50% opacity
- **Border Radius**: 8px (0.5rem) - MD per Design System - MD
- **Focus State**: 2px solid Celadon Green (#6E9180)
- **Background**: White (#FFFFFF)
- **Font**: Inter, 16px (1rem)

#### Password Input

- **Type**: `password` (with toggle to `text`)
- **Placeholder**: "Enter your password"
- **Width**: 100% of container
- **Height**: 48px (3rem) - LG size per Design System
- **Padding**: 12px (0.75rem) horizontal, 16px (1rem) vertical - per Design System LG input specs
- **Padding Right**: 48px (3rem) to accommodate visibility toggle button
- **Border**: 1px solid Pale Celadon (#A8C4B5) at 50% opacity
- **Border Radius**: 8px (0.5rem) - MD per Design System - MD
- **Focus State**: 2px solid Celadon Green (#6E9180)
- **Background**: White (#FFFFFF)
- **Font**: Inter, 16px (1rem)

#### Password Visibility Toggle

- **Icon**: Eye (👁️) or eye-slash icon
- **Position**: Absolute, right side of password input
- **Size**: 20px × 20px
- **Padding**: 12px (0.75rem) - clickable area
- **Color**: Slate (#5C6C62) - secondary text color
- **Hover**: Celadon Green (#6E9180)
- **Accessibility**: `aria-label="Toggle password visibility"`

#### Remember Me Checkbox

- **Type**: `checkbox`
- **Size**: 20px × 20px
- **Border**: 2px solid Pale Celadon (#A8C4B5)
- **Border Radius**: 4px (0.25rem) - SM per Design System
- **Checked State**: Background Celadon Green (#6E9180) per Design System Checkbox spec, white checkmark
- **Label**: "Remember me" - clickable, 16px (1rem) Body size per Design System, Slate (#5C6C62)
- **Spacing**: 8px (0.5rem) between checkbox and label

#### Sign In Button

- **Type**: `submit`
- **Width**: 100% of container
- **Height**: 48px (3rem) - minimum touch target
- **Background**: Celadon Dark (#527563) - WCAG AA compliant
- **Text Color**: White (#FFFFFF)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Border Radius**: 8px (0.5rem) - MD per Design System - MD
- **Shadow**: SM (0 1px 2px rgba(31, 36, 33, 0.05))
- **Hover State**: Slightly darker (reduce brightness by 5%)
- **Active State**: Pressed effect (reduce brightness by 10%)
- **Focus State**: 2px solid Celadon Green (#6E9180) with 2px outline offset
- **Disabled State**: Pale Celadon (#A8C4B5) background, cursor not-allowed

### Links

#### Forgot Password Link

- **Text**: "Forgot password?"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Hover**: Underline, color darkens slightly
- **Position**: Right-aligned in same row as "Remember me"
- **Spacing**: 16px (1rem) from checkbox row

#### Sign Up Link

- **Text**: "Sign up"
- **Color**: Celadon Green (#6E9180)
- **Font**: Inter, 16px (1rem), Semibold 600
- **Hover**: Underline, color darkens slightly
- **Position**: Inline with "Don't have an account?" text

---

## Error States

### Invalid Credentials Error

```
┌─────────────────────────────────────────────────────────────┐
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Email Address                                          │  │
│  │ ┌─────────────────────────────────────────────────┐  │  │
│  │ │ artist@example.com                               │  │  │
│  │ └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Password                                               │  │
│  │ ┌─────────────────────────────────────────────────┐  │  │
│  │ │ ••••••••••••••••                      [👁️]    │  │  │
│  │ └─────────────────────────────────────────────────┘  │  │
│  │                                                         │  │
│  │  ⚠️ Invalid email or password                          │  │
│  │     Please check your credentials and try again.        │  │
│  └───────────────────────────────────────────────────────┘  │
```

**Error Message Styling**:
- **Background**: Error Red (#C73030) at 10% opacity
- **Border**: 1px solid Error Red (#C73030)
- **Border Radius**: 8px (0.5rem) - MD per Design System
- **Padding**: 12px (0.75rem)
- **Text Color**: Error Red (#C73030)
- **Font**: Inter, 14px (0.875rem), Regular 400
- **Icon**: Warning icon (⚠️) or error icon
- **Spacing**: 8px (0.5rem) below password input

**Input Error State**:
- **Border**: 2px solid Error Red (#C73030)
- **Focus State**: Maintains error border color

### Unverified Email Error

```
┌─────────────────────────────────────────────────────────────┐
│  ┌───────────────────────────────────────────────────────┐  │
│  │ ⚠️ Please verify your email address                     │  │
│  │                                                          │  │
│  │    We've sent a verification email to artist@example.com│  │
│  │    Click the link in the email to verify your account. │  │
│  │                                                          │  │
│  │    [Resend verification email]                          │  │
│  └───────────────────────────────────────────────────────┘  │
```

**Error Message Styling**:
- Same as invalid credentials error
- Includes "Resend verification email" button (secondary style)

### Field Validation Errors

**Empty Required Fields** (on submit):
- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Email is required" or "Password is required"
- **Position**: Below input field, 4px (0.25rem) spacing
- **Font**: Inter, 12px (0.75rem), Regular 400, Error Red (#C73030) - Tiny size per Design System (matches Design System error message spec)

**Invalid Email Format** (on blur):
- **Border**: 2px solid Error Red (#C73030)
- **Error Text**: "Please enter a valid email address"
- **Position**: Below input field

---

## Interaction & Behavior

### Form Submission

1. **Loading State**:
   - Button shows spinner/loading indicator
   - Button text: "Signing in..." or spinner replaces text
   - Button disabled during submission
   - Form inputs disabled during submission

2. **Success Flow**:
   - Form submits
   - Redirect to `/dashboard`
   - Flash message: "Signed in successfully" (optional)

3. **Error Flow**:
   - Error message appears below password field
   - Inputs maintain entered values
   - Focus returns to email input (or password if email was valid)
   - Error message persists until form is resubmitted or fields are changed

### Password Visibility Toggle

- **Default**: Password hidden (dots/bullets)
- **Click Toggle**: Password revealed as plain text
- **Icon Changes**: Eye → Eye-slash (or vice versa)
- **State Persists**: Until page reload or form submission
- **Accessibility**: `aria-pressed` attribute updates

### Remember Me Checkbox

- **Default**: Unchecked
- **Checked**: Session persists for extended period (e.g., 2 weeks)
- **Unchecked**: Session expires on browser close
- **Accessibility**: Proper label association

### Keyboard Navigation

- **Tab Order**: Email → Password → Remember Me → Forgot Password → Sign In → Sign Up
- **Enter Key**: Submits form when focus is on any input or button
- **Escape Key**: Clears form (optional enhancement)
- **Focus Indicators**: 2px solid Celadon Green (#6E9180) outline with 2px offset

### Link Behavior

- **Forgot Password**: Navigates to `/reset-password`
- **Sign Up**: Navigates to `/signup`
- **Both**: Open in same window (no new tab)

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

- **Desktop**: 1024px+ - per Design System Breakpoints
  - 600px max-width container, centered
  - Generous vertical spacing (80px top margin)
  - Optimal reading width for form

---

## Accessibility

### Keyboard Navigation

- **Tab Order**: Logical flow through all interactive elements
- **Focus Indicators**: Visible 2px outline in Celadon Green (#6E9180)
- **Skip Links**: "Skip to main content" link (optional, for screen readers)
- **Enter Key**: Submits form from any input field

### Screen Readers

- **Form Labels**: Properly associated with inputs using `for` attribute
- **Error Messages**: Associated with inputs using `aria-describedby`
- **Button Labels**: Descriptive text ("Sign In" not just "Submit")
- **Link Labels**: Descriptive text ("Forgot password?" not just "Forgot?")
- **Password Toggle**: `aria-label="Toggle password visibility"` and `aria-pressed` state
- **Remember Me**: Properly labeled checkbox

### Visual Accessibility

- **Color Contrast**: All text meets WCAG AA (4.5:1 minimum)
  - Celadon Dark (#527563) on White: 4.5:1 ✅
  - Charcoal (#1F2421) on White: 15.2:1 ✅
  - Error Red (#C73030) on White: 4.5:1 ✅
- **Focus States**: Visible 2px outline, never rely on color alone
- **Error States**: Use both color and icon/text, not just color
- **Touch Targets**: Minimum 44×44px (48px implemented)

### Form Validation

- **Real-time Validation**: On blur for email format
- **Submit Validation**: All required fields checked on submit
- **Error Announcements**: Screen readers announce errors via `aria-live` region
- **Success Feedback**: Confirmation message after successful login

---

## Performance Considerations

- **Form Pre-fill**: Browser autocomplete enabled for email/password
- **No JavaScript Required**: Form works without JS (progressive enhancement)
- **Fast Submission**: Minimal client-side validation, server handles most checks
- **Loading States**: Visual feedback during submission (spinner, disabled state)

---

## Implementation Checklist for Developers

When implementing this page (or any auth page), ensure:

### HTML Structure
- [ ] Semantic HTML5 elements (`<header>`, `<main>`, `<footer>`, `<form>`, `<label>`, etc.)
- [ ] Proper form field associations (`<label for="id">` matching input `id`)
- [ ] ARIA attributes where needed (`aria-label`, `aria-describedby`, `aria-pressed`)
- [ ] Autocomplete attributes (`autocomplete="email"`, `autocomplete="current-password"`, etc.)

### CSS Implementation
- [ ] Use CSS custom properties (variables) for all colors
- [ ] Inter font family loaded from Google Fonts or self-hosted
- [ ] Responsive breakpoints: 320px (mobile), 768px (tablet), 1025px (desktop)
- [ ] All transitions use 150ms or 200ms duration with ease timing
- [ ] Focus states visible (2px outline, never rely on color alone)
- [ ] Error states use both color and icon/text

### JavaScript Functionality
- [ ] Password visibility toggle (if applicable)
- [ ] Form validation (client-side for UX, server-side for security)
- [ ] Loading states on form submission
- [ ] Error message display/hiding
- [ ] Keyboard navigation support
- [ ] Progressive enhancement (works without JS)

### Accessibility
- [ ] All interactive elements keyboard accessible
- [ ] Focus indicators visible (2px Celadon Green outline)
- [ ] Screen reader labels on all form fields
- [ ] Error messages associated with inputs via `aria-describedby`
- [ ] Color contrast meets WCAG AA (4.5:1 minimum)
- [ ] Touch targets minimum 44×44px (48px implemented)

### Testing
- [ ] Test on mobile (320px-767px)
- [ ] Test on tablet (768px-1024px)
- [ ] Test on desktop (1025px+)
- [ ] Test keyboard-only navigation
- [ ] Test with screen reader
- [ ] Test error states
- [ ] Test loading states
- [ ] Test form submission (success and error paths)

### Reference Files
- **HTML/CSS Reference**: `requirements/wireframes/auth/login-preview.html` - Complete working implementation
- **Design System**: `requirements/DESIGN_SYSTEM.md` - Full design token specifications
- **User Flows**: `requirements/USER_FLOWS.md` - Authentication user journeys

---

## Design System Integration

### Colors Used

- **Primary Button**: Celadon Dark (#527563)
- **Links**: Celadon Green (#6E9180)
- **Text**: Charcoal (#1F2421) primary, Slate (#5C6C62) secondary
- **Borders**: Pale Celadon (#A8C4B5) at 50% opacity
- **Focus**: Celadon Green (#6E9180)
- **Error**: Error Red (#C73030)
- **Background**: White (#FFFFFF) for form, Misty White (#F8FAF9) for page

### Spacing

- **Container Padding**: 24px (1.5rem) on mobile, 32px (2rem) on desktop
- **Form Field Spacing**: 24px (1.5rem) between fields
- **Button Top Margin**: 32px (2rem) from last field
- **Link Spacing**: 16px (1rem) between related elements

### Typography

- **Font Family**: Inter (Google Fonts)
- **Heading**: H1 (48px/3rem, Bold 700)
- **Subheading**: Body Large (18px/1.125rem, Regular 400)
- **Labels**: Small (14px/0.875rem, Medium 500) - per Design System Form Input Specifications
- **Body**: Body (16px/1rem, Regular 400)

---

## Finalized Design Decisions

1. ✅ **Narrow Container**: 600px max-width for focused, distraction-free login
   - Optimal reading width for forms
   - Centers content, creates visual hierarchy

2. ✅ **Password Visibility Toggle**: Eye icon button for better UX
   - Helps users verify password entry
   - Accessible with keyboard and screen readers

3. ✅ **Remember Me**: Checkbox for extended sessions
   - Optional, not required
   - Clear label, accessible

4. ✅ **Error Handling**: Inline errors below form fields
   - Clear, actionable error messages
   - Visual distinction (red border, error background)

5. ✅ **Mobile-First**: Full-width on mobile, centered on desktop
   - Touch-friendly targets (48px minimum)
   - Responsive typography and spacing

---

## Reusable Patterns for Other Auth Pages

When creating signup, password reset, email verification, or profile setup pages, reuse these patterns:

### Page Structure Template
```
┌─────────────────────────────────────┐
│ Platform Header (shared component)  │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  Auth Container (600px max-width)   │
│  ┌───────────────────────────────┐ │
│  │ Page Heading (H1, 48px)       │ │
│  │ Page Subheading (18px)        │ │
│  │                                │ │
│  │ [Form Fields]                  │ │
│  │                                │ │
│  │ [Primary Button]               │ │
│  │                                │ │
│  │ ────────────────────────────  │ │
│  │                                │ │
│  │ [Secondary Link/Text]          │ │
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Platform Footer (shared component)  │
└─────────────────────────────────────┘
```

### Form Field Spacing
- **Between form groups**: 24px (1.5rem)
- **Between label and input**: 8px (0.5rem)
- **Between input and error message**: 8px (0.5rem)
- **Between last field and button**: 32px (2rem)

### Heading Patterns
- **Page Title**: H1, 48px (3rem), Bold 700, centered, Charcoal (#1F2421) - per Design System Type Scale
- **Page Subtitle**: 18px (1.125rem), Regular 400, centered, Slate (#5C6C62), margin-bottom: 32px (2rem) - Body Large per Design System
- **Section Headings**: H2, 24px (1.5rem), Semibold 600, Charcoal (#1F2421) - H4 per Design System Type Scale

### Button Placement
- **Primary Action**: Full-width button, 32px (2rem) margin from last form field
- **Secondary Actions**: Links or outline buttons, placed below primary button or in form options row

### Link Placement
- **Navigation Links**: Below divider (hr), centered text
- **Helper Links**: In form options row (same row as checkboxes/other options), right-aligned
- **Cross-page Links**: Below form, centered, with divider above

---

**Status**: Finalized ✓
**Date**: 2025-11-06
**Last Updated**: 2025-11-06 (Added shared components, implementation checklist, and verified alignment with DESIGN_SYSTEM.md)

**Design System Compliance**: This wireframe has been verified to align with all specifications in `requirements/DESIGN_SYSTEM.md`, including:
- ✅ Color palette and usage guidelines
- ✅ Typography scale and font weights
- ✅ Spacing scale (4px base unit)
- ✅ Border radius tokens (SM, MD)
- ✅ Shadow specifications
- ✅ Transition durations (Fast: 150ms, Base: 200ms)
- ✅ Form input specifications (LG size: 48px height, 16px vertical padding)
- ✅ Button specifications
- ✅ Checkbox specifications
- ✅ Responsive breakpoints (0-767px mobile, 768px-1023px tablet, 1024px+ desktop)
- ✅ Accessibility requirements (WCAG AA)

