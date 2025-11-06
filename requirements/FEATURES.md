# Clay Companion - Feature Specifications

**Last Updated**: 2025-11-05
**Document Type**: Tech-Agnostic Feature Requirements

---

## Feature Overview

This document provides a comprehensive list of all features for Clay Companion MVP and planned post-MVP enhancements. Features are organized by user role and functional area.

---

## Authentication & Account Management

### User Registration
- Email and password signup
- Email verification flow
- Profile creation during onboarding
- Password strength validation:
  - Minimum 8 characters
  - Maximum 30 characters
  - Must include uppercase and lowercase letters
  - Must include numbers
  - Must include special characters
- Real-time password strength feedback

### Login & Session Management
- Email/password authentication
- Persistent user sessions
- "Remember me" functionality
- Automatic session refresh
- Session timeout handling
- Secure session storage

### Password Management
- Password reset via email
- Secure token-based password updates
- Password change from account settings
- Password visibility toggle on forms
- Inline validation messages

### Route Protection
- Protected dashboard routes (require authentication)
- Redirect to login for unauthenticated access
- Redirect authenticated users away from login/signup
- Session-based authorization checks

---

## Artist Dashboard Features

### Dashboard Home

**Quick Actions**:
- Add New Artwork button
- Add New Series button
- View Catalog link
- View Public Portfolio link

**Activity Feed**:
- Recent artwork additions
- Recent visibility changes (public/private)
- Recent exhibition updates
- Recent press additions
- Timestamps for all activities

**Quick Stats** (Future Enhancement):
- Total artworks count
- Public artworks count
- Total series count
- Recent portfolio views (Post-MVP)

---

## Artwork Catalog Management

### Artwork List View

**Display**:
- Horizontal card layout with thumbnail
- Title, year, and status visible on card
- Series/group tags on each card
- Availability status badge
- Public/private indicator
- Actions menu (Edit, Delete, Toggle Visibility)

**Filtering**:
- All / Public / Private filter
- Filter by series
- Filter by availability status
- Filter by year created

**Sorting**:
- Newest first (default)
- Oldest first
- Alphabetical (A-Z)
- Alphabetical (Z-A)
- Recently updated

**Search**:
- Search by title
- Search by description
- Search by series name
- Real-time search results

**Batch Actions** (Future):
- Select multiple artworks
- Bulk visibility toggle
- Bulk series assignment
- Bulk delete with confirmation

### Add Artwork

**Split Layout**:
- Left side (40%): Image upload and management
- Right side (60%): Form fields in sections
- Mobile: Stacked vertically

**Image Management**:
- Drag-and-drop upload
- Multiple image upload
- Image preview thumbnails
- Drag-to-reorder images
- Mark primary/hero image
- Delete individual images
- Support for common formats (JPG, PNG, WebP)
- Image size validation

**Form Sections**:

1. **Basic Information**:
   - Title (required)
   - Description (optional, rich text)
   - Year created (required)

2. **Organization**:
   - Series selection (dropdown, optional)
   - Group selection (dropdown, optional, filtered by series)
   - Display order (numeric, auto-set)

3. **Clay Details**:
   - Clay body type (dropdown: Stoneware, Porcelain, Earthenware, Terracotta, Raku, Custom)
   - Firing cone (text, e.g., "Cone 10")
   - Firing schedule (text, e.g., "Reduction", "Oxidation")
   - Glaze description (text area)

4. **Physical Details**:
   - Dimensions (text, e.g., "10 × 8 × 6 inches")
   - Weight (text, optional)

5. **Display Settings**:
   - Public/private toggle
   - Featured on homepage toggle
   - Hidden from gallery toggle
   - Availability status (dropdown: Available, Sold, Commissioned, Not for Sale)

6. **Internal Notes**:
   - Private notes (text area, never displayed publicly)

**Actions**:
- Cancel (return to catalog)
- Save as Draft (optional, marks as private)
- Save (creates artwork)

### Edit Artwork

**Same Layout as Add Artwork**:
- Pre-populated with existing data
- All same fields and sections
- Image management includes existing images
- Delete artwork option (with confirmation)

**Change Tracking**:
- Last updated timestamp
- Created timestamp display

**Validation**:
- Warn before leaving with unsaved changes
- Prevent save without required fields
- Image format and size validation

### Delete Artwork

**Confirmation Modal**:
- Display artwork title and thumbnail
- Warning about permanent deletion
- Warning about deleting associated images
- Require explicit confirmation
- Cancel / Delete buttons

---

## Series & Group Organization

### Series List View

**Display**:
- Card layout for each series
- Series thumbnail (first artwork image)
- Title, description preview, year range
- Artwork count badge
- Public/private indicator
- Featured indicator
- Actions menu (Edit, View Details, Delete)

**Actions**:
- Create New Series button
- Drag-and-drop reordering (updates display_order)

### Series Detail Page

**Series Header**:
- Series title (editable inline)
- Description (editable inline)
- Year range (editable)
- Public/private toggle
- Featured toggle
- Hidden from gallery toggle

**Groups Section** (Optional):
- List of groups within series
- Create New Group button
- Drag-and-drop reordering
- Edit/delete group actions

**Artworks Section**:
- Artworks within this series
- Organized by group (if groups exist)
- Ungrouped artworks shown separately
- Drag-and-drop to reorder
- Drag-and-drop to assign to groups
- Quick actions (edit, remove from series)

### Create/Edit Series

**Form Fields**:
- Title (required)
- Description (text area, optional)
- Year start (numeric, required)
- Year end (numeric, optional - null means ongoing)
- Public/private toggle
- Featured toggle
- Hidden from gallery toggle
- Display order (auto-set, editable)

**Actions**:
- Cancel / Save

### Create/Edit Group

**Form Fields**:
- Title (required)
- Description (text area, optional)
- Series selection (if creating, disabled if editing)
- Featured toggle
- Hidden from gallery toggle
- Display order (auto-set, editable)

**Actions**:
- Cancel / Save

---

## Portfolio Settings

### Profile Settings

**Artist Information**:
- Full name (required)
- Email (display only, not editable)
- Location (text, optional - e.g., "Portland, Oregon")

**Profile Photo**:
- Upload portrait photo (required)
- Crop/resize tool
- Preview display
- Delete and replace

**Studio Photo** (for About page):
- Upload studio/workspace photo (optional)
- Crop/resize tool
- Preview display
- Delete and replace

**About Content**:
- Biography (text area, third-person)
- Artist statement (text area, first-person)
- Character count indicators

**Education** (optional):
- Add multiple education entries
- Institution name
- Degree/program
- Year
- Reorder entries
- Delete entries

**Awards** (optional):
- Add multiple award entries
- Award title
- Organization
- Year
- Reorder entries
- Delete entries

**Social Links**:
- Website URL
- Instagram URL
- Facebook URL
- Other links (custom label + URL pairs)

**Actions**:
- Save Changes
- Preview Public Profile

### Exhibition Management

**List View**:
- Past exhibitions (chronological, newest first)
- Upcoming exhibitions (highlighted)
- Featured exhibitions (badge indicator)
- Exhibition type badge (Solo, Group, Online)

**Add/Edit Exhibition**:
- Title (required)
- Venue name (required)
- Location (city, state/country)
- Start date (required)
- End date (optional - null for ongoing/TBD)
- Description (text area, optional)
- Exhibition type (dropdown: Solo, Group, Online)
- Featured toggle
- Is upcoming (auto-calculated from dates, editable override)
- Display order

**Exhibition Images** (for featured exhibitions):
- Upload multiple images
- Image captions
- Drag-to-reorder
- Delete images
- Images shown in carousel on public page

**Actions**:
- Cancel / Save
- Delete Exhibition (with confirmation)

### Press Mention Management

**List View**:
- All press mentions (chronological, newest first)
- Featured press (badge indicator)
- Publication name visible
- Published date visible

**Add/Edit Press Mention**:
- Article title (required)
- Publication name (required)
- Published date (required)
- External URL (optional)
- Short excerpt (text area, 100-200 words)
- Long excerpt (text area, 200-300 words for featured)
- Featured toggle
- Display order

**Actions**:
- Cancel / Save
- Delete Press Mention (with confirmation)

### Studio/Process Photo Management

**Grid View**:
- All studio images in grid
- Image captions visible on hover
- Category badges (Studio, Process, Other)
- Drag-to-reorder

**Add Images**:
- Multiple image upload
- Caption for each image (1-2 sentences)
- Category selection (dropdown: Studio, Process, Other)
- Display order (auto-set)

**Edit Image**:
- Update caption
- Update category
- Delete image (with confirmation)

**Page Settings**:
- Intro text (text area, 100 words max, optional)
- Show intro text toggle

### Contact Settings

**Contact Information**:
- Public email (required)
- Phone number (optional)
- Studio location display (optional - different from profile location)
- Studio visits note (optional text)
- Response time note (optional - e.g., "Typically responds within 24 hours")

**Social Media**:
- Instagram URL with visibility toggle
- Facebook URL with visibility toggle
- Twitter URL with visibility toggle
- Website URL with visibility toggle
- LinkedIn URL with visibility toggle
- Pinterest URL with visibility toggle

**Instagram Integration** (optional):
- Connect Instagram account (OAuth flow)
- Manual upload fallback (6-12 images)
- Cache refresh interval setting (1-6 hours)
- Disconnect Instagram option

**Page Customization**:
- Page title (editable, default: "Contact")
- Subtitle (optional)
- Instagram feed visibility toggle

**Live Preview**:
- Preview how Contact page appears to visitors
- Update preview on field changes

**Actions**:
- Save Changes
- Preview Public Page

---

## Public Portfolio Features

### Artist Profile (Landing Page)

**Hero Section**:
- Featured artwork display (large, high-quality)
- Automatic rotation (5-10 seconds if multiple featured)
- Artist name overlay
- Navigation to gallery

**Artist Statement**:
- 2-3 sentence preview
- Link to full About page

**Recent Work**:
- Grid of 4-6 recent public artworks
- Thumbnail images
- Title and year below each
- Click to view in gallery

**Navigation**:
- Fixed/sticky nav bar
- Links to all portfolio pages

**Footer**:
- "Powered by Clay Companion" branding
- Social media links
- Quick links to main pages

### Gallery Page

**Default View**:
- Featured filter (default, shows featured items only)
- Series organization with headers
- Responsive grid layout (4-col desktop, 3-col tablet, 1-2-col mobile)

**Filter Bar**:
- Featured (default)
- All
- Individual series names
- Filter selection updates URL (shareable)

**Series Display**:
- Series header with title and description
- Collapsible sections (user preference saved)
- Grouped artworks (if groups exist)
- Ungrouped artworks shown together

**Artwork Cards**:
- Square thumbnail (1:1 ratio)
- Title and year below
- Hover effect (subtle zoom or overlay)
- Click opens lightbox

**Lightbox**:
- Full-size image (original proportions)
- Image navigation (prev/next)
- Artwork details:
  - Title
  - Year created
  - Description
  - Dimensions
  - Clay type
  - Availability status
- Close button
- Keyboard navigation (arrows, ESC)

**Pagination**:
- Infinite scroll (load 20-30 initially)
- Auto-load more as user scrolls
- Loading indicator

**Sort Order**:
- Newest first (year_created DESC, then created_at DESC)
- Respects display_order within series/groups

### About Page

**Layout**:
- Two-column (desktop): Photos left (30-35%), Text right (65-70%)
- Single-column (mobile): Stacked vertically

**Photos**:
- Portrait photo (required)
- Studio photo (optional)
- High-quality display

**Content Sections**:
- Artist Statement (first-person voice)
- Biography (third-person voice)
- Education (bulleted list, optional)
- Awards (bulleted list, optional)
- Location display

**Typography**:
- Large readable body text (18px+)
- Clear section hierarchy
- 2-3 paragraphs per section (concise)

### Process/Studio Page

**Layout**:
- Responsive grid (3-col desktop, 2-col tablet, 1-col mobile)
- Generous spacing between images

**Intro Text** (optional):
- 100 words max
- Artist's description of their process
- Optional display toggle (set in dashboard)

**Photo Gallery**:
- 10-20 high-quality photos
- Image captions below each (1-2 sentences)
- Category filtering: All / Studio / Process / Other
- Lightbox on click

**Video Embeds** (optional, Post-MVP):
- 2-4 video embeds max
- YouTube or Vimeo support
- Embedded inline in grid

### Exhibitions Page

**Featured Section**:
- 2-3 featured exhibitions (set in dashboard)
- Exhibition title and description
- Horizontal scrolling image carousel:
  - 4-5 images visible (desktop)
  - Arrow controls
  - Click image to open lightbox
  - Smooth scrolling

**History Section**:
- Chronological list (newest first)
- Organized by year
- Sub-organized by type (Solo / Group / Online)
- Text-only display:
  - Exhibition title
  - Venue and location
  - Date range
  - Exhibition type badge
- Click to expand description (optional)

### Press Page

**Featured Section**:
- 2-3 featured articles (set in dashboard)
- Large display with:
  - Publication logo/image (optional)
  - Article title
  - Publication name and date
  - Long excerpt (200-300 words)
  - "Read More" external link button

**History Section**:
- Chronological list (newest first)
- Organized by year
- Text-only display:
  - Article title
  - Publication name
  - Published date
  - "Read Article" external link

### Contact Page

**Contact Card**:
- Public email (required)
- Phone number (optional)
- Studio location (optional)
- Studio visits note (optional)
- Response time note (optional)
- Social media icon links

**Instagram Feed** (optional):
- Grid layout (6-col × 2 rows desktop, 4-col × 3 rows tablet, 2-col × 3 rows mobile)
- Latest 12-18 posts
- Click to open on Instagram (external link)
- Auto-refresh based on cache settings
- Fallback to manual uploads if API fails

**Map Embed** (Post-MVP):
- Studio location on map
- Optional feature for artists who want to show location

---

## Platform Features

### Platform Homepage

**Hero Carousel**:
- Featured artworks from multiple artists
- Artist attribution clickable
- 7-second rotation
- Image quality optimized

**Search & Filters**:
- Real-time search (300ms debouncing)
- Filter by clay type (multi-select)
- Filter by firing type (multi-select)
- Filter by artist name
- Filter by location

**Featured Artists**:
- 3 artist cards with substantial showcase
- Main image + 2-3 thumbnail images
- Artist name and location
- Brief bio preview
- Link to artist portfolio

**Value Proposition**:
- "By artists, for artists" mission statement
- Two-column value prop (For Art Lovers / For Artists)
- Call-to-action buttons

**Artist Directory**:
- Browseable grid (6-col desktop, responsive)
- All platform artists
- Filterable by criteria
- "Load More" pagination
- Artist card: photo, name, location, latest work thumbnail

**Call to Actions**:
- "Explore Artists" button
- "Start Your Portfolio" button (signup)

### Platform About Page

**Hero Section**:
- "By Artists, For Artists" tagline
- Brief platform description
- Primary CTA button

**Content Sections**:
1. What is Clay Companion?
2. Who It's For (two-column: Artists / Art Lovers)
3. Features (8-card grid showcasing key features)
4. How It Works (3-step artist onboarding)
5. Our Story (2-paragraph origin story)
6. Final CTA

**Tone**:
- Authentic and welcoming
- Professional but not corporate
- Concise and scannable

---

## User Experience Features

### Accessibility

**WCAG AA Compliance**:
- 4.5:1 minimum contrast ratios
- Keyboard navigation support
- Screen reader support
- Semantic HTML structure
- Proper heading hierarchy
- ARIA labels on interactive elements
- Focus indicators on all interactive elements
- Alt text on all images

**Form Accessibility**:
- Labels explicitly associated with inputs
- Inline error messages
- Real-time validation feedback
- Error summary on submit failures

**Navigation Accessibility**:
- Skip to main content link
- Keyboard-friendly menus
- Focus trapping in modals
- ESC to close modals/lightboxes

### Loading States

**Visual Feedback**:
- Spinner indicators on buttons during async operations
- Skeleton loaders for page content
- Progress bars for image uploads
- Loading overlays for full-page operations

**Empty States**:
- Helpful messages when no data exists
- Call-to-action buttons to add first item
- Illustrations or icons (optional)

### Error Handling

**User-Friendly Error Messages**:
- Clear description of what went wrong
- Suggested actions to resolve
- Contact support option for critical errors

**Toast Notifications**:
- Success messages (green)
- Error messages (red)
- Warning messages (orange)
- Info messages (blue)
- Auto-dismiss after 5 seconds (closeable manually)

### Responsive Design

**Mobile Optimization**:
- Touch-friendly tap targets (min 44×44px)
- Mobile-optimized navigation (hamburger menu)
- Stacked layouts on mobile
- Responsive images
- Fast load times on mobile networks

**Tablet Optimization**:
- Adaptive layouts (between mobile and desktop)
- Touch and mouse support
- Optimal grid column counts

**Desktop Optimization**:
- Wide layouts for gallery display
- Hover states on interactive elements
- Keyboard shortcuts (optional)

---

## Performance Features

### Image Optimization

**Automatic Processing**:
- Resize to multiple sizes (thumbnail, medium, large, original)
- Format conversion (WebP with fallbacks)
- Compression with quality preservation
- Lazy loading below the fold
- Progressive image loading

**Delivery Optimization**:
- CDN delivery for global speed
- Responsive images (srcset)
- Preloading for critical images
- Cache headers for browser caching

### Page Speed

**Optimization Techniques**:
- Code splitting (load only what's needed)
- Minification of assets
- Gzip/Brotli compression
- Browser caching
- Edge caching for public pages

**Performance Targets**:
- First Contentful Paint < 1.5s
- Time to Interactive < 3s
- Largest Contentful Paint < 2.5s

### SEO Features

**On-Page SEO**:
- Semantic HTML structure
- Meta titles and descriptions
- Open Graph tags for social sharing
- Structured data (Schema.org)
- Clean, descriptive URLs
- XML sitemap generation
- Robots.txt configuration

**Artist Portfolio SEO**:
- Unique meta tags per artist
- Artwork image alt text
- Descriptive page titles
- Internal linking structure

---

## Security Features

### Authentication Security

**Password Security**:
- Secure password hashing
- Password strength requirements
- Rate limiting on login attempts
- Secure password reset flow
- Session token security

**Session Management**:
- Secure session storage
- Session timeout
- Automatic session refresh
- Logout on all devices option (Post-MVP)

### Data Security

**Access Control**:
- Row-level security policies
- Artist can only access their own data
- Public can only view public content
- Protected API routes

**Data Validation**:
- Input sanitization
- SQL injection prevention
- XSS attack prevention
- CSRF token validation

### Privacy

**Data Privacy**:
- Internal notes never exposed publicly
- Private artworks never visible to public
- Email addresses not displayed publicly
- GDPR compliance considerations (Post-MVP)

---

## Post-MVP Features

### E-Commerce Integration
- Shopping cart functionality
- Payment processing
- Order management
- Shipping calculations
- Sales tax handling
- Inventory sync

### Blog System
- Rich text editor
- Blog post categories
- Tags and search
- Comments (optional)
- RSS feed
- Social sharing

### Contact Form & Messaging
- Public contact form
- In-app messaging center for artists
- Spam protection
- File attachments
- Message threading
- Read receipts

### Advanced Customization
- Custom color schemes
- Font selection
- Layout options
- Custom CSS (advanced tier)
- Logo upload
- Custom navigation

### Analytics Dashboard
- Portfolio view statistics
- Artwork view tracking
- Visitor geography
- Referral sources
- Popular artworks
- Engagement metrics

### White-Label / Premium Tier
- Remove "Powered by Clay Companion" branding
- Custom domain support
- Priority support
- Additional storage
- Advanced analytics
- Premium features

### Social Features
- Follow artists
- Like artworks
- Comment on artworks
- Artist-to-artist messaging
- Share to social media

### Mobile App
- iOS and Android apps
- Push notifications
- Offline viewing
- Mobile upload tools

---

## Notes

This document focuses on **what** features do and **how** users interact with them, avoiding implementation-specific details. When building with a new tech stack, use these feature descriptions to guide your implementation choices.

---

**Document Version**: 1.0 (Tech-Agnostic)
**Source Documents**: Extracted from FEATURES.md, DECISIONS.md, wireframe specifications
