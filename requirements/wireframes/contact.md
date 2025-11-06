# Contact Page - Wireframe

**URL**: `claycompanion.com/artist-name/contact`

**Purpose**: Display contact information for visitors to get in touch with the artist, plus showcase recent Instagram activity

---

## Key Design Decisions

1. **Layout Style**: Centered single-column with contact card + Instagram feed grid below
2. **Content Display**: Contact information display only (no form in MVP)
3. **Contact Methods**: Email, phone (optional), studio location (optional), social media links
4. **Instagram Integration**: Grid of recent Instagram posts (6-12 posts) below contact info
5. **Privacy**: Email as clickable mailto link (spam protection via encoding), phone optional
6. **Social Media**: Icon links to artist's social profiles
7. **Post-MVP**: Contact form with in-app messaging center

---

## Desktop Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  Artist Name / Logo        Gallery  About  Process  Exhibitions  Press      │
│                                                  Techniques  Contact          │
│  (Navigation Bar - Fixed/Sticky)                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                               │
│                                                                               │
│                           GET IN TOUCH                                        │
│                                                                               │
│                       I'd love to hear from you                               │
│                                                                               │
│                                                                               │
│                  ┌─────────────────────────────────┐                          │
│                  │                                 │                          │
│                  │  ✉  Email                       │                          │
│                  │     hello@sarahmartinez.com     │                          │
│                  │     (clickable mailto link)     │                          │
│                  │                                 │                          │
│                  │  ──────────────────────────────  │                          │
│                  │                                 │                          │
│                  │  📞 Phone (Optional)            │                          │
│                  │     (555) 123-4567              │                          │
│                  │                                 │                          │
│                  │  ──────────────────────────────  │                          │
│                  │                                 │                          │
│                  │  📍 Studio Location (Optional)  │                          │
│                  │     Red Hook, Brooklyn, NY      │                          │
│                  │     Studio visits by            │                          │
│                  │     appointment only            │                          │
│                  │                                 │                          │
│                  │  ──────────────────────────────  │                          │
│                  │                                 │                          │
│                  │  🔗 Follow Me                   │                          │
│                  │                                 │                          │
│                  │     [IG] [FB] [TW] [WEB]        │                          │
│                  │     (Social media icon links)   │                          │
│                  │                                 │                          │
│                  │  ──────────────────────────────  │                          │
│                  │                                 │                          │
│                  │  Response Time                  │                          │
│                  │  I typically respond within     │                          │
│                  │  2-3 business days.             │                          │
│                  │                                 │                          │
│                  └─────────────────────────────────┘                          │
│                                                                               │
│                                                                               │
│  ─────────────────────────────────────────────────────────────────────────── │
│                                                                               │
│                                                                               │
│                       RECENT ON INSTAGRAM                                     │
│                         @sarahmartinez                                        │
│                                                                               │
│                                                                               │
│    ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐        │
│    │       │  │       │  │       │  │       │  │       │  │       │        │
│    │ Post  │  │ Post  │  │ Post  │  │ Post  │  │ Post  │  │ Post  │        │
│    │   1   │  │   2   │  │   3   │  │   4   │  │   5   │  │   6   │        │
│    │       │  │       │  │       │  │       │  │       │  │       │        │
│    └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘        │
│                                                                               │
│    ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐        │
│    │       │  │       │  │       │  │       │  │       │  │       │        │
│    │ Post  │  │ Post  │  │ Post  │  │ Post  │  │ Post  │  │ Post  │        │
│    │   7   │  │   8   │  │   9   │  │   10  │  │   11  │  │   12  │        │
│    │       │  │       │  │       │  │       │  │       │  │       │        │
│    └───────┘  └───────┘  └───────┘  └───────┘  └───────┘  └───────┘        │
│                                                                               │
│                                                                               │
│                        [View More on Instagram →]                             │
│                                                                               │
│                                                                               │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  Footer (Light grey background #f8f9fa)                                      │
│  Contact | Social Links | Copyright | "Powered by Clay Companion"           │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Tablet Layout (768px - 1024px)

```
┌────────────────────────────────────────────────────────┐
│  Artist Name                             ☰ Menu         │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│                                                          │
│              GET IN TOUCH                                │
│                                                          │
│          I'd love to hear from you                       │
│                                                          │
│      ┌──────────────────────────────────────┐           │
│      │                                      │           │
│      │  ✉  Email                            │           │
│      │     hello@sarahmartinez.com          │           │
│      │                                      │           │
│      │  ─────────────────────────────────   │           │
│      │                                      │           │
│      │  📞 Phone (Optional)                 │           │
│      │     (555) 123-4567                   │           │
│      │                                      │           │
│      │  ─────────────────────────────────   │           │
│      │                                      │           │
│      │  📍 Studio Location (Optional)       │           │
│      │     Red Hook, Brooklyn, NY           │           │
│      │     Studio visits by appointment     │           │
│      │                                      │           │
│      │  ─────────────────────────────────   │           │
│      │                                      │           │
│      │  🔗 Follow Me                        │           │
│      │                                      │           │
│      │     [IG] [FB] [TW] [WEB]             │           │
│      │                                      │           │
│      │  ─────────────────────────────────   │           │
│      │                                      │           │
│      │  Response Time                       │           │
│      │  I typically respond within          │           │
│      │  2-3 business days.                  │           │
│      │                                      │           │
│      └──────────────────────────────────────┘           │
│                                                          │
│  ──────────────────────────────────────────────────────  │
│                                                          │
│              RECENT ON INSTAGRAM                         │
│                @sarahmartinez                            │
│                                                          │
│      ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                │
│      │Post │  │Post │  │Post │  │Post │                │
│      │  1  │  │  2  │  │  3  │  │  4  │                │
│      └─────┘  └─────┘  └─────┘  └─────┘                │
│                                                          │
│      ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                │
│      │Post │  │Post │  │Post │  │Post │                │
│      │  5  │  │  6  │  │  7  │  │  8  │                │
│      └─────┘  └─────┘  └─────┘  └─────┘                │
│                                                          │
│      ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                │
│      │Post │  │Post │  │Post │  │Post │                │
│      │  9  │  │  10 │  │  11 │  │  12 │                │
│      └─────┘  └─────┘  └─────┘  └─────┘                │
│                                                          │
│          [View More on Instagram →]                      │
│                                                          │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│  Footer                                                  │
└────────────────────────────────────────────────────────┘
```

---

## Mobile Layout (< 768px)

```
┌──────────────────────────────┐
│  Artist Name         ☰       │
└──────────────────────────────┘

┌──────────────────────────────┐
│                              │
│     GET IN TOUCH             │
│                              │
│  I'd love to hear from you   │
│                              │
│  ┌────────────────────────┐  │
│  │                        │  │
│  │  ✉  Email              │  │
│  │     hello@             │  │
│  │     sarahmartinez.com  │  │
│  │                        │  │
│  │  ────────────────────  │  │
│  │                        │  │
│  │  📞 Phone (Optional)   │  │
│  │     (555) 123-4567     │  │
│  │                        │  │
│  │  ────────────────────  │  │
│  │                        │  │
│  │  📍 Studio Location    │  │
│  │     Red Hook,          │  │
│  │     Brooklyn, NY       │  │
│  │     Visits by appt     │  │
│  │                        │  │
│  │  ────────────────────  │  │
│  │                        │  │
│  │  🔗 Follow Me          │  │
│  │                        │  │
│  │  [IG] [FB] [TW] [WEB]  │  │
│  │                        │  │
│  │  ────────────────────  │  │
│  │                        │  │
│  │  Response Time         │  │
│  │  I typically respond   │  │
│  │  within 2-3 business   │  │
│  │  days.                 │  │
│  │                        │  │
│  └────────────────────────┘  │
│                              │
│  ──────────────────────────  │
│                              │
│   RECENT ON INSTAGRAM        │
│     @sarahmartinez           │
│                              │
│  ┌───────┐  ┌───────┐        │
│  │ Post  │  │ Post  │        │
│  │   1   │  │   2   │        │
│  └───────┘  └───────┘        │
│                              │
│  ┌───────┐  ┌───────┐        │
│  │ Post  │  │ Post  │        │
│  │   3   │  │   4   │        │
│  └───────┘  └───────┘        │
│                              │
│  ┌───────┐  ┌───────┐        │
│  │ Post  │  │ Post  │        │
│  │   5   │  │   6   │        │
│  └───────┘  └───────┘        │
│                              │
│  [View More on Instagram →]  │
│                              │
└──────────────────────────────┘

┌──────────────────────────────┐
│  Footer                      │
└──────────────────────────────┘
```

---

## Content Sections

### 1. Page Header

- **Page Title**: "GET IN TOUCH" or "Contact"
- **Subtitle**: Optional personalized message (e.g., "I'd love to hear from you")
- **Placement**: Centered above contact information card
- **Typography**: Large, clear heading consistent with other pages

### 2. Contact Information Card

- **Container**: Centered card with padding and subtle background/border
- **Max Width**: ~600px for readability
- **Sections** (all optional based on artist preference):

#### Email (Required)

- Icon + "Email" label
- Email address as clickable mailto link
- Spam protection: Encode email in frontend (prevent scraping)
- Styling: Clear, prominent display

#### Phone (Optional)

- Icon + "Phone" label
- Phone number with formatting (e.g., "(555) 123-4567")
- Clickable tel: link on mobile devices
- Can be hidden if artist prefers email only

#### Studio Location (Optional)

- Icon + "Studio Location" label
- City/neighborhood or full address (artist's choice)
- Optional note: "Studio visits by appointment only"
- Option to include Google Maps embed (post-MVP consideration)

#### Social Media (Optional)

- "Follow Me" or "Connect" section header
- Icon buttons/links to social profiles
- Supported platforms: Instagram, Facebook, Twitter/X, Personal Website, LinkedIn, Pinterest
- Open in new tab
- Icons styled consistently with site design

#### Response Time Note (Optional)

- Small informational text
- Example: "I typically respond within 2-3 business days."
- Sets expectations for visitors
- Friendly, personalized tone

### 3. Instagram Feed Section

- **Section Header**: "RECENT ON INSTAGRAM" or "FOLLOW ALONG ON INSTAGRAM"
- **Username Display**: @username (clickable link to Instagram profile)
- **Grid Layout**:
  - Desktop: 6 columns × 2 rows = 12 posts
  - Tablet: 4 columns × 3 rows = 12 posts
  - Mobile: 2 columns × 3 rows = 6 posts
- **Image Cards**:
  - Square aspect ratio (1:1)
  - Hover effect on desktop (slight zoom or overlay with Instagram icon)
  - Click opens Instagram post in new tab
  - No captions shown in grid (keep it clean)
- **Call to Action**: "View More on Instagram →" button below grid
- **Fallback**: If no Instagram URL or feed unavailable, hide this section

---

## Typography & Styling

### Text Hierarchy

- Page title: 36-48px, bold, centered
- Subtitle: 18-20px, regular, centered, muted color
- Section labels: 16-18px, semi-bold
- Contact details: 18-20px, regular
- Instagram header: 24-28px, bold, centered
- Username: 16-18px, regular, accent color
- Response note: 14-16px, muted color

### Spacing

- Generous vertical spacing between sections
- Clear visual separation with dividers (subtle borders or whitespace)
- Card padding: 3-4rem on desktop, 2rem on mobile
- Section divider: 4-6rem between contact card and Instagram grid
- Grid gap: 1rem between Instagram posts

### Colors

- Text: Dark grey/black for readability
- Labels: Semi-bold, slightly darker
- Icons: Accent color matching site theme
- Links: Accent color, hover state
- Card background: White or very light grey
- Instagram section: Light background or white

### Icons

- Use consistent icon set (e.g., Lucide, Heroicons)
- Size: 20-24px
- Color: Accent color or muted
- Placement: Left of labels or inline

---

## Instagram Feed Integration

### Implementation Options

#### Option A: Instagram Basic Display API (Recommended for MVP)

- **Pros**: Official API, reliable, no rate limiting concerns
- **Cons**: Requires Instagram Business/Creator account, OAuth flow
- **Data**: Recent posts, images, captions, post URLs
- **Frequency**: Fetch on server-side, cache for 1-6 hours

#### Option B: Third-Party Service (Juicer, Snapwidget, etc.)

- **Pros**: Easy to implement, handles auth and caching
- **Cons**: Monthly cost, less control, external dependency
- **Data**: Embed widget or API access
- **Frequency**: Real-time or cached by service

#### Option C: Manual Curation (Fallback)

- **Pros**: Full control, no API needed
- **Cons**: Manual work for artist, not real-time
- **Data**: Artist uploads images manually via dashboard
- **Frequency**: Artist updates as needed

### Recommended Approach for MVP

1. **If artist has Instagram Business account**: Use Instagram Basic Display API
2. **If not**: Manual curation fallback (artist uploads 6-12 images to showcase)
3. **Post-MVP**: Consider third-party service or more advanced Instagram API integration

### Data to Display

- Post image (square crop)
- Link to Instagram post
- Username (once, above grid)
- No captions, no likes/comments (keep it visual and clean)

### Caching Strategy

- Server-side fetch: Every 1-6 hours
- Store in database or cache layer (Redis)
- Fallback to last successful fetch if API fails

### Error Handling

- If Instagram feed fails to load: Hide section gracefully
- If no Instagram URL: Don't show section at all
- Loading state: Show skeleton grid while fetching

---

## Database Schema

### Existing Table: `artist_profile`

**Fields Already Available**:

- `email` (string, required) - Primary contact email
- `phone` (string, optional) - Phone number
- `instagram_url` (string, optional) - Instagram profile URL
- `facebook_url` (string, optional) - Facebook profile
- `website_url` (string, optional) - Personal website
- `location` (string, optional) - City/neighborhood

**New Fields Needed**:

- `studio_location_display` (string, optional) - Formatted location text for contact page
- `studio_visits_note` (text, optional) - Note about studio visits (e.g., "By appointment only")
- `response_time_note` (text, optional) - Expected response time message
- `twitter_url` (string, optional) - Twitter/X profile
- `linkedin_url` (string, optional) - LinkedIn profile
- `pinterest_url` (string, optional) - Pinterest profile
- `instagram_access_token` (text, optional) - Encrypted access token for Instagram API
- `instagram_user_id` (string, optional) - Instagram user ID for API calls
- `show_instagram_feed` (boolean, default: true) - Toggle to show/hide Instagram section

### New Table (Optional): `instagram_feed_cache`

For caching Instagram feed data:

- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key to artist_profile)
- `post_data` (jsonb) - Array of post objects (image_url, post_url, timestamp)
- `fetched_at` (timestamp) - Last successful fetch
- `created_at` (timestamp)
- `updated_at` (timestamp)

---

## Privacy & Spam Protection

### Email Protection Strategies (MVP)

1. **Obfuscation**: Encode email in JavaScript to prevent scraping
2. **Mailto Link**: Direct mailto (simple, standard)
3. **Copy Button**: Optional "Copy to Clipboard" feature

### Instagram API Privacy

- Access token stored encrypted in database
- Refresh token flow for long-term access
- Artist can revoke access anytime via dashboard

### Post-MVP: Contact Form

- Replaces or supplements direct email display
- Backend validation and spam filtering
- Rate limiting to prevent abuse
- In-app messaging center for artist to manage inquiries
- Captcha or honeypot fields

---

## Content Management (Dashboard)

### Portfolio Settings > Contact Information

Artist can manage:

- ✓ Email address (required)
- ✓ Phone number (optional, toggle visibility)
- ✓ Studio location text (optional)
- ✓ Studio visits note (optional)
- ✓ Response time note (optional)
- ✓ Social media URLs (optional, multiple platforms)
- ✓ Instagram feed: Connect account OR manually upload images
- ✓ Show/hide Instagram feed section

### Visibility Toggles

- Show/hide phone number on public contact page
- Show/hide studio location
- Show/hide social media section
- Show/hide Instagram feed section

### Instagram Feed Management

Two approaches:

1. **Connect Instagram**: OAuth flow to connect Instagram Business account
2. **Manual Upload**: Upload 6-12 images to display as "Recent Work" (fallback if no Instagram)

---

## User Flow

### Visitor Journey

1. Visitor clicks "Contact" in navigation
2. Page loads with centered contact information card
3. Visitor sees email, phone (if provided), location (if provided), social media links
4. Visitor scrolls down to see Instagram feed
5. Visitor clicks Instagram post → Opens post on Instagram in new tab
6. OR visitor clicks email link → Opens email client
7. OR visitor clicks social media icon → Opens profile in new tab

### Artist Journey (Dashboard)

1. Artist navigates to Settings > Contact Information
2. Artist enters/updates contact details
3. Artist toggles visibility for optional fields
4. Artist connects Instagram account OR uploads manual images
5. Artist saves changes
6. Public contact page updates immediately

---

## Accessibility Considerations

- **Semantic HTML**: Use proper heading hierarchy
- **Link Descriptions**: Clear aria-labels for icon links and Instagram posts
- **Keyboard Navigation**: All links and buttons accessible via keyboard
- **Focus States**: Visible focus indicators
- **Color Contrast**: WCAG AA compliant
- **Screen Readers**: Alt text for icons and Instagram images, descriptive labels
- **Loading States**: Announce loading/loaded states for Instagram feed

---

## Performance Considerations

- **Instagram Image Optimization**: Use Next.js Image component for Instagram thumbnails
- **Lazy Loading**: Instagram feed loads below the fold (lazy load images)
- **Caching**: Server-side cache Instagram feed (1-6 hours)
- **CDN**: Serve Instagram images via proxy/CDN if possible
- **Minimal Assets**: SVG icons, optimized images
- **Fast Load Time**: Target < 2 seconds load (including Instagram feed)

---

## Design Inspiration & References

### Common Patterns from Ceramic Artist Sites

- Simple, centered contact information
- Email as primary contact method
- Optional phone and studio location
- Social media icons prominently displayed
- Instagram feed increasingly common on contact/about pages
- No complex forms in MVP (common for artist sites)

### Best Practices

- Clear, easy-to-find contact information
- Mobile-friendly tap targets for phone/email
- Friendly, approachable tone
- Set expectations (response time)
- Multiple contact options (email, social, phone)
- Visual engagement via Instagram feed
- Seamless integration with Instagram to drive traffic

---

## Future Enhancements (Post-MVP)

1. **Contact Form**
   - Fields: Name, Email, Subject, Message
   - Backend validation and spam protection
   - In-app messaging center for artist
   - Email notifications for new inquiries

2. **Google Maps Integration**
   - Embed map showing studio location
   - Toggleable/collapsible
   - Privacy controls (exact vs. approximate location)

3. **Enhanced Instagram Integration**
   - Show captions on hover
   - Display likes/comments count
   - Filter posts by hashtag
   - Lightbox view within page (no redirect to Instagram)

4. **Inquiry Categories**
   - Commission requests
   - Purchase inquiries
   - Press/media inquiries
   - General questions

5. **Automated Responses**
   - Auto-reply email with expected response time
   - Out-of-office messages

6. **Copy to Clipboard**
   - One-click copy email address
   - Success toast notification

7. **WhatsApp Integration**
   - Optional WhatsApp contact button
   - Click-to-chat functionality

8. **Multi-Platform Feeds**
   - Option to show Facebook or Pinterest feeds
   - Aggregated social feed from multiple platforms

---

## Implementation Notes

### Frontend (Next.js)

- **Page Component**: `app/[artistName]/contact/page.tsx`
- **Data Fetching**: Server component fetching artist contact info + cached Instagram feed
- **Email Obfuscation**: Use base64 encoding or simple JS function to hide email from scrapers
- **Social Icons**: Use Lucide or Heroicons for consistency
- **Instagram Grid**: Responsive CSS Grid layout with Next.js Image for optimization

### Backend (Supabase)

- **Query**: Select contact fields from `artist_profile` table
- **Instagram API**: Server-side function to fetch Instagram feed (cron job or on-demand with cache)
- **Privacy**: Only return fields where visibility toggle is enabled
- **Caching**: Static generation for public contact page (revalidate on artist update or hourly for Instagram feed)

### Instagram API Integration

- **API**: Instagram Basic Display API or Instagram Graph API
- **Auth Flow**: OAuth in dashboard settings, store access token securely
- **Fetch Strategy**: Server-side API route, cache in database or Redis
- **Fallback**: Manual image upload if API not connected

### Styling (Tailwind CSS)

- Centered layout using flexbox
- Card component from shadcn/ui
- Responsive design with mobile-first approach
- CSS Grid for Instagram feed (6-col, 4-col, 2-col)
- Smooth transitions on hover states

---

## Testing Checklist

### Functionality

- [ ] Email mailto link works correctly
- [ ] Phone tel: link works on mobile
- [ ] Social media links open in new tabs
- [ ] All links have correct URLs
- [ ] Email obfuscation prevents scraping
- [ ] Instagram posts open correct URLs in new tabs
- [ ] Instagram feed loads and displays correctly
- [ ] Instagram feed hides gracefully if unavailable

### Responsive Design

- [ ] Layout adapts correctly on mobile (<768px) - 2-col Instagram grid
- [ ] Layout adapts correctly on tablet (768-1024px) - 4-col Instagram grid
- [ ] Layout looks good on desktop (>1024px) - 6-col Instagram grid
- [ ] Touch targets are 44x44px minimum on mobile
- [ ] Instagram images maintain aspect ratio

### Accessibility

- [ ] Keyboard navigation works
- [ ] Focus states are visible
- [ ] Screen reader can read all content
- [ ] Color contrast meets WCAG AA
- [ ] All icons have aria-labels
- [ ] Instagram images have descriptive alt text

### Performance

- [ ] Instagram images are optimized
- [ ] Lazy loading works for below-fold Instagram feed
- [ ] Page loads in < 2 seconds
- [ ] Instagram feed cache works correctly

### Cross-Browser

- [ ] Works in Chrome, Firefox, Safari, Edge
- [ ] Mobile browsers (iOS Safari, Chrome)

---

## Open Questions

### Decisions Needed

1. **Instagram API vs. Manual Upload**: Default approach for MVP?
   - **Recommendation**: Support both. Offer Instagram API connection with manual upload fallback.

2. **Instagram Post Count**: 6, 9, or 12 posts?
   - **Recommendation**: 12 posts (6-col × 2 rows on desktop, 4-col × 3 rows on tablet, 2-col × 3 rows on mobile = 6 visible on mobile)

3. **Instagram Section Placement**: Above or below contact card?
   - **Recommendation**: Below contact card (contact info is primary, Instagram is supplementary)

4. **Map Integration**: Include Google Maps embed in MVP or wait for post-MVP?
   - **Recommendation**: Wait for post-MVP (keeps it simple)

5. **Email Copy Button**: Add "Copy to Clipboard" button in MVP?
   - **Recommendation**: Wait for post-MVP (nice-to-have, not essential)

6. **Response Time Field**: Required or optional?
   - **Recommendation**: Optional (not all artists may want to commit to a response time)

7. **Social Media Limit**: How many social platforms to support?
   - **Recommendation**: Support 6-8 major platforms (Instagram, Facebook, Twitter/X, LinkedIn, Pinterest, Personal Website, YouTube, TikTok)

---

## Summary

**Contact Page MVP Approach**:

- Simple, clean display of contact information
- Email as primary contact method
- Optional phone, location, and social media
- **Instagram feed grid** (6-12 recent posts) for visual engagement
- Instagram API integration with manual upload fallback
- No contact form (post-MVP feature)
- Fully responsive and accessible
- Easy for artists to manage via dashboard
- Minimal database schema changes

**Key Philosophy**: Keep it simple for MVP while adding visual interest via Instagram feed. Direct email contact is standard for artist portfolios and reduces complexity. Instagram integration drives engagement and showcases recent work. Contact form with messaging center is a valuable post-MVP enhancement.

**Visual Hierarchy**:

1. Contact information (primary)
2. Instagram feed (secondary, adds engagement)
3. Social links (integrated in contact card)
