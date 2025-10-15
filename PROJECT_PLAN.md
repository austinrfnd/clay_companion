# Clay Companion - Project Plan

## Overview
Clay Companion is a web application for ceramic artists to catalog their work internally and showcase it publicly through a portfolio website.

**Target User**: Single ceramic artist or artist shop
**MVP Scope**: Internal cataloging system + public portfolio (no e-commerce, no blog, no contact form in MVP)

---

## Tech Stack

### Frontend & Backend
- **Next.js 14+** (App Router)
  - Server-side rendering for web app
  - Serverless-ready
  - API routes built-in (for future mobile app)
- **TypeScript** - Type safety and better developer experience
- **React Hook Form** - Form handling and validation
- **Tailwind CSS** - Utility-first styling
- **shadcn/ui** - Accessible, customizable component library

### Database & Storage
- **Supabase**
  - PostgreSQL database
  - Authentication (email/password)
  - File storage for images
  - Row-level security
  - Auto-generated APIs
  - **Development**: Using Supabase cloud during development (can migrate to local setup later)

### Image Handling
- **Next.js Image Component** - Automatic optimization
- **Supabase Storage** - Image hosting and CDN
- **react-dropzone** - Drag-and-drop file uploads

### Deployment
- **Vercel** - Serverless deployment, automatic CI/CD

---

## Database Schema

### Tables

#### `artist_profile`
- `id` (uuid, primary key)
- `email` (text, unique)
- `full_name` (text)
- `bio` (text)
- `artist_statement` (text)
- `profile_photo_url` (text)
- `studio_photo_url` (text, nullable) - Studio/workspace image for About page
- `location` (text, nullable) - City, State/Country (e.g., "Brooklyn, New York")
- `education` (jsonb, nullable) - Array of education entries for About page
- `awards` (jsonb, nullable) - Array of awards/recognition entries for About page
- `contact_email` (text)
- `contact_phone` (text)
- `website_url` (text)
- `instagram_url` (text)
- `facebook_url` (text)
- `other_links` (jsonb)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `series`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `title` (text)
- `description` (text)
- `year_start` (integer)
- `year_end` (integer, nullable)
- `display_order` (integer)
- `is_public` (boolean, default false)
- `is_featured` (boolean, default false) - Show in featured gallery section
- `is_hidden_from_gallery` (boolean, default false) - Hide from public gallery view
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `artwork_groups`
- `id` (uuid, primary key)
- `series_id` (uuid, foreign key → series)
- `title` (text)
- `description` (text)
- `display_order` (integer)
- `is_featured` (boolean, default false) - Show in featured gallery section
- `is_hidden_from_gallery` (boolean, default false) - Hide from public gallery view
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `artworks`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `series_id` (uuid, foreign key → series, nullable)
- `group_id` (uuid, foreign key → artwork_groups, nullable)
- `title` (text)
- `description` (text)
- `clay_type` (text)
- `firing_cone` (text)
- `firing_schedule` (text)
- `internal_notes` (text)
- `dimensions` (text, e.g., "10" x 8" x 6"")
- `weight` (text)
- `year_created` (integer)
- `is_public` (boolean, default false)
- `is_featured` (boolean, default false) - Show in featured gallery section
- `is_hidden_from_gallery` (boolean, default false) - Hide from public gallery view
- `availability_status` (text: available/sold/commissioned/not_for_sale)
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `artwork_images`
- `id` (uuid, primary key)
- `artwork_id` (uuid, foreign key → artworks)
- `image_url` (text)
- `caption` (text, nullable)
- `display_order` (integer)
- `is_primary` (boolean, default false)
- `created_at` (timestamp)

#### `exhibitions`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `title` (text)
- `venue` (text)
- `location` (text)
- `start_date` (date)
- `end_date` (date, nullable)
- `description` (text)
- `is_upcoming` (boolean)
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `press_mentions`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `title` (text)
- `publication` (text)
- `url` (text, nullable)
- `published_date` (date)
- `excerpt` (text, nullable)
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

#### `studio_images`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `image_url` (text)
- `caption` (text)
- `category` (text: studio/process/other)
- `display_order` (integer)
- `created_at` (timestamp)

#### `techniques`
- `id` (uuid, primary key)
- `artist_id` (uuid, foreign key → artist_profile)
- `name` (text)
- `description` (text)
- `display_order` (integer)
- `created_at` (timestamp)
- `updated_at` (timestamp)

---

## Project Structure

```
clay_companion/
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   │   ├── login/
│   │   │   │   └── page.tsx
│   │   │   └── layout.tsx
│   │   ├── (dashboard)/
│   │   │   ├── dashboard/
│   │   │   │   └── page.tsx          # Dashboard home
│   │   │   ├── catalog/
│   │   │   │   ├── page.tsx          # List all artworks
│   │   │   │   ├── [id]/
│   │   │   │   │   └── page.tsx      # View/edit artwork
│   │   │   │   └── new/
│   │   │   │       └── page.tsx      # Add new artwork
│   │   │   ├── series/
│   │   │   │   ├── page.tsx          # List series
│   │   │   │   ├── [id]/
│   │   │   │   │   └── page.tsx      # View/edit series
│   │   │   │   └── new/
│   │   │   │       └── page.tsx      # Add new series
│   │   │   ├── portfolio-settings/
│   │   │   │   ├── page.tsx          # Manage public portfolio
│   │   │   │   ├── profile/
│   │   │   │   ├── exhibitions/
│   │   │   │   ├── press/
│   │   │   │   ├── studio/
│   │   │   │   └── techniques/
│   │   │   ├── settings/
│   │   │   │   └── page.tsx          # Account settings
│   │   │   └── layout.tsx            # Dashboard layout
│   │   ├── (public)/
│   │   │   ├── page.tsx              # Public homepage/landing
│   │   │   ├── gallery/
│   │   │   │   └── page.tsx          # Public gallery
│   │   │   ├── about/
│   │   │   │   └── page.tsx          # About page
│   │   │   ├── process/
│   │   │   │   └── page.tsx          # Studio/process page
│   │   │   ├── exhibitions/
│   │   │   │   └── page.tsx          # Exhibitions page
│   │   │   ├── press/
│   │   │   │   └── page.tsx          # Press mentions
│   │   │   └── contact/
│   │   │       └── page.tsx          # Contact info
│   │   ├── api/
│   │   │   ├── artworks/
│   │   │   ├── series/
│   │   │   ├── upload/
│   │   │   └── [...]/
│   │   ├── layout.tsx                # Root layout
│   │   └── globals.css
│   ├── components/
│   │   ├── ui/                       # shadcn/ui components
│   │   ├── dashboard/
│   │   │   ├── artwork-form.tsx
│   │   │   ├── series-form.tsx
│   │   │   ├── image-uploader.tsx
│   │   │   ├── drag-drop-reorder.tsx
│   │   │   └── [...]/
│   │   ├── portfolio/
│   │   │   ├── gallery-grid.tsx
│   │   │   ├── image-lightbox.tsx
│   │   │   ├── hero-section.tsx
│   │   │   └── [...]/
│   │   └── shared/
│   │       ├── navbar.tsx
│   │       ├── footer.tsx
│   │       └── [...]/
│   ├── lib/
│   │   ├── supabase/
│   │   │   ├── client.ts             # Client-side Supabase
│   │   │   ├── server.ts             # Server-side Supabase
│   │   │   └── queries/
│   │   │       ├── artworks.ts
│   │   │       ├── series.ts
│   │   │       └── [...]/
│   │   ├── utils/
│   │   │   ├── cn.ts                 # Class name utility
│   │   │   ├── format.ts
│   │   │   └── [...]/
│   │   └── types/
│   │       ├── database.ts           # Database types
│   │       └── [...]/
│   └── styles/
│       └── globals.css
├── public/
│   ├── images/
│   └── [...]/
├── supabase/
│   ├── migrations/
│   └── config.toml
├── .env.local
├── .gitignore
├── next.config.js
├── package.json
├── tailwind.config.js
├── tsconfig.json
└── README.md
```

---

## Features Breakdown

### MVP Features

#### Internal Catalog (Dashboard)
1. **Authentication**
   - Login page (email/password)
   - Session management
   - Protected routes

2. **Artwork Management**
   - Create artwork with full metadata
   - Upload multiple images per artwork
   - Edit/delete artwork
   - Organize by series and groups
   - Search/filter catalog
   - Drag-and-drop image reordering
   - Toggle public/private visibility
   - Mark availability status

3. **Series Management**
   - Create/edit/delete series
   - Organize artworks into series
   - Create sub-groups within series
   - Reorder series

4. **Portfolio Settings**
   - Manage artist profile
   - Pin/feature artworks for homepage
   - Add exhibitions
   - Add press mentions
   - Upload studio/process photos
   - Add techniques/materials info
   - Reorder all public content

#### Public Portfolio
1. **Homepage**
   - Hero section with featured artwork
   - Brief artist intro
   - Navigation to other sections

2. **Gallery**
   - Grid view of public artworks
   - Filter by series
   - Image lightbox with details
   - High-quality image zoom

3. **About**
   - Artist bio
   - Artist statement
   - Artist photo

4. **Process/Studio**
   - Studio photos
   - Process documentation
   - Behind-the-scenes content

5. **Exhibitions**
   - Past exhibitions
   - Upcoming exhibitions
   - Details and descriptions

6. **Press**
   - Media mentions
   - Articles/reviews
   - Links to external content

7. **Techniques & Materials**
   - Educational content
   - Clay types used
   - Firing methods
   - Artist's techniques

8. **Contact**
   - Display contact information
   - Social media links
   - Commission information

---

## Development Phases

### Phase 1: Setup & Foundation (Week 1)
- [ ] Initialize Next.js project
- [ ] Set up Tailwind CSS
- [ ] Install shadcn/ui
- [ ] Set up Supabase project
- [ ] Create database schema
- [ ] Set up authentication
- [ ] Create basic layout components

### Phase 2: Internal Catalog - Core (Week 2-3)
- [ ] Build artwork CRUD operations
- [ ] Implement image upload to Supabase Storage
- [ ] Create artwork form with all metadata fields
- [ ] Build series management
- [ ] Implement artwork listing/search

### Phase 3: Internal Catalog - Advanced (Week 4)
- [ ] Implement drag-and-drop reordering
- [ ] Add group management within series
- [ ] Build public/private toggle
- [ ] Add availability status management
- [ ] Implement featured/pinned functionality

### Phase 4: Portfolio Settings (Week 5)
- [ ] Artist profile management
- [ ] Exhibitions CRUD
- [ ] Press mentions CRUD
- [ ] Studio images upload/management
- [ ] Techniques management
- [ ] Content reordering interfaces

### Phase 5: Public Portfolio (Week 6-7)
- [ ] Homepage with featured work
- [ ] Gallery page with filtering
- [ ] Image lightbox/zoom
- [ ] About page
- [ ] Process/Studio page
- [ ] Exhibitions page
- [ ] Press page
- [ ] Techniques page
- [ ] Contact page

### Phase 6: Polish & Testing (Week 8)
- [ ] Mobile responsiveness
- [ ] Performance optimization
- [ ] Image optimization
- [ ] SEO optimization
- [ ] User testing
- [ ] Bug fixes

### Phase 7: Deployment (Week 9)
- [ ] Set up Vercel project
- [ ] Environment variables configuration
- [ ] Deploy to production
- [ ] Custom domain setup (if needed)
- [ ] Final testing on production

---

## Post-MVP Features (Future)

1. **Blog System**
   - Create/edit blog posts
   - Rich text editor
   - Image embedding
   - Categories/tags

2. **Contact Form & Messaging**
   - Contact form on public site
   - In-app messaging center
   - Email notifications
   - Inquiry management

3. **E-commerce**
   - Pricing for artworks
   - Shopping cart
   - Payment integration (Stripe)
   - Order management
   - Shipping integration

4. **Advanced Customization**
   - Theme customization
   - Custom colors/fonts
   - Layout options
   - Multiple portfolio templates

5. **Multi-artist Platform**
   - Artist onboarding
   - Individual artist subdomains
   - Platform homepage with featured artists
   - Artist discovery/search

6. **Analytics**
   - View tracking
   - Popular artworks
   - Visitor insights
   - Conversion tracking

7. **Commissions System**
   - Commission request form
   - Project management
   - Client communication
   - Progress updates

8. **Mobile App**
   - React Native mobile app
   - Consumes Next.js API routes
   - Same authentication (Supabase)
   - Mobile-optimized catalog management
   - Portfolio viewing on mobile

---

## Architecture Notes

### Mobile App Integration (Post-MVP)
The current Next.js setup supports future mobile app development:
- **Web app**: Uses Server-Side Rendering (SSR) for public pages and dashboard
- **API Routes**: Next.js `/api` endpoints return JSON for mobile consumption
- **Shared Backend**: Both web and mobile use the same Supabase database
- **Authentication**: Supabase auth works across web and mobile

Example flow:
- Web app: Server Components fetch data directly from Supabase
- Mobile app: Calls `/api/artworks` which returns JSON from Supabase

---

## Technical Considerations

### Performance
- Image lazy loading
- Optimize images with Next.js Image component
- Database query optimization
- Caching strategy

### Security
- Row-level security in Supabase
- Proper authentication checks
- Secure file uploads
- Input validation

### SEO
- Metadata for all public pages
- Open Graph tags for social sharing
- Sitemap generation
- Structured data for artworks

### Accessibility
- Keyboard navigation
- ARIA labels
- Alt text for all images
- Color contrast compliance

---

## Next Steps

1. Review and approve this plan
2. Set up local development environment
3. Initialize Next.js project
4. Set up Supabase
5. Start Phase 1 development
