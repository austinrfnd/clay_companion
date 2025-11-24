# Clay Companion - Post-MVP Features

This document outlines features and improvements planned for phases after the initial MVP launch. These are organized by feature area and priority.

## Quick Links to Feature Areas

- **Process/Studio Page**: See [`wireframes/process-studio.md`](wireframes/process-studio.md#post-mvp-features)
- **Gallery Page**: See [`wireframes/gallery.md`](wireframes/gallery.md)
- **Artist Profile**: See [`wireframes/artist-profile.md`](wireframes/artist-profile.md)
- **Dashboard Settings**: See [`wireframes/dashboard/`](wireframes/dashboard/)
- **Authentication**: See [`wireframes/auth/AUTH_FLOWS.md`](wireframes/auth/AUTH_FLOWS.md)

---

## Process/Studio Page Features

### Phase 1: Configurable Grid Layout

**Description**: Allow artists to customize which images appear larger in the masonry grid layout.

**User Story**: As an artist, I want to highlight certain behind-the-scenes photos by making them larger, creating a more dynamic visual composition.

**Implementation**:
- Add `grid_size` column to `studio_images` table
  ```sql
  ALTER TABLE studio_images ADD COLUMN grid_size VARCHAR(10) DEFAULT 'normal';
  ```
- Enum values: `normal` (4-col / 1/3 width), `large` (6-col / 1/2 width), `hero` (6-col + 2-row span)

**Dashboard Changes**:
- Add size selector in studio settings page (dropdown or button toggle)
- Preview grid layout in real-time as artists change sizes
- Show constraint warnings (e.g., "hero images should be spaced out")

**Frontend Changes**:
- Update gallery grid CSS to read `data-grid-size` attribute
- Dynamically adjust grid spans based on image configuration

**Database Migration**:
- Create migration to add column with default value
- No data loss - existing images default to 'normal'

**Effort**: Small (1-2 hours)

**Priority**: Medium (nice-to-have, improves customization)

---

### Phase 2: Process Videos Section

**Description**: Allow artists to embed YouTube/Vimeo videos alongside photos.

**User Story**: As a potter, I want to embed videos of my throwing technique, glazing process, and kiln firing to show visitors how I work.

**Implementation**:
- Add `process_videos` table OR extend `studio_images` with `category: 'video'`
  ```sql
  -- Option A: Separate table
  CREATE TABLE process_videos (
    id UUID PRIMARY KEY,
    artist_id UUID FOREIGN KEY,
    video_url VARCHAR(500),
    caption TEXT,
    display_order INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
  );

  -- Option B: Extend existing table
  ALTER TABLE studio_images ADD COLUMN media_type VARCHAR(10) DEFAULT 'image';
  -- Values: 'image', 'youtube', 'vimeo'
  ALTER TABLE studio_images ADD COLUMN video_url VARCHAR(500);
  ```

**Dashboard Changes**:
- Add "Process Videos" section in studio settings
- Video URL input (YouTube or Vimeo)
- Caption field
- Remove video button
- Drag-to-reorder videos

**Frontend Changes**:
- Detect video URLs and embed responsive iframes
- Show video thumbnails in gallery
- Lightbox support for video playback

**Database Migration**:
- Create new table or extend existing table (recommend separate table for clarity)

**Effort**: Medium (2-3 hours)

**Priority**: Medium (requested feature, enhances storytelling)

---

### Phase 3: Gallery Filtering

**Description**: Allow visitors to filter process/studio photos by category (Studio/Process/Other).

**User Story**: As a visitor, I want to filter photos to see only the studio workspace or only the process/making photos.

**Implementation**:
- Add filter buttons above gallery: All | Studio | Process | Other
- Filter uses existing `category` field on `studio_images`
- JavaScript-based filtering (no page reload)

**Frontend Changes**:
- Add filter UI component
- Implement filter state management
- Show count of images in each category
- Smooth fade in/out animations on filter

**No Database Changes Needed**:
- Uses existing `category` field

**Effort**: Small (1-2 hours)

**Priority**: Low (nice-to-have, improves UX)

---

## Dashboard / Studio Settings

### Phase 1: Bulk Image Organization

**Description**: Improved tools for managing many photos at once.

**Features**:
- Multi-select images for batch operations (change category, delete, hide)
- Bulk category assignment
- Bulk export as ZIP
- Search/filter images in dashboard

**Effort**: Medium (2-3 hours)

**Priority**: Medium (needed as more images are uploaded)

---

### Phase 2: Image Optimization & CDN

**Description**: Optimize image delivery for performance.

**Features**:
- Automatic image resizing for different viewport sizes
- WebP format generation with JPEG fallback
- Lazy loading for gallery images
- CDN integration (e.g., Cloudflare, AWS CloudFront)
- Image compression on upload

**Effort**: Medium-Large (3-5 hours depending on CDN choice)

**Priority**: Medium (improves performance, especially mobile)

---

## Artist Profile & General Features

### Phase 1: Custom Domain Support

**Description**: Allow artists to use their own domain for their portfolio.

**Example**: `www.artistname.com` instead of `claycompanion.com/artistname`

**Implementation**:
- Add `custom_domain` field to `artists` table
- DNS CNAME pointing to Clay Companion servers
- SSL certificate management per domain
- Hostname routing in Rails

**Effort**: Large (5-8 hours)

**Priority**: Medium (premium feature, could be paid add-on)

---

### Phase 2: Analytics Dashboard

**Description**: Show artists metrics about their portfolio visitors.

**Metrics**:
- Page views over time
- Top viewed photos
- Visitor location (geographic)
- Traffic sources (referrers)
- Device types

**Implementation**:
- Add analytics tracking to portfolio pages
- Create analytics dashboard view in settings
- Integrate with Google Analytics or Plausible

**Effort**: Medium (2-3 hours)

**Priority**: Low-Medium (improves retention, supports engagement)

---

### Phase 3: Email Notifications

**Description**: Notify artists of portfolio activities.

**Notifications**:
- New inquiry/contact form submission
- Profile view milestones (100 views, 1000 views)
- Feedback on portfolio
- New followers (if social features added later)

**Effort**: Small-Medium (1-2 hours)

**Priority**: Low (engagement feature)

---

## Admin / Backend Features

### Phase 1: Admin Dashboard

**Description**: Create admin interface for managing site-wide operations.

**Features**:
- View all artists and portfolios
- Suspend/unsuspend accounts
- View traffic and usage statistics
- Manage feature flags
- View error logs

**Effort**: Large (4-6 hours)

**Priority**: High (needed for production management)

---

### Phase 2: Export & Backup

**Description**: Allow artists to export their portfolio data and images.

**Features**:
- Export portfolio as ZIP (HTML + images)
- Export data as JSON/CSV
- Download backup of all images

**Use Case**: Artist wants to move away from Clay Companion or have local backup

**Effort**: Medium (2-3 hours)

**Priority**: Medium (user empowerment, reduces lock-in concern)

---

## Feed Features (Post-MVP Phase)

### Phase 0: User Posts - Create & Share

**Description**: Allow users to create and publish posts to the feed, with optional photo attachments. Posts can be separate from their main portfolio work.

**Features**:
- **Create Posts**: Text-based posts with optional photo attachments
  - Rich text editor or simple textarea
  - Drag-and-drop or click-to-upload photos
  - Multiple photo support per post
  - Photo ordering/reordering
  - Optional captions for photos

- **Post Visibility**: Control who can see posts
  - Public (visible to all on feed)
  - Followers only
  - Private/draft (not published)

- **Post Management**:
  - Edit own posts
  - Delete own posts
  - Pin/feature post option (maybe?)
  - Post preview before publishing

- **Post Display**: Show posts in feed with:
  - Author info and timestamp
  - Post content
  - Photo carousel/gallery
  - Like/comment count indicators

**User Stories**:
- As an artist, I want to share behind-the-scenes moments and thoughts outside my main portfolio
- As a visitor, I want to see what artists are working on and thinking about in real-time
- As a user, I want to easily add photos to my posts
- As a user, I want to control who sees my posts

**Implementation Considerations**:
- Create `posts` table (user_id, content, visibility, created_at, updated_at)
- Create `post_attachments` table (post_id, image_url, caption, display_order)
- Image storage (S3/similar) for post photos
- Feed query to pull posts ordered by created_at
- Optional: hashtags (#), mentions (@) in posts

**Database Migrations**:
- Create posts table with visibility enum (public, followers_only, private)
- Create post_attachments table for photos
- Index on (user_id, created_at) for efficient feed queries
- Index on visibility for feed filtering

**Frontend Changes**:
- Post creation modal/form
- Photo upload component with preview
- Post card component showing content + photos
- Post edit/delete actions

**Effort**: Medium (3-4 hours)

**Priority**: High - This is foundational to a social feed experience

**Dependencies**: User authentication, feed page/API

---

### Phase 1: Feed Engagement - Comments, Likes, Re-posting, Reporting

**Description**: Add social engagement features to the feed to encourage interaction and community building.

**Features**:
- **Comments**: Allow visitors to leave comments on feed posts
  - Nested/threaded replies support
  - Comment moderation (artist can delete/approve)
  - Edit/delete own comments

- **Likes**: Simple like/heart button on posts
  - Like count display
  - Show who liked (expand list)
  - Unlike functionality

- **Re-posting**: Allow sharing posts to broader audience
  - Re-post button on feed items
  - Attribution to original poster
  - Comments on re-posts

- **Reporting**: Flag inappropriate content
  - Report modal with reason selection
  - Admin review of reports
  - Take down/hide reported content
  - Reporter confidentiality

**User Stories**:
- As a visitor, I want to engage with artist work through likes and comments
- As a visitor, I want to share interesting work with my followers
- As an artist, I want to moderate comments on my posts
- As a community member, I want to report inappropriate content

**Implementation Considerations**:
- Add `likes` table (user_id, post_id, created_at)
- Add `comments` table (user_id, post_id, parent_comment_id, content, created_at)
- Add `reposts` table (user_id, original_post_id, created_at)
- Add `reports` table (user_id, post_id, reason, status, admin_notes, created_at)
- Notification system for comments/likes on own posts (see Email Notifications phase)
- Rate limiting to prevent spam/abuse

**Database Migrations**:
- Create likes table with indexes on (post_id, user_id)
- Create comments table with foreign keys and nested reply support
- Create reposts table with attribution
- Create reports table for moderation

**Frontend Changes**:
- Add engagement buttons to feed post cards
- Comment section component (expandable)
- Report modal with form
- Like count and "who liked" viewer

**Effort**: Large (6-8 hours for all 4 features)

**Priority**: TBD - Core to feed experience but may impact MVP scope

**Dependencies**: Feed MVP, User authentication

---

## Social & Community Features (Post-MVP Phase)

### Phase 1: Social Sharing

**Description**: Make it easy for visitors to share artist portfolios.

**Features**:
- Social media share buttons (Instagram, Facebook, Twitter, Pinterest)
- Pre-filled social captions
- Share individual images
- Generate shareable links

**Effort**: Small (1-2 hours)

**Priority**: Medium (drives traffic, builds community)

---

### Phase 2: Artist Directory / Discovery

**Description**: Help visitors discover artists on the platform.

**Features**:
- Public directory of artists
- Search by name, location, specialty
- Featured artists
- Browse by ceramic type (functional, sculptural, etc.)

**Effort**: Large (4-6 hours)

**Priority**: Low-Medium (growth feature, needed after sufficient artist base)

---

### Phase 3: Artist Collaboration / Collections

**Description**: Allow multiple artists to collaborate on shared portfolios.

**Use Case**: Pottery co-op, artist collective, artist residency

**Features**:
- Invite collaborators to portfolio
- Role-based permissions (view, edit, publish)
- Shared portfolio page
- Individual artist pages within collection

**Effort**: Large (5-8 hours)

**Priority**: Low (nice-to-have for specific use cases)

---

## Mobile & Performance

### Phase 1: Progressive Web App (PWA)

**Description**: Make the app work offline and installable on mobile.

**Features**:
- Service worker for offline access
- Install to home screen
- Push notifications (optional)

**Effort**: Medium (2-3 hours)

**Priority**: Low (nice-to-have, improves mobile experience)

---

### Phase 2: Mobile App (iOS/Android)

**Description**: Native mobile apps for easier portfolio browsing.

**Approach**: Flutter or React Native for code sharing

**Effort**: Very Large (15-20 hours)

**Priority**: Very Low (defer to much later, assess market demand first)

---

## Payment & Monetization (If Applicable)

### Phase 1: Premium Features

**Description**: Offer paid tiers with additional features.

**Possible Premium Features**:
- Custom domain
- Advanced analytics
- Video hosting (unlimited)
- Image storage (unlimited)
- Priority support

**Effort**: Large (6-10 hours)

**Priority**: Depends on business model (defer if free-only)

---

## Summary Table

| Feature | Phase | Effort | Priority | Dependencies |
|---------|-------|--------|----------|--------------|
| Configurable Grid Layout | 1 | Small | Medium | None |
| Process Videos | 2 | Medium | Medium | None |
| Gallery Filtering | 3 | Small | Low | None |
| Bulk Image Organization | 1 | Medium | Medium | Dashboard |
| Image Optimization & CDN | 2 | M-L | Medium | None |
| Custom Domain Support | 1 | Large | Medium | Infrastructure |
| Analytics Dashboard | 2 | Medium | Low-Med | Analytics service |
| Email Notifications | 3 | Small | Low | Email service |
| Admin Dashboard | 1 | Large | High | None |
| Export & Backup | 2 | Medium | Medium | None |
| Social Sharing | 1 | Small | Medium | None |
| Artist Directory | 2 | Large | Low-Med | Search/indexing |
| Artist Collaboration | 3 | Large | Low | Auth/permissions |
| PWA | 1 | Medium | Low | None |
| Native Mobile App | - | Very Large | Very Low | PWA (prereq) |
| Premium Features | - | Large | Depends | Payments integration |

---

## Notes

- **MVP Focus**: Core portfolio functionality, artist settings, public pages
- **Phase 1 Candidates**: Features that enhance core experience without adding complexity
- **Future Assessment**: Regularly assess user feedback to prioritize post-MVP work
- **Platform Viability**: Some features (custom domains, analytics) may become high-priority based on user feedback
- **Resource Constraints**: Prioritize based on team capacity and business goals

---

**Document Status**: Living document - update as priorities change
**Last Updated**: 2025-11-22
