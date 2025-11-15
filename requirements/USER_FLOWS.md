# Clay Companion - User Flows

**Last Updated**: 2025-11-06
**Document Type**: Tech-Agnostic User Journey Requirements

---

## Overview

This document describes the key user journeys and interaction flows for Clay Companion. These flows are technology-agnostic and focus on user goals, actions, and expected outcomes.

**Wireframe References**: Detailed wireframes and HTML previews for authentication flows are available in `requirements/wireframes/auth/`:
- Login: `auth/login.md` | Preview: `auth/login-preview.html`
- Signup: `auth/signup.md` | Preview: `auth/signup-preview.html`
- Password Reset: `auth/password-reset.md` | Preview: `auth/password-reset-preview.html`
- Email Verification: `auth/email-verification.md` | Preview: `auth/email-verification-preview.html`
- Profile Setup: `auth/profile-setup.md` | Preview: `auth/profile-setup-preview.html`
- Complete Auth Flows: `auth/AUTH_FLOWS.md` (comprehensive documentation)

---

## Artist User Flows

### 1. Artist Onboarding Flow

**Goal**: Get a new artist from signup to published portfolio

**Wireframe References**:
- Signup: `requirements/wireframes/auth/signup.md` | Preview: `auth/signup-preview.html`
- Email Verification: `requirements/wireframes/auth/email-verification.md` | Preview: `auth/email-verification-preview.html`
- Profile Setup: `requirements/wireframes/auth/profile-setup.md` | Preview: `auth/profile-setup-preview.html`

**Steps**:
1. Visit platform homepage
2. Click "Start Your Portfolio" or "Sign Up"
3. **Signup Form**:
   - Enter email address
   - Create password (with strength requirements)
   - Accept terms of service
   - Submit form
   - See wireframe: `auth/signup.md` for complete specifications
4. **Email Verification**:
   - Receive verification email
   - Click verification link
   - Confirmation message displayed
   - See wireframe: `auth/email-verification.md` for all verification states
5. **Profile Setup** (First-time login):
   - Enter full name (required)
   - Upload portrait photo (required)
   - Enter location (optional)
   - Enter bio (optional)
   - Skip to dashboard or continue setup
   - See wireframe: `auth/profile-setup.md` for complete specifications
6. **Add First Artwork** (Guided):
   - Click "Add Your First Artwork" button
   - Upload images (drag-and-drop or select)
   - Enter basic info (title, year, description)
   - Click "Save" (defaults to private)
   - Success confirmation
7. **Preview Portfolio**:
   - Click "View Public Portfolio" link
   - See published portfolio with first artwork
   - Return to dashboard
8. **Share Portfolio**:
   - Copy portfolio URL
   - Share with collectors, galleries, etc.

**Success Criteria**:
- Artist completes signup in < 5 minutes
- Artist adds first artwork in < 10 minutes
- Artist sees live portfolio within 30 minutes

---

### 2. Login Flow

**Goal**: Authenticated access to artist dashboard

**Wireframe References**:
- Login: `requirements/wireframes/auth/login.md` | Preview: `auth/login-preview.html`
- Password Reset: `requirements/wireframes/auth/password-reset.md` | Preview: `auth/password-reset-preview.html`

**Happy Path**:
1. Visit login page (`/login` or `/dashboard/login`)
2. Enter email address
3. Enter password
4. (Optional) Check "Remember me"
5. Click "Login"
6. Redirect to dashboard home
7. See activity feed and quick actions
8. See wireframe: `auth/login.md` for complete specifications

**Error Cases**:

**Invalid Credentials**:
1. Enter incorrect email or password
2. See error message: "Invalid email or password"
3. Input fields highlighted
4. Try again with correct credentials

**Unverified Email**:
1. Enter valid credentials but unverified email
2. See error message: "Please verify your email first"
3. Show "Resend verification" button
4. Click to resend verification email
5. See wireframe: `auth/email-verification.md` for verification flow

**Forgot Password**:
1. Click "Forgot password?" link
2. Redirect to password reset page
3. Enter email address
4. Submit form
5. See confirmation: "Check your email for reset instructions"
6. Receive email with reset link
7. Click link, enter new password
8. Redirect to login with success message
9. See wireframe: `auth/password-reset.md` for complete two-step reset flow

---

### 3. Add Artwork Flow

**Goal**: Catalog a new artwork with images and metadata

**Steps**:
1. From dashboard, click "Add New Artwork" or navigate to Catalog → Add
2. **Upload Images**:
   - Drag-and-drop multiple images OR click to select files
   - See upload progress indicators
   - See thumbnail previews appear
   - Drag to reorder images
   - Click thumbnail to mark as primary image
   - Delete unwanted images with X button
3. **Enter Basic Information**:
   - Title (required)
   - Description (optional, rich text editor)
   - Year created (required, dropdown or number input)
4. **Enter Clay Details**:
   - Clay body type (dropdown: Stoneware, Porcelain, etc.)
   - Firing cone (text input, e.g., "Cone 10")
   - Firing schedule (text input, e.g., "Reduction")
   - Glaze description (text area)
5. **Enter Physical Details**:
   - Dimensions (text input, e.g., "10 × 8 × 6 inches")
   - Weight (optional text input)
6. **Organization**:
   - Select series (dropdown, optional)
   - Select group (dropdown, filtered by series, optional)
7. **Display Settings**:
   - Toggle public/private (default: private)
   - Toggle featured (default: false)
   - Toggle hidden from gallery (default: false)
   - Select availability status (dropdown: Available, Sold, etc.)
8. **Internal Notes** (optional):
   - Enter private notes (text area)
9. **Save**:
   - Click "Save" button
   - See loading indicator
   - Redirect to catalog with success message
   - New artwork appears in list

**Validation**:
- Cannot save without title
- Cannot save without year created
- Cannot save without at least one image
- Show inline errors for invalid fields
- Warn before leaving with unsaved changes

---

### 4. Edit Artwork Flow

**Goal**: Update existing artwork information or images

**Steps**:
1. From catalog, click artwork card or "Edit" button
2. Redirect to edit page with pre-filled form
3. **Update Images**:
   - See existing images in order
   - Upload additional images
   - Reorder existing images
   - Delete images (with confirmation if last image)
   - Change primary image
4. **Update Fields**:
   - Modify any form fields
   - See current values pre-filled
5. **Save Changes**:
   - Click "Save" button
   - See loading indicator
   - Redirect to catalog with success message
6. **Delete Artwork** (optional):
   - Click "Delete Artwork" button
   - See confirmation modal:
     - Show artwork title and thumbnail
     - Warning: "This will permanently delete this artwork and all its images"
     - Require explicit confirmation
   - Click "Delete" to confirm or "Cancel" to abort
   - If confirmed, redirect to catalog with success message

---

### 5. Organize into Series Flow

**Goal**: Create a series and organize artworks within it

**Steps**:
1. Navigate to Dashboard → Series
2. Click "Create New Series"
3. **Series Form**:
   - Enter title (required)
   - Enter description (optional)
   - Enter year start (required)
   - Enter year end (optional - blank for ongoing)
   - Toggle public/private
   - Toggle featured
4. Click "Save"
5. Redirect to series detail page
6. **Add Artworks to Series**:
   - Option A: Drag artworks from catalog into series
   - Option B: When editing artwork, select this series from dropdown
7. **Create Groups** (optional):
   - Click "Create New Group" on series detail page
   - Enter group title and description
   - Save group
   - Drag artworks into group
8. **Reorder**:
   - Drag series to reorder in series list
   - Drag groups to reorder within series
   - Drag artworks to reorder within groups
   - Changes save automatically or on "Save Order" button

---

### 6. Publish Portfolio Content Flow

**Goal**: Make private content visible on public portfolio

**Steps**:
1. Create/edit content (artwork, series, exhibition, etc.)
2. **Set Visibility**:
   - Toggle "Public" switch to ON
   - (Optional) Toggle "Featured" to highlight on homepage/gallery
3. Save changes
4. **Preview**:
   - Click "Preview Public Portfolio" link
   - Open portfolio in new tab
   - Verify content appears correctly
   - Return to dashboard
5. **Share**:
   - Copy portfolio URL
   - Share via email, social media, etc.

**Visibility Controls**:
- **Private**: Only visible in dashboard, not on public portfolio
- **Public**: Visible on public portfolio and gallery
- **Featured**: Highlighted in featured sections (homepage, gallery featured filter)
- **Hidden from gallery**: Public but doesn't appear in gallery (useful for commission process pieces)

---

### 7. Manage Portfolio Settings Flow

**Goal**: Update profile, exhibitions, press, and contact information

**Profile Settings**:
1. Navigate to Dashboard → Settings → Profile
2. Update artist information (name, location)
3. Upload/replace photos (portrait, studio)
4. Edit bio and artist statement
5. Add/edit education entries
6. Add/edit award entries
7. Update social links
8. Click "Save Changes"
9. See success confirmation

**Exhibition Management**:
1. Navigate to Dashboard → Settings → Exhibitions
2. Click "Add New Exhibition"
3. Enter exhibition details:
   - Title, venue, location
   - Start and end dates
   - Description
   - Exhibition type (Solo, Group, Online)
   - Toggle "Featured" if desired
4. **Upload Images** (if featured):
   - Upload multiple photos
   - Add captions
   - Reorder images
5. Click "Save"
6. Exhibition appears in list and on public portfolio

**Press Management**:
1. Navigate to Dashboard → Settings → Press
2. Click "Add New Press Mention"
3. Enter press details:
   - Article title
   - Publication name
   - Published date
   - External URL
   - Short excerpt (100-200 words)
   - Long excerpt if featured (200-300 words)
   - Toggle "Featured" if desired
4. Click "Save"
5. Press mention appears in list and on public portfolio

**Studio Photos**:
1. Navigate to Dashboard → Settings → Studio
2. (Optional) Add intro text for Process/Studio page
3. Upload multiple images:
   - Select category (Studio, Process, Other)
   - Add captions (1-2 sentences)
4. Drag to reorder images
5. Click "Save Changes"
6. Photos appear on public Process/Studio page

**Contact Settings**:
1. Navigate to Dashboard → Settings → Contact
2. Update contact information:
   - Public email (required)
   - Phone number (optional)
   - Studio location (optional)
   - Response time note (optional)
3. Update social media URLs with visibility toggles
4. **Instagram Integration** (optional):
   - Click "Connect Instagram"
   - Authorize OAuth connection
   - OR upload 6-12 images manually
   - Set cache refresh interval
5. Preview contact page
6. Click "Save Changes"

---

### 8. View Analytics Flow (Post-MVP)

**Goal**: Understand portfolio performance and visitor engagement

**Steps**:
1. Navigate to Dashboard → Analytics
2. **View Overview Dashboard**:
   - Total portfolio views (30 days)
   - Page view breakdown (Gallery, About, etc.)
   - Popular artworks (most viewed)
   - Visitor geography (map)
   - Referral sources
3. **Filter by Date Range**:
   - Last 7 days
   - Last 30 days
   - Last 90 days
   - Custom date range
4. **Drill Down**:
   - Click artwork to see detailed stats
   - Click page to see page-specific metrics
   - Export data as CSV (optional)

---

## Public Visitor Flows

### 9. Discover Artists Flow

**Goal**: Find ceramic artists and their work on the platform

**Steps**:
1. Visit platform homepage (`claycompanion.com`)
2. **Explore Featured Content**:
   - View hero carousel (featured artworks)
   - Click artist attribution to visit portfolio
   - Browse featured artist cards
   - Click artist card to visit portfolio
3. **Search**:
   - Enter search term in search bar
   - See real-time results (artists, artworks)
   - Filter by clay type, firing type, location
   - Click result to visit artist portfolio
4. **Browse Directory**:
   - Scroll to artist directory section
   - View grid of all artists (6-col)
   - Apply filters (clay type, location, etc.)
   - Click "Load More" to see more artists
   - Click artist card to visit portfolio

---

### 10. Explore Artist Portfolio Flow

**Goal**: Learn about an artist and view their work

**Entry Points**:
- Direct URL: `claycompanion.com/artist-name`
- Platform discovery
- Search engines (Google, etc.)
- Social media links

**Steps**:
1. **Land on Artist Profile**:
   - See featured artwork in hero
   - Read artist statement preview
   - View recent work thumbnails
   - See navigation menu
2. **Browse Gallery**:
   - Click "Gallery" in nav or "View Gallery" button
   - See artworks organized by series
   - Filter by: Featured (default), All, specific series
   - Click artwork thumbnail to open lightbox:
     - View full-size image
     - Navigate between images (prev/next arrows)
     - Read artwork details (title, year, dimensions, etc.)
     - Close lightbox (X button or ESC key)
3. **Learn About Artist**:
   - Click "About" in nav
   - View portrait and studio photo
   - Read artist statement (first-person)
   - Read biography (third-person)
   - View education and awards
4. **See Process**:
   - Click "Process" in nav
   - View studio and process photos
   - Read captions
   - Click photos to view full size
5. **View Exhibitions**:
   - Click "Exhibitions" in nav
   - Browse featured exhibitions with image carousels
   - View chronological exhibition history
   - Click images to open lightbox
6. **Read Press**:
   - Click "Press" in nav
   - Read featured article excerpts
   - Click "Read More" to visit external article
   - Browse chronological press history
7. **Contact Artist**:
   - Click "Contact" in nav
   - View contact information (email, phone, location)
   - Click social media icons to visit profiles
   - Browse Instagram feed (if enabled)
   - Click Instagram images to open on Instagram

---

### 11. Artwork Discovery via SEO Flow

**Goal**: Find specific artwork or artist via search engine

**Steps**:
1. Search Google for "ceramic stoneware bowl artist"
2. See Clay Companion artist portfolio in results
3. Click result, land on artist portfolio or gallery page
4. Browse artworks and learn about artist
5. Contact artist or bookmark portfolio

**SEO Optimization Requirements**:
- Unique meta titles and descriptions per page
- Alt text on all images
- Structured data (Schema.org markup)
- Clean, descriptive URLs
- Fast load times
- Mobile-friendly design

---

### 12. Share Artwork Flow

**Goal**: Share specific artwork with friend or on social media

**Steps**:
1. Browse artist gallery
2. Click artwork to open lightbox
3. See sharing options (Post-MVP):
   - Copy URL button
   - Share to Facebook
   - Share to Twitter
   - Share to Pinterest
   - Share via email
4. Click share button
5. Share dialog opens (native or custom)
6. Complete share action

**URL Format**:
- `claycompanion.com/artist-name/gallery/artwork-slug`
- Opens lightbox directly for that artwork
- Social media preview shows artwork image and details

---

## Edge Cases & Error Flows

### Handle Unauthenticated Access to Dashboard

**Flow**:
1. User attempts to visit dashboard page without authentication
2. System detects no valid session
3. Redirect to login page
4. Show message: "Please login to access your dashboard"
5. After successful login, redirect to originally requested page

---

### Handle Invalid Artist URL

**Flow**:
1. User visits `claycompanion.com/nonexistent-artist`
2. System checks if artist exists
3. Artist not found
4. Display 404 error page:
   - "Artist portfolio not found"
   - Suggestion: "Search for other artists" (link to platform homepage)
   - Option to return to homepage
5. User navigates away

---

### Handle Image Upload Errors

**Flow**:
1. User attempts to upload image
2. **Error scenarios**:
   - **File too large**:
     - Show error: "Image must be under 10MB. Please compress and try again."
     - Suggest compression tools
   - **Invalid format**:
     - Show error: "Only JPG, PNG, and WebP formats are supported."
     - List supported formats
   - **Upload failed** (network error):
     - Show error: "Upload failed. Please check your connection and try again."
     - Provide "Retry" button
3. User resolves issue and retries upload

---

### Handle Form Validation Errors

**Flow**:
1. User fills out form with invalid or missing data
2. User clicks "Save" or "Submit"
3. System validates input:
   - Required fields missing
   - Invalid format (email, URL, etc.)
   - Out-of-range values
4. Prevent submission
5. Display errors:
   - Inline error messages below/beside fields
   - Red border on invalid fields
   - Error summary at top of form (optional)
   - Scroll to first error
6. User corrects errors
7. Submit again successfully

---

### Handle Slow Network / Loading States

**Flow**:
1. User performs action (save, load page, upload, etc.)
2. **Show appropriate loading state**:
   - Button spinners during async operations
   - Skeleton loaders for page content
   - Progress bars for uploads
   - Full-page overlay for critical operations
3. **If operation takes >5 seconds**:
   - Show additional message: "This is taking longer than usual..."
   - Option to cancel (if applicable)
4. **On success**:
   - Hide loading state
   - Show success message
   - Update UI with new data
5. **On failure**:
   - Hide loading state
   - Show error message with retry option

---

### Handle Session Timeout

**Flow**:
1. Artist is logged into dashboard
2. Session expires after inactivity period
3. Artist attempts to perform action (save, navigate, etc.)
4. System detects expired session
5. Show modal:
   - "Your session has expired"
   - "Please login again to continue"
   - "Log In" button
6. Click button, redirect to login page
7. After login, return to where user was (if possible)

---

## Mobile-Specific Flows

### Mobile Navigation

**Flow**:
1. Visit artist portfolio on mobile device
2. See hamburger menu icon (☰) in top right
3. Tap hamburger to open menu
4. See navigation links in drawer/panel:
   - Gallery
   - About
   - Process
   - Exhibitions
   - Press
   - Contact
5. Tap link to navigate
6. Menu closes automatically
7. Page loads

---

### Mobile Image Upload

**Flow**:
1. Navigate to Add/Edit Artwork on mobile
2. Tap "Upload Images" area
3. **System prompts**:
   - "Choose source": Camera or Photo Library
4. Select source:
   - **Camera**: Opens camera, take photo, confirm
   - **Photo Library**: Opens gallery, select photo(s)
5. Selected images appear as thumbnails
6. Tap and hold to reorder (mobile drag)
7. Tap thumbnail to mark as primary
8. Tap X to delete

---

## Accessibility Flows

### Keyboard Navigation Flow

**Flow**:
1. User navigates site using keyboard only (no mouse)
2. **Tab through interactive elements**:
   - Links
   - Buttons
   - Form inputs
   - Menus
3. **Focus indicators** visible on current element
4. **Skip to main content** link at top (jump past nav)
5. **Open lightbox** with Enter/Space
6. **Navigate lightbox** with arrow keys
7. **Close lightbox** with ESC
8. **Submit forms** with Enter
9. All interactive elements reachable and operable

---

### Screen Reader Flow

**Flow**:
1. User navigates site with screen reader
2. **Semantic HTML**:
   - Headings announce page structure
   - Landmarks announce page sections (nav, main, footer)
   - Lists announce list items
3. **ARIA labels** provide context for icons and buttons
4. **Alt text** describes images:
   - Artwork images: "Ceramic bowl with blue glaze by Artist Name"
   - Decorative images: Empty alt text (skipped)
5. **Form labels** announce input purposes
6. **Error messages** announced when validation fails
7. **Loading states** announced: "Loading..." / "Loaded"

---

## Notes

These flows are intentionally tech-agnostic, focusing on user goals, actions, and system responses. Implementation details (API calls, state management, routing, etc.) are left to the chosen technology stack.

When implementing these flows, ensure:
- Clear visual feedback at each step
- Error handling for all failure scenarios
- Loading states for async operations
- Success confirmations for user actions
- Mobile-optimized interactions
- Keyboard and screen reader accessibility

---

**Document Version**: 1.1 (Tech-Agnostic)
**Source Documents**: Extracted from DECISIONS.md, FEATURES.md, PAGE_TREE.md

**Related Documentation**:
- Authentication Flows: `requirements/wireframes/auth/AUTH_FLOWS.md` (complete auth flow documentation)
- Design System: `requirements/DESIGN_SYSTEM.md` (design tokens and patterns)
- Features: `requirements/FEATURES.md` (feature requirements)
