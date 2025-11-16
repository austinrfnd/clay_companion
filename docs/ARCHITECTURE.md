# Clay Companion - Architecture Documentation

**Last Updated**: 2025-11-06
**Status**: Foundation Phase - Pre-Implementation

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Core Principles](#core-principles)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Authentication Strategy](#authentication-strategy)
6. [API Design (Future)](#api-design-future)
7. [Database Architecture](#database-architecture)
8. [File Storage](#file-storage)
9. [Background Jobs](#background-jobs)
10. [Infrastructure & Deployment](#infrastructure--deployment)
11. [Security Considerations](#security-considerations)
12. [Performance Optimization](#performance-optimization)
13. [Decision Log](#decision-log)

---

## Architecture Overview

Clay Companion is built as a **Rails Hybrid Monolith** - a single Rails application that serves:

1. **Web Application** (MVP): Server-side rendered UI using Hotwire (Turbo + Stimulus)
2. **JSON API** (Post-MVP): RESTful API for native mobile applications (iOS/Android)

### Architectural Pattern: Majestic Monolith

We chose the monolith approach for several strategic reasons:

- **Faster MVP**: Single codebase accelerates development
- **Shared Logic**: Business rules, models, and validations are reused
- **Easier Debugging**: All code in one place
- **Cost-Effective**: Simpler infrastructure for early stage
- **Future-Ready**: Can be split into microservices if needed

**Key Design Decision**: Build for the web first, make it mobile-ready (not mobile-first). The API namespace is designed but not implemented until mobile apps are validated.

---

## Core Principles

### 1. Artwork-First Philosophy
- Design recedes into the background
- Gallery-like minimalism with generous spacing
- Fast image loading and rendering
- Accessibility for all users

### 2. Test-Driven Development (TDD)
- Write tests before implementation (Red-Green-Refactor)
- Unit tests → Integration tests → E2E tests
- 100% coverage goal for critical paths

### 3. Docker-First Development
- Consistent development environment across machines
- Production-like environment locally
- Easy onboarding for future contributors

### 4. Convention Over Configuration
- Follow Rails conventions strictly
- Use standard Rails patterns and idioms
- Minimize custom abstractions

### 5. Progressive Enhancement
- Server-side rendering first
- Hotwire for SPA-like experience
- JavaScript as enhancement, not requirement

---

## Technology Stack

### Backend Framework
- **Ruby on Rails 7.2+**
  - Why: Mature ecosystem, fast development, great for MVPs
  - Convention over configuration
  - Active Storage for files
  - Action Mailer for emails (post-MVP)

### View Layer
- **Hotwire (Turbo + Stimulus)**
  - **Turbo Drive**: SPA-like navigation without JavaScript
  - **Turbo Frames**: Page fragments that update independently
  - **Turbo Streams**: Real-time updates over WebSockets (future)
  - **Stimulus**: Minimal JavaScript controllers for interactivity

### Database
- **PostgreSQL 15+**
  - Why: Relational data model fits domain perfectly
  - Full-text search capabilities (pg_search)
  - JSON columns for flexible data (artist preferences)
  - Battle-tested with Rails

### Styling
- **Tailwind CSS 3+**
  - Why: Fastest way to implement design system
  - Utility-first approach
  - Excellent purging for production
  - Easy customization for Celadon color palette

### Authentication
- **Devise** (Web sessions)
  - Mature, secure, battle-tested
  - Easy integration with Rails
  - Handles email confirmation, password reset
  - Token auth extension for API (post-MVP)

### File Storage
- **Active Storage** with adapters
  - Development: Local disk
  - Production: Google Cloud Storage (GCS)
  - Handles image variants (thumbnails, crops)
  - Direct uploads (future optimization)

### Testing
- **RSpec** - Test framework
- **Factory Bot** - Test data generation
- **Faker** - Realistic fake data
- **Capybara** - E2E browser testing
- **Shoulda Matchers** - Concise model tests
- **SimpleCov** - Code coverage reports

### Background Jobs (Post-MVP)
- **Sidekiq** with Redis
  - Why deferred: Not needed for MVP (inline processing is fast enough)
  - Future use cases: Email sending, image processing, notifications

---

## Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb          # Base controller (web)
│   │   - before_action :authenticate_artist!
│   │   - Helper methods for flash messages
│   │   - Error handling
│   │
│   ├── home_controller.rb                 # Platform homepage
│   ├── artists_controller.rb              # Public portfolios
│   ├── galleries_controller.rb            # Gallery views
│   │
│   ├── dashboard/                         # Artist dashboard (authenticated)
│   │   ├── artworks_controller.rb
│   │   ├── series_controller.rb
│   │   └── profiles_controller.rb
│   │
│   └── api/                               # Future API namespace
│       ├── base_controller.rb             # API base (token auth)
│       └── v1/
│           ├── artists_controller.rb
│           ├── artworks_controller.rb
│           └── series_controller.rb
│
├── models/
│   ├── artist.rb                          # Artist account
│   ├── artwork.rb                         # Individual ceramic piece
│   ├── series.rb                          # Collection of artworks
│   ├── exhibition.rb                      # Exhibition entry
│   ├── press_item.rb                      # Press mention
│   └── concerns/
│       ├── searchable.rb                  # Full-text search
│       └── sluggable.rb                   # URL-friendly slugs
│
├── services/                              # Business logic layer
│   ├── artwork_creator.rb                 # Artwork creation logic
│   ├── image_processor.rb                 # Image variants & optimization
│   ├── series_organizer.rb                # Series management
│   └── portfolio_generator.rb             # Portfolio caching
│
├── serializers/                           # API responses (future)
│   ├── artist_serializer.rb
│   ├── artwork_serializer.rb
│   └── series_serializer.rb
│
├── views/
│   ├── layouts/
│   │   ├── application.html.erb           # Main layout
│   │   └── dashboard.html.erb             # Dashboard layout
│   │
│   ├── home/
│   │   └── index.html.erb                 # Platform homepage
│   │
│   ├── artists/
│   │   └── show.html.erb                  # Public portfolio
│   │
│   ├── dashboard/
│   │   ├── artworks/
│   │   ├── series/
│   │   └── profiles/
│   │
│   └── shared/
│       ├── _header.html.erb
│       ├── _footer.html.erb
│       └── _flash.html.erb
│
├── javascript/
│   └── controllers/                       # Stimulus controllers
│       ├── gallery_controller.js          # Gallery lightbox
│       ├── dropdown_controller.js         # Dropdown menus
│       └── image_upload_controller.js     # Upload preview
│
└── assets/
    ├── stylesheets/
    │   ├── application.tailwind.css       # Tailwind entry
    │   └── components/                    # Custom components
    └── images/

config/
├── routes.rb                              # URL routing
├── database.yml                           # Database config
├── storage.yml                            # Active Storage adapters
├── tailwind.config.js                     # Tailwind customization
└── environments/
    ├── development.rb
    ├── test.rb
    └── production.rb

spec/
├── models/                                # Unit tests (ActiveRecord)
├── services/                              # Unit tests (business logic)
├── requests/                              # Integration tests (controllers)
├── system/                                # E2E tests (Capybara)
├── factories/                             # Test data factories
└── support/
    ├── factory_bot.rb
    ├── database_cleaner.rb
    └── shoulda_matchers.rb

db/
├── migrate/                               # Database migrations
├── seeds.rb                               # Sample data
└── schema.rb                              # Current schema

requirements/                              # Product requirements (read-only)
docs/                                      # Technical documentation
```

---

## Authentication Strategy

### Web Application (MVP)
**Strategy**: Cookie-based sessions with Devise

**Implementation Status**: ✅ Complete

**Features Implemented**:
- Email/password authentication via Devise
- Email confirmation required (24-hour token expiry)
- Password reset via email (6-hour token expiry)
- Remember me functionality (2 weeks)
- Session timeout (30 minutes)
- Profile setup after email verification
- Custom routes matching wireframe requirements

**Custom Routes** (implemented):
- `GET /login` - Sign in page
- `POST /login` - Authenticate
- `GET /signup` - Registration page
- `POST /signup` - Create account
- `DELETE /logout` - Sign out
- `GET /password/reset` - Request password reset
- `POST /password/reset` - Send reset email
- `GET /password/reset/:token` - Reset password form
- `PATCH /password/reset/:token` - Update password
- `GET /email/verify/:token` - Confirm email
- `GET /email/resend` - Resend confirmation form
- `POST /email/resend` - Resend confirmation email
- `GET /profile_setup` - Profile setup form
- `PATCH /profile_setup` - Save profile

**Custom Controllers**:
- `Artists::SessionsController` - Login/logout with profile completeness redirect
- `Artists::RegistrationsController` - Signup with email verification redirect
- `Artists::PasswordsController` - Password reset with custom routes and expiry checks
- `Artists::ConfirmationsController` - Email verification with profile setup redirect
- `ProfileSetupController` - Profile completion after email verification
- `EmailVerificationController` - Email verification sent page

**Security Features**:
- Password complexity requirements (8-30 chars, uppercase, lowercase, number, special char)
- Email enumeration prevention (same response for valid/invalid emails)
- Secure token generation and expiry (24h confirmation, 6h password reset)
- CSRF protection (Rails default)
- Password hashing via bcrypt (Devise default)
- Secure cookies (httponly, secure in production)

**Email Templates**:
- Branded HTML emails with design system colors
- Table-based layout for email client compatibility
- Inline CSS for maximum compatibility
- Ceramic "C" logo in header
- Confirmation and password reset templates implemented

**Test Coverage**: 90.07% (751 examples, 0 failures)
- Request specs: 735 examples covering all flows
- Controller specs: 111 examples
- Feature specs: 16 examples (11 passing, 5 skipped with detailed notes)
- Mailer specs: 24 examples

See [requirements/auth/auth-development-plan.md](../requirements/auth/auth-development-plan.md) for complete implementation details.

### API (Post-MVP)
**Strategy**: Token-based authentication (JWT or Devise Token Auth)

```ruby
# app/controllers/api/base_controller.rb
module Api
  class BaseController < ActionController::API
    before_action :authenticate_with_token!

    private

    def authenticate_with_token!
      token = request.headers['Authorization']&.split(' ')&.last
      @current_artist = Artist.find_by_token(token)
      render json: { error: 'Unauthorized' }, status: 401 unless @current_artist
    end
  end
end
```

**Routes**:
- `POST /api/v1/auth/login` - Returns JWT token
- `POST /api/v1/auth/register` - Creates account, returns token
- `DELETE /api/v1/auth/logout` - Invalidates token

**Security**:
- JWT with expiration (24 hours)
- Refresh tokens for long-lived sessions
- Rate limiting (rack-attack)
- CORS configuration for mobile apps

---

## API Design (Future)

### REST Principles
- Resource-based URLs (`/api/v1/artworks`, not `/api/v1/get_artworks`)
- HTTP verbs for actions (GET, POST, PUT, DELETE)
- JSON request/response bodies
- Standard HTTP status codes

### Versioning
- URL-based versioning (`/api/v1/...`)
- Allows breaking changes without affecting mobile apps

### Example Endpoints

```
# Artworks
GET    /api/v1/artworks           # List artworks (with pagination)
POST   /api/v1/artworks           # Create artwork
GET    /api/v1/artworks/:id       # Show artwork
PUT    /api/v1/artworks/:id       # Update artwork
DELETE /api/v1/artworks/:id       # Delete artwork

# Series
GET    /api/v1/series             # List series
POST   /api/v1/series             # Create series
GET    /api/v1/series/:id         # Show series with artworks
PUT    /api/v1/series/:id         # Update series
DELETE /api/v1/series/:id         # Delete series

# Profile
GET    /api/v1/profile            # Current artist profile
PUT    /api/v1/profile            # Update profile

# Public endpoints (no auth)
GET    /api/v1/artists/:username  # Public portfolio
GET    /api/v1/discover           # Platform discovery
```

### Response Format

```json
// Success (200 OK)
{
  "data": {
    "id": "123",
    "type": "artwork",
    "attributes": {
      "title": "Celadon Vase",
      "description": "...",
      "year": 2024
    },
    "relationships": {
      "series": { "id": "456" },
      "artist": { "id": "789" }
    }
  }
}

// Error (422 Unprocessable Entity)
{
  "errors": [
    {
      "field": "title",
      "message": "Title can't be blank"
    }
  ]
}
```

### Shared Business Logic

Controllers call the same service objects used by web controllers:

```ruby
# Web controller
class Dashboard::ArtworksController < ApplicationController
  def create
    result = ArtworkCreator.new(current_artist, artwork_params).call
    if result.success?
      redirect_to dashboard_path, notice: "Artwork created"
    else
      render :new, status: :unprocessable_entity
    end
  end
end

# API controller
module Api::V1
  class ArtworksController < Api::BaseController
    def create
      result = ArtworkCreator.new(current_artist, artwork_params).call
      if result.success?
        render json: ArtworkSerializer.new(result.value), status: :created
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end
  end
end
```

---

## Database Architecture

### Schema Overview

See [DATA_MODEL.md](../requirements/DATA_MODEL.md) for complete schema.

**Core Tables**:
- `artists` - Artist accounts and profiles
- `artworks` - Individual ceramic pieces
- `series` - Collections of artworks
- `exhibitions` - Exhibition history
- `press_items` - Press mentions

**Rails Associations**:
- `Artist has_many :artworks`
- `Artist has_many :series`
- `Series has_many :artworks`
- `Artwork belongs_to :artist`
- `Artwork belongs_to :series (optional)`

### Indexing Strategy

```ruby
# Critical indexes for performance
add_index :artworks, :artist_id
add_index :artworks, :series_id
add_index :artworks, [:artist_id, :visibility]
add_index :artists, :username, unique: true
add_index :series, :artist_id
```

### Data Integrity

- Foreign key constraints in database
- `dependent: :destroy` on associations
- Database-level uniqueness constraints
- NOT NULL constraints on critical fields

---

## File Storage

### Active Storage Configuration

```ruby
# config/storage.yml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>

google:
  service: GCS
  project: clay-companion
  credentials: <%= Rails.root.join("config/gcs_credentials.json") %>
  bucket: clay-companion-production
```

### Image Variants

```ruby
# app/models/artwork.rb
class Artwork < ApplicationRecord
  has_many_attached :images

  # Predefined variants for performance
  def thumbnail
    images.first.variant(resize_to_limit: [300, 300])
  end

  def gallery_size
    images.first.variant(resize_to_limit: [800, 800])
  end

  def full_size
    images.first.variant(resize_to_limit: [1600, 1600])
  end
end
```

### Storage Strategy

- **Development**: Local disk (fast, no cost)
- **Test**: Local disk (isolated per test run)
- **Production**: Google Cloud Storage (scalable, CDN-ready)

### Direct Uploads (Future Optimization)

Users upload directly to GCS, bypassing Rails server:
1. Frontend requests signed URL from Rails
2. User uploads to GCS using signed URL
3. Frontend notifies Rails of completion
4. Rails creates Active Storage record

Benefits: Faster uploads, less server load, better UX

---

## Background Jobs

### Current Strategy (MVP)
**No background jobs** - Process inline for simplicity

```ruby
# Inline image processing (fast enough for MVP)
def create
  @artwork = current_artist.artworks.build(artwork_params)
  if @artwork.save
    @artwork.images.each do |image|
      image.variant(resize_to_limit: [800, 800]).processed
    end
    redirect_to dashboard_path
  end
end
```

### Future Strategy (Post-MVP)
**Sidekiq with Redis** when we need:
- Email sending (Action Mailer jobs)
- Image optimization (batch processing)
- Background data exports
- Scheduled jobs (cleanup, notifications)

```ruby
# Future: Background image processing
class ImageProcessorJob < ApplicationJob
  queue_as :default

  def perform(artwork_id)
    artwork = Artwork.find(artwork_id)
    artwork.images.each do |image|
      image.variant(resize_to_limit: [800, 800]).processed
    end
  end
end
```

---

## Infrastructure & Deployment

### Development Environment
**Docker Compose** with:
- `web` - Rails application
- `db` - PostgreSQL 15
- `redis` - Redis 7 (for future Sidekiq)
- `test` - Isolated test environment

### MVP Deployment (Weeks 1-9)
**Railway or Fly.io**

**Why not GCP yet?**
- Faster time to first deployment
- Less infrastructure complexity
- Lower cost for MVP validation
- One-command deployment

**Railway Configuration**:
```
Service: web (Dockerfile)
Database: PostgreSQL addon
Storage: Railway volumes (temporary)
Environment: Production
Cost: ~$10-20/month
```

### Production Deployment (Post-MVP)
**Google Cloud Platform**

When we migrate to GCP:

```
┌─────────────────────────────────────────────┐
│  Google Cloud Run (Rails App)              │
│  - Auto-scaling containers                  │
│  - Scales to zero (cost savings)            │
│  - HTTPS/SSL included                       │
└─────────────────────────────────────────────┘
              │
              ├── Cloud SQL (PostgreSQL)
              │   - Managed database
              │   - Automated backups
              │   - Connection via unix socket
              │
              ├── Cloud Storage (GCS)
              │   - Active Storage backend
              │   - CDN-ready
              │   - Image variants
              │
              ├── Secret Manager
              │   - DATABASE_URL
              │   - RAILS_MASTER_KEY
              │   - API keys
              │
              └── Cloud Build (CI/CD)
                  - Auto-deploy on git push
                  - Run migrations
                  - Build Docker image
                  - Deploy to Cloud Run
```

**CI/CD Pipeline** (Cloud Build):
```yaml
# cloudbuild.yaml
steps:
  # Build Docker image
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/clay-companion', '.']

  # Push to Artifact Registry
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/clay-companion']

  # Run database migrations
  - name: 'gcr.io/cloud-builders/gcloud'
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        gcloud run jobs execute rails-migrate \
          --region us-central1 \
          --wait

  # Deploy to Cloud Run
  - name: 'gcr.io/cloud-builders/gcloud'
    args:
      - 'run'
      - 'deploy'
      - 'clay-companion'
      - '--image=gcr.io/$PROJECT_ID/clay-companion'
      - '--region=us-central1'
      - '--platform=managed'
```

---

## Security Considerations

### Authentication & Authorization
- ✅ Password hashing (bcrypt via Devise)
- ✅ CSRF protection (Rails default)
- ✅ Session security (httponly, secure cookies)
- ✅ Authorization checks (every controller action)

### Input Validation
- ✅ Strong parameters (Rails default)
- ✅ Model validations (presence, format, length)
- ✅ File type validation (images only)
- ✅ File size limits (max 10MB per image)

### SQL Injection
- ✅ Parameterized queries (ActiveRecord default)
- ✅ Never use string interpolation in queries

### XSS Protection
- ✅ HTML escaping (ERB default)
- ✅ Content Security Policy headers
- ✅ Sanitize user input (ActionText for rich text)

### File Upload Security
- ✅ Validate file types (Active Storage validations)
- ✅ Virus scanning (future: ClamAV integration)
- ✅ Direct uploads to GCS (bypass server)

### API Security (Future)
- ✅ JWT token expiration
- ✅ Rate limiting (rack-attack)
- ✅ CORS configuration (mobile apps only)
- ✅ API key rotation strategy

### Infrastructure Security
- ✅ Secrets in Secret Manager (not code)
- ✅ Environment variable injection
- ✅ Least privilege IAM roles
- ✅ VPC for database (GCP)
- ✅ SSL/TLS everywhere

---

## Performance Optimization

### Database
- Eager loading (`includes`) to avoid N+1 queries
- Proper indexing on foreign keys
- Database-level constraints for integrity
- Connection pooling (Puma default)

### Caching (Future)
- Fragment caching for public portfolios
- Russian Doll caching for nested resources
- HTTP caching headers (ETags)
- Redis for cache store (post-MVP)

### Image Optimization
- Active Storage variants (lazy generation)
- Progressive JPEG encoding
- WebP format for modern browsers
- Lazy loading with Intersection Observer

### Frontend Performance
- Turbo Drive for instant navigation
- Turbo Frames for partial updates
- Minimal JavaScript (Stimulus only)
- Tailwind purging (production builds)

### Monitoring (Future)
- Exception tracking (Sentry or Rollbar)
- Performance monitoring (Scout APM or New Relic)
- Database query analysis (Bullet gem)
- Uptime monitoring (UptimeRobot)

---

## Decision Log

### 2025-11-06: Initial Architecture Decisions

**Decision: Rails Hybrid Monolith**
- Reasoning: Fastest path to MVP while keeping mobile option open
- Alternatives considered: Next.js (too complex), Laravel (less familiar)
- Trade-offs: Monolith complexity grows, but acceptable for this domain

**Decision: Hotwire over React/Vue**
- Reasoning: SSR-first, minimal JS, aligns with "artwork-first" philosophy
- Alternatives considered: Inertia.js, ViewComponent + Stimulus
- Trade-offs: Less interactive than SPA, but acceptable for portfolio use case

**Decision: PostgreSQL over MySQL**
- Reasoning: Better full-text search, JSON support, ActiveRecord compatibility
- Alternatives considered: MySQL (slightly faster writes), SQLite (too limited)
- Trade-offs: None significant

**Decision: Docker-first development**
- Reasoning: Consistent environments, easier onboarding, production-like setup
- Alternatives considered: Local Ruby installation (fragile), Vagrant (outdated)
- Trade-offs: Docker Desktop resource usage, but acceptable for modern machines

**Decision: TDD-first approach**
- Reasoning: Critical for long-term maintainability, prevents regressions
- Alternatives considered: Test-after (faster initially but costlier long-term)
- Trade-offs: Slower initial development, but higher quality and fewer bugs

**Decision: Railway/Fly.io for MVP, GCP later**
- Reasoning: Fastest deployment, lowest complexity, defer GCP until validated
- Alternatives considered: Heroku (expensive), AWS (complex), GCP immediately (overkill)
- Trade-offs: Migration effort later, but acceptable given uncertainty

**Decision: No background jobs for MVP**
- Reasoning: Inline processing is fast enough, reduces infrastructure complexity
- Alternatives considered: Sidekiq from day one (premature optimization)
- Trade-offs: Slower requests for image processing, but acceptable for MVP scale

**Decision: Defer native mobile apps to post-MVP**
- Reasoning: Validate product with web first, avoid 3x codebase complexity
- Alternatives considered: Mobile-first (wrong audience), React Native (adds complexity)
- Trade-offs: No app store presence initially, but web is sufficient for artists

---

## Future Considerations

### Scaling Strategy (When Needed)
1. Add caching layer (Redis)
2. Background jobs for async processing
3. CDN for static assets and images
4. Read replicas for database
5. Horizontal scaling (multiple Rails instances)

### Microservices (If Needed)
Potential extraction candidates:
- Image processing service
- Search service (Elasticsearch)
- Notification service
- Analytics service

**When to extract**: When a service becomes a bottleneck or requires different scaling characteristics.

### Alternative Architectures (Not Chosen)
- **JAMstack** (Next.js + headless CMS): Too complex for MVP
- **Microservices**: Premature for a portfolio platform
- **Serverless**: Rails not well-suited, cold start issues
- **Native mobile-first**: Wrong audience (artists prefer desktop)

---

## References

- **Product Requirements**: [requirements/](../requirements/)
- **Data Model**: [requirements/DATA_MODEL.md](../requirements/DATA_MODEL.md)
- **Features**: [requirements/FEATURES.md](../requirements/FEATURES.md)
- **Design System**: [requirements/DESIGN_SYSTEM.md](../requirements/DESIGN_SYSTEM.md)
- **Rails Guides**: https://guides.rubyonrails.org/
- **Hotwire Handbook**: https://hotwired.dev/
- **Tailwind Docs**: https://tailwindcss.com/

---

**This is a living document.** Update it as architectural decisions evolve.
