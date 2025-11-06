# Clay Companion

A portfolio platform for ceramic artists to showcase their work, manage their catalog, and connect with art enthusiasts.

## Project Overview

Clay Companion is a **Rails monolith** built with **Hotwire** for server-side rendering, designed to serve both a web application and a future mobile app API. The platform allows ceramic artists to create beautiful, gallery-like portfolios with minimal friction.

**Current Status**: Implementation Phase - Setting up foundation with Docker-first, TDD-first approach

## Quick Links

### Requirements & Design (Tech-Agnostic)
- **[Requirements Index](requirements/README.md)** - Complete documentation overview
- **[Product Overview](requirements/PRODUCT_OVERVIEW.md)** - Vision, goals, MVP scope (~6,900 words)
- **[Features Specification](requirements/FEATURES.md)** - Detailed feature specs (~8,200 words)
- **[User Flows](requirements/USER_FLOWS.md)** - User journeys and interactions (~6,800 words)
- **[Data Model](requirements/DATA_MODEL.md)** - Database schema and relationships (~9,500 words)
- **[Page Structure](requirements/PAGE_STRUCTURE.md)** - URLs, navigation, IA (~6,300 words)
- **[Design System](requirements/DESIGN_SYSTEM.md)** - Visual design specifications (~10,500 words)
- **[Migration Guide](requirements/MIGRATION_GUIDE.md)** - Tech stack analysis and roadmap (~7,800 words)
- **[Wireframes](requirements/wireframes/)** - UI mockups for all pages (10 wireframes)

### Technical Documentation
- **[Architecture Decisions](docs/ARCHITECTURE.md)** - Rails stack, infrastructure, and design patterns
- **[Development Guide](docs/DEVELOPMENT.md)** - Docker setup, TDD workflow, and commands
- **[Code Quality Standards](docs/CODE_QUALITY.md)** - Ruby/Rails best practices and conventions
- **[API Documentation](docs/API.md)** - API endpoints for future mobile apps (Post-MVP)

## Tech Stack

### Chosen Stack (Finalized)

**Backend**
- Ruby on Rails 7.2+
- PostgreSQL 15+
- Active Storage with Google Cloud Storage
- Hotwire (Turbo + Stimulus) for web UI

**Frontend**
- Server-Side Rendering (SSR) with ERB/Slim
- Tailwind CSS for styling
- Stimulus controllers for interactivity
- Turbo for SPA-like navigation

**Infrastructure**
- Docker Compose for local development
- Railway/Fly.io for MVP deployment
- Google Cloud Platform for production (post-MVP)

**Testing**
- RSpec for unit and integration tests
- Factory Bot for test data
- Capybara for E2E tests (post-feature)
- TDD-first approach enforced

**Future (Post-MVP)**
- Native mobile apps (iOS/Android) consuming JSON API
- Sidekiq for background jobs
- Full GCP migration (Cloud Run, Cloud SQL, Cloud Storage)

## Design System Summary

Clay Companion follows an **"Artwork-First"** philosophy with gallery-like minimalism:

### Colors
- **Primary**: Celadon Green `#6E9180`
- **Buttons**: Celadon Dark `#527563` (WCAG AA compliant)
- **Text**: Charcoal `#1F2421`, Slate `#5C6C62`
- **Backgrounds**: Misty White `#F8FAF9`, White `#FFFFFF`
- **Semantic**: Success `#0D8F68`, Error `#C73030`, Warning `#D68500`, Info `#2563EB`

### Typography
- **Font**: Inter (Google Fonts)
- **Weights**: 400, 500, 600, 700
- **Scale**: 12px to 48px

### Spacing
- **Base unit**: 4px
- **Gallery gaps**: 40px (generous spacing for artwork)

See [DESIGN_SYSTEM.md](requirements/DESIGN_SYSTEM.md) for complete specifications.

## MVP Scope

**Included in MVP** (Weeks 1-9):
- ✅ Artist authentication (email/password)
- ✅ Dashboard: Catalog, Series, Settings
- ✅ Public portfolio: Gallery, About, Process, Exhibitions, Press, Contact
- ✅ Image upload and management
- ✅ Series organization with groups
- ✅ Public/private/featured visibility controls
- ✅ Platform homepage with discovery

**Post-MVP** (Do NOT implement yet):
- ❌ Native mobile apps (iOS/Android)
- ❌ Social sharing features
- ❌ Analytics dashboard
- ❌ Advanced search filters
- ❌ Email notifications
- ❌ Comments/feedback system

## Getting Started

### Prerequisites
- Docker Desktop installed
- Git
- Code editor (VS Code recommended)

### Initial Setup

```bash
# Clone the repository
git clone <repository-url>
cd clay_companion

# Build and start containers
docker-compose up -d

# Create database
docker-compose exec web bundle exec rails db:create db:migrate

# Run seeds (optional)
docker-compose exec web bundle exec rails db:seed

# Access application
open http://localhost:3000
```

See [DEVELOPMENT.md](docs/DEVELOPMENT.md) for detailed setup and workflow instructions.

### Running Tests

```bash
# Run all tests
docker-compose run --rm test bundle exec rspec

# Run specific test file
docker-compose run --rm test bundle exec rspec spec/models/artist_spec.rb

# Run tests in watch mode
docker-compose exec web bundle exec guard
```

## Development Workflow

This project follows **strict Test-Driven Development (TDD)**:

1. **Write failing unit/integration tests first** (use `test-driven-development` Claude skill)
2. **See tests fail** (Red)
3. **Write minimal implementation code** (Green)
4. **See tests pass**
5. **Refactor** if needed
6. **E2E tests** added after feature completion

See [DEVELOPMENT.md](docs/DEVELOPMENT.md) for detailed TDD workflow.

## Project Structure

```
clay_companion/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb    # Web controllers
│   │   └── api/v1/                      # API controllers (future)
│   ├── models/                          # Shared models
│   ├── services/                        # Business logic
│   ├── serializers/                     # API serializers (future)
│   └── views/                           # Hotwire views
├── requirements/                        # Product requirements (tech-agnostic)
├── docs/                                # Technical documentation
├── spec/                                # RSpec tests
│   ├── models/                          # Unit tests
│   ├── requests/                        # Integration tests
│   ├── system/                          # E2E tests
│   └── factories/                       # Test data factories
├── docker-compose.yml                   # Development environment
├── Dockerfile.dev                       # Development container
└── README.md                            # This file
```

## Implementation Roadmap

### Phase 1: Foundation (Weeks 1-2) 🚧 Current
- [x] Requirements finalized
- [x] Tech stack selected
- [x] Docker development environment ✅
- [x] Rails app initialized ✅
- [ ] RSpec configured with TDD workflow
- [ ] Tailwind CSS + Design system setup
- [ ] Database schema created
- [ ] Artist authentication (Devise)

### Phase 2: Core Features (Weeks 3-5)
- [ ] Artist profile management
- [ ] Artwork CRUD operations
- [ ] Image upload with Active Storage
- [ ] Series management
- [ ] Visibility controls (public/private/featured)

### Phase 3: Public Portfolio (Weeks 6-7)
- [ ] Public artist landing page
- [ ] Gallery view
- [ ] About, Process, Exhibitions pages
- [ ] Contact form
- [ ] Platform homepage with discovery

### Phase 4: Polish & Launch (Weeks 8-9)
- [ ] Accessibility audit (WCAG AA)
- [ ] Mobile responsiveness testing
- [ ] Performance optimization
- [ ] Production deployment
- [ ] E2E test suite

### Phase 5: Post-MVP
- [ ] Background jobs (Sidekiq)
- [ ] API namespace for mobile apps
- [ ] Native mobile apps (iOS/Android)
- [ ] GCP migration
- [ ] Advanced features (analytics, social, etc.)

## Code Quality Standards

### Mandatory Requirements

**Documentation**
- ✅ Every file must have a header comment explaining its purpose
- ✅ Every public method must have a comment describing what it does
- ✅ Complex private methods should have comments
- ✅ Use YARD format for method documentation

**Internationalization (i18n)**
- ✅ NO hardcoded strings in views or controllers
- ✅ ALL user-facing text must be in `config/locales/*.yml`
- ✅ Use `t('key')` helper for translations
- ✅ Organize keys by namespace (e.g., `artworks.show.title`)

**HTML Test Attributes**
- ✅ ALL interactive elements must have `data-test-id` attributes
- ✅ Use format: `{resource}-{element}-{type}` (e.g., `artwork-submit-button`)
- ✅ Required for: form inputs, buttons, links, modals, navigation
- ✅ Makes tests resilient to CSS/i18n changes

**Ruby/Rails Best Practices**
- ✅ Follow Rails conventions strictly
- ✅ Use strong parameters in controllers
- ✅ Keep controllers thin (business logic in services/models)
- ✅ Single Responsibility Principle (SRP)
- ✅ DRY (Don't Repeat Yourself)
- ✅ Avoid N+1 queries (use `includes`, `eager_load`)
- ✅ Use scopes for common queries
- ✅ Validate at model level
- ✅ Use database constraints for data integrity

**Testing**
- ✅ Write tests before implementation (TDD)
- ✅ Test happy path and edge cases
- ✅ Test validations, associations, and methods
- ✅ Use descriptive test names
- ✅ 90%+ code coverage goal

**Security**
- ✅ Never trust user input
- ✅ Use strong parameters
- ✅ Sanitize HTML output
- ✅ No SQL injection (use parameterized queries)
- ✅ No hardcoded credentials (use environment variables)

**Accessibility**
- ✅ WCAG AA compliance minimum
- ✅ Semantic HTML
- ✅ ARIA labels where needed
- ✅ Keyboard navigation support
- ✅ Focus indicators visible

See [CODE_QUALITY.md](docs/CODE_QUALITY.md) for complete standards and examples.

## Contributing

This is a solo project, but the requirements are structured for collaboration:

1. Read relevant requirement docs before implementing features
2. Follow TDD workflow strictly
3. Use exact design system values (colors, fonts, spacing)
4. Write tests for all new functionality
5. Ensure accessibility compliance
6. Document all code (YARD format)
7. Use i18n for all user-facing text

## License

[To be determined]

## Contact

Austin Fonacier - [Your contact info]

---

**Ready to build?** Start with [DEVELOPMENT.md](docs/DEVELOPMENT.md) for setup instructions, then check the [requirements folder](requirements/) for feature specifications.
