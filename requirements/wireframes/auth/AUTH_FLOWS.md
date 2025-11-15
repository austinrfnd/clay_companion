# Authentication Flows - Complete Documentation

**Last Updated**: 2025-11-06
**Purpose**: Comprehensive documentation of all authentication user flows and wireframes

---

## Overview

This document provides a complete overview of all authentication flows in Clay Companion, including user journeys, wireframe references, and implementation notes. All authentication pages follow consistent design patterns and share common components.

---

## Authentication Pages

### 1. Login Page

**URL**: `/login`

**Wireframe**: `auth/login.md`  
**Preview**: `auth/login-preview.html`

**Purpose**: Authenticate existing artists to access their dashboard

**Key Features**:
- Email/password authentication
- "Remember me" checkbox
- Password visibility toggle
- "Forgot password?" link
- Error handling for invalid credentials
- Unverified email handling

**User Flow**:
1. User visits `/login`
2. Enters email and password
3. (Optional) Checks "Remember me"
4. Clicks "Sign In"
5. Redirects to `/dashboard` on success
6. Shows error message on failure

**Error Cases**:
- Invalid email or password
- Unverified email (with resend option)
- Empty required fields

---

### 2. Signup Page

**URL**: `/signup`

**Wireframe**: `auth/signup.md`  
**Preview**: `auth/signup-preview.html`

**Purpose**: Register new artists to create accounts

**Key Features**:
- Email and password signup
- Real-time password strength indicator
- Password requirements checklist
- Terms of Service acceptance
- Password visibility toggle
- Error handling for existing emails

**User Flow**:
1. User visits `/signup`
2. Enters email address
3. Creates password (with real-time strength feedback)
4. Accepts Terms of Service
5. Clicks "Create Account"
6. Redirects to email verification confirmation

**Password Requirements**:
- 8-30 characters
- Uppercase and lowercase letters
- At least one number
- At least one special character

**Error Cases**:
- Email already exists
- Weak password (doesn't meet requirements)
- Terms not accepted
- Invalid email format

---

### 3. Password Reset Flow

**URL**: `/reset-password` (request) and `/reset-password/edit?token=...` (reset form)

**Wireframe**: `auth/password-reset.md`  
**Preview**: `auth/password-reset-preview.html`

**Purpose**: Allow artists to reset forgotten passwords via email token

**Key Features**:
- Two-step flow (request → reset)
- Email confirmation after request
- Password strength indicator (same as signup)
- Password confirmation field
- Token-based secure reset

**Step 1: Request Reset**:
1. User visits `/reset-password`
2. Enters email address
3. Clicks "Send Reset Instructions"
4. Sees confirmation: "Check your email"
5. Receives email with reset link

**Step 2: Reset Password**:
1. User clicks reset link in email
2. Lands on `/reset-password/edit?token=...`
3. Enters new password (with strength indicator)
4. Confirms new password
5. Clicks "Reset Password"
6. Redirects to login with success message

**Error Cases**:
- Email not found
- Invalid or expired token
- Passwords don't match
- Weak password

---

### 4. Email Verification Flow

**URL**: `/verify-email` (confirmation) and `/verify-email/confirm?token=...` (verification link)

**Wireframe**: `auth/email-verification.md`  
**Preview**: `auth/email-verification-preview.html`

**Purpose**: Verify email addresses for new artist accounts

**Key Features**:
- Multiple states (sent, success, error, already verified)
- Resend verification email option
- Clear instructions for each state
- Token-based verification

**State 1: Verification Sent** (After Signup):
1. User completes signup
2. Redirects to verification sent page
3. Sees confirmation with email address
4. Can resend email if needed

**State 2: Verification Success** (After Clicking Link):
1. User clicks verification link in email
2. Email verified successfully
3. Redirects to profile setup or dashboard

**State 3: Verification Error** (Invalid/Expired Token):
1. User clicks expired/invalid link
2. Sees error message
3. Can request new verification email

**State 4: Already Verified**:
1. User clicks verification link for already-verified email
2. Sees "Already verified" message
3. Redirects to login

**Error Cases**:
- Invalid or expired token (24 hour expiry)
- Email not found

---

### 5. Profile Setup (Onboarding)

**URL**: `/onboarding/profile-setup`

**Wireframe**: `auth/profile-setup.md`  
**Preview**: `auth/profile-setup-preview.html`

**Purpose**: First-time profile setup for new artists after email verification

**Key Features**:
- Welcome message
- Required fields: Full name, Portrait photo
- Optional fields: Location, Bio
- Photo upload (drag-and-drop or click)
- Character counter for bio
- Skip option

**User Flow**:
1. User completes email verification
2. Redirects to profile setup (first-time login)
3. Enters full name (required)
4. Uploads portrait photo (required)
5. (Optional) Enters location and bio
6. Clicks "Complete Setup" or "Skip for now"
7. Redirects to dashboard

**Error Cases**:
- Required fields missing
- Invalid file type (not JPG/PNG)
- File too large (>5MB)
- Upload failed
- Bio too long (>2000 characters)

---

## Complete User Journeys

### New Artist Onboarding Journey

**Complete Flow**:
1. **Signup** (`/signup`)
   - Create account with email/password
   - Accept Terms of Service
   - Submit form

2. **Email Verification** (`/verify-email`)
   - See confirmation: "Check your email"
   - Click verification link in email
   - Email verified successfully

3. **Profile Setup** (`/onboarding/profile-setup`)
   - Enter full name (required)
   - Upload portrait photo (required)
   - (Optional) Enter location and bio
   - Complete setup or skip

4. **Dashboard** (`/dashboard`)
   - See welcome message
   - "Add Your First Artwork" CTA
   - Start building portfolio

**Total Time**: < 10 minutes to complete onboarding

---

### Returning Artist Login Journey

**Complete Flow**:
1. **Login** (`/login`)
   - Enter email and password
   - (Optional) Check "Remember me"
   - Sign in

2. **Dashboard** (`/dashboard`)
   - See activity feed
   - Access portfolio management tools

**Total Time**: < 30 seconds

---

### Password Reset Journey

**Complete Flow**:
1. **Request Reset** (`/reset-password`)
   - Click "Forgot password?" from login
   - Enter email address
   - Submit form

2. **Email Confirmation**
   - See "Check your email" message
   - Receive reset email

3. **Reset Password** (`/reset-password/edit?token=...`)
   - Click reset link in email
   - Enter new password (with strength indicator)
   - Confirm new password
   - Submit form

4. **Login** (`/login`)
   - Sign in with new password
   - Success message: "Password reset successfully"

**Total Time**: < 5 minutes

---

## Shared Components

All authentication pages share the following components (defined in `login.md`):

### Platform Header
- Logo: "Clay Companion"
- Header links: "Sign Up", "Login" (context-appropriate)
- Consistent styling across all pages

### Platform Footer
- Footer links: Contact, About, Terms, Privacy
- "Powered by Clay Companion" text
- Consistent styling across all pages

### Auth Page Container
- 600px max-width (desktop)
- White background
- 4px border radius
- Consistent padding and spacing

### Common Form Elements
- **Inputs**: LG size (48px height, 16px vertical padding)
- **Buttons**: Primary (Celadon Dark) and Secondary (outline) styles
- **Links**: Celadon Green with hover states
- **Error Messages**: Red background, border, icon
- **Success Messages**: Green background, border, icon

### Design System Compliance
All pages follow `requirements/DESIGN_SYSTEM.md`:
- Color palette (Celadon Green scheme)
- Typography (Inter font, type scale)
- Spacing (4px base unit)
- Border radius (SM: 4px, MD: 8px)
- Transitions (Fast: 150ms, Base: 200ms)
- Accessibility (WCAG AA compliance)

---

## Implementation Notes

### Route Protection

**Protected Routes** (require authentication):
- `/dashboard/*` - All dashboard pages
- `/onboarding/*` - Onboarding pages (after verification)

**Public Routes** (redirect if authenticated):
- `/login` - Redirects to `/dashboard` if already logged in
- `/signup` - Redirects to `/dashboard` if already logged in

**Unprotected Routes**:
- `/reset-password` - Can access when logged out
- `/verify-email` - Can access when logged out

### Session Management

- **Remember Me**: Extends session to 2 weeks
- **Default Session**: Expires on browser close
- **Session Refresh**: Automatic on activity
- **Timeout**: 30 minutes of inactivity

### Email Verification

- **Token Expiry**: 24 hours
- **Resend Limit**: Max 3 resends per hour
- **Auto-redirect**: After verification, redirects to profile setup or dashboard

### Password Requirements

**Enforced on**:
- Signup
- Password reset
- Password change (future)

**Requirements**:
- 8-30 characters
- Uppercase and lowercase letters
- At least one number
- At least one special character

### Error Handling

**Consistent Error Patterns**:
- Inline errors below form fields
- Red border on invalid inputs
- Clear, actionable error messages
- Error messages associated with inputs via `aria-describedby`

**Common Error Messages**:
- "Invalid email or password"
- "Email is required"
- "Password does not meet all requirements"
- "This email is already registered"
- "This verification link is invalid or has expired"

---

## Wireframe Files

All authentication wireframes are located in `requirements/wireframes/auth/`:

1. **login.md** - Login page wireframe
2. **login-preview.html** - Login page HTML preview
3. **signup.md** - Signup page wireframe
4. **signup-preview.html** - Signup page HTML preview
5. **password-reset.md** - Password reset flow wireframe
6. **password-reset-preview.html** - Password reset HTML preview
7. **email-verification.md** - Email verification wireframe
8. **email-verification-preview.html** - Email verification HTML preview
9. **profile-setup.md** - Profile setup wireframe
10. **profile-setup-preview.html** - Profile setup HTML preview
11. **AUTH_FLOWS.md** - This document (complete flow overview)

---

## Testing Checklist

When implementing authentication, test:

### Login
- [ ] Valid credentials → redirects to dashboard
- [ ] Invalid credentials → shows error
- [ ] Unverified email → shows error with resend option
- [ ] Remember me → extends session
- [ ] Password visibility toggle works
- [ ] Keyboard navigation works
- [ ] Screen reader announces errors

### Signup
- [ ] Valid signup → redirects to verification
- [ ] Existing email → shows error
- [ ] Weak password → shows error
- [ ] Password strength indicator updates
- [ ] Requirements checklist updates
- [ ] Terms not accepted → shows error
- [ ] Keyboard navigation works

### Password Reset
- [ ] Request reset → sends email
- [ ] Invalid email → shows error
- [ ] Reset form → validates password strength
- [ ] Passwords don't match → shows error
- [ ] Expired token → shows error
- [ ] Success → redirects to login

### Email Verification
- [ ] Verification sent → shows confirmation
- [ ] Valid token → verifies email
- [ ] Expired token → shows error
- [ ] Already verified → shows message
- [ ] Resend email works

### Profile Setup
- [ ] Required fields → validates on submit
- [ ] Photo upload works (drag-and-drop and click)
- [ ] Invalid file type → shows error
- [ ] File too large → shows error
- [ ] Character counter updates
- [ ] Skip → redirects to dashboard
- [ ] Complete → redirects to dashboard

---

## Security Considerations

### Password Security
- Passwords hashed with bcrypt (or similar)
- Never stored in plain text
- Password strength requirements enforced
- Password reset tokens expire after 1 hour

### Email Verification
- Verification tokens expire after 24 hours
- Tokens are single-use
- Rate limiting on resend requests

### Session Security
- Secure session storage
- CSRF protection on all forms
- HTTPS required in production
- Session timeout on inactivity

### Input Validation
- Server-side validation (never trust client)
- SQL injection prevention (parameterized queries)
- XSS prevention (sanitize user input)
- Email format validation

---

## Future Enhancements (Post-MVP)

- [ ] Social login (Google, Facebook)
- [ ] Two-factor authentication (2FA)
- [ ] Passwordless login (magic links)
- [ ] Account recovery options
- [ ] Login history/activity log
- [ ] Session management dashboard

---

**Status**: Complete ✓
**Date**: 2025-11-06
**Related Documents**:
- `requirements/USER_FLOWS.md` - User journey specifications
- `requirements/FEATURES.md` - Feature requirements
- `requirements/DESIGN_SYSTEM.md` - Design system specifications
- `requirements/wireframes/auth/login.md` - Login wireframe (includes shared components)

