# Rails-Specific Setup Information

This document contains Rails-specific technical details for developers. For general project documentation, see the main [README.md](README.md).

## Ruby Version

- **Ruby**: 3.3.0 (with YJIT enabled)
- **Rails**: 7.2.3
- **Bundler**: 2.5.6

## System Dependencies

The Docker development environment includes:

### Alpine Linux Packages
- `build-base` - C compiler and build tools
- `postgresql-dev` - PostgreSQL client libraries (v15)
- `postgresql-client` - PostgreSQL command-line tools
- `nodejs` - JavaScript runtime for asset pipeline
- `npm` - Node package manager
- `git` - Version control
- `imagemagick` - Image processing for Active Storage
- `vips`, `vips-dev` - Fast image processing library
- `tzdata` - Timezone data

### Key Gems
- `pg ~> 1.1` - PostgreSQL adapter
- `puma >= 5.0` - Web server
- `redis >= 4.0.1` - Redis adapter for Action Cable/Sidekiq
- `devise ~> 4.9` - Authentication
- `image_processing ~> 1.12` - Image processing with ImageMagick/vips
- `aws-sdk-s3` - S3-compatible storage (for GCS)
- `importmap-rails` - JavaScript with ESM import maps
- `turbo-rails` - Hotwire Turbo for SPA-like navigation
- `stimulus-rails` - Hotwire Stimulus for JavaScript
- `tailwindcss-rails` - Tailwind CSS framework

### Testing Gems
- `rspec-rails ~> 6.1` - Testing framework
- `factory_bot_rails ~> 6.4` - Test data factories
- `faker ~> 3.2` - Fake data generation
- `capybara ~> 3.39` - System/feature testing
- `shoulda-matchers ~> 6.0` - RSpec matchers
- `database_cleaner-active_record ~> 2.1` - Database cleaning
- `webmock ~> 3.19` - HTTP request stubbing
- `simplecov` - Code coverage

### Development Gems
- `pry-rails` - Enhanced Rails console
- `pry-byebug` - Debugging
- `rubocop`, `rubocop-rails`, `rubocop-rspec` - Code linting
- `brakeman` - Security vulnerability scanning
- `rack-mini-profiler` - Performance profiling
- `bullet` - N+1 query detection

## Configuration

### Environment Variables

Create a `.env` file in the project root (see `.env.example` for template):

```bash
# Database (automatically set by docker-compose.yml)
DATABASE_URL=postgres://clay_companion:development_password@db:5432/clay_companion_development

# Redis (for future Sidekiq background jobs)
REDIS_URL=redis://redis:6379/0

# Rails environment
RAILS_ENV=development
RAILS_LOG_TO_STDOUT=true

# Disable Spring (causes issues in Docker)
DISABLE_SPRING=true
```

### Database Configuration

Database settings are in [config/database.yml](config/database.yml) and use the `DATABASE_URL` environment variable for all environments.

**Development Database:**
- Host: `db` (Docker service name)
- Database: `clay_companion_development`
- User: `clay_companion`
- Password: `development_password`

**Test Database:**
- Host: `db`
- Database: `clay_companion_test`
- User: `clay_companion`
- Password: `development_password`

## Database Creation

```bash
# Create databases
docker compose run --rm web bundle exec rails db:create

# Run migrations
docker compose run --rm web bundle exec rails db:migrate

# Seed database with sample data
docker compose run --rm web bundle exec rails db:seed

# Reset database (drop, create, migrate, seed)
docker compose run --rm web bundle exec rails db:reset
```

## Database Initialization

When starting fresh:

```bash
# Setup database (create, migrate, seed)
docker compose run --rm web bundle exec rails db:setup

# Check migration status
docker compose run --rm web bundle exec rails db:version

# Rollback last migration
docker compose run --rm web bundle exec rails db:rollback
```

## How to Run the Test Suite

```bash
# Run all tests
docker compose run --rm test bundle exec rspec

# Run specific test file
docker compose run --rm test bundle exec rspec spec/models/artist_spec.rb

# Run specific test by line number
docker compose run --rm test bundle exec rspec spec/models/artist_spec.rb:42

# Run tests matching a pattern
docker compose run --rm test bundle exec rspec --tag focus

# Generate coverage report
docker compose run --rm test bundle exec rspec --format documentation

# Run tests in random order (recommended for catching test dependencies)
docker compose run --rm test bundle exec rspec --order random
```

## Services

### PostgreSQL (Database)
- **Version**: 15 (Alpine)
- **Port**: 5432
- **Container**: `clay_companion-db-1`
- **Volume**: `postgres_data` (persists data)
- **Health check**: `pg_isready -U clay_companion`

### Redis (Cache/Background Jobs)
- **Version**: 7 (Alpine)
- **Port**: 6379
- **Container**: `clay_companion-redis-1`
- **Volume**: `redis_data` (persists data)
- **Health check**: `redis-cli ping`

### Puma (Web Server)
- **Version**: 7.1.0
- **Port**: 3000
- **Threads**: 3 min, 3 max
- **Workers**: 1 (single mode in development)

## Rails Console

```bash
# Open Rails console
docker compose run --rm web bundle exec rails console

# Open Rails console with specific environment
docker compose run --rm web bundle exec rails console test

# Open Rails console in sandbox mode (rolls back all changes on exit)
docker compose run --rm web bundle exec rails console --sandbox
```

## Rails Commands

```bash
# Generate new migration
docker compose run --rm web bundle exec rails generate migration AddFieldToModel

# Generate model with migration
docker compose run --rm web bundle exec rails generate model Artist name:string bio:text

# Generate controller
docker compose run --rm web bundle exec rails generate controller Artworks index show new create

# Show routes
docker compose run --rm web bundle exec rails routes

# Show routes for specific controller
docker compose run --rm web bundle exec rails routes -c artworks

# Clear cache
docker compose run --rm web bundle exec rails cache:clear

# Run security audit
docker compose run --rm web bundle exec brakeman

# Run code linting
docker compose run --rm web bundle exec rubocop

# Auto-fix linting issues
docker compose run --rm web bundle exec rubocop -a
```

## Asset Pipeline

This project uses **importmap-rails** for JavaScript and **Tailwind CSS** for styling:

```bash
# Precompile assets (for production)
docker compose run --rm web bundle exec rails assets:precompile

# Clean compiled assets
docker compose run --rm web bundle exec rails assets:clean

# Watch and rebuild Tailwind CSS (runs automatically in development)
docker compose run --rm web bundle exec rails tailwindcss:watch

# Build Tailwind CSS once
docker compose run --rm web bundle exec rails tailwindcss:build
```

## Deployment Instructions

### Development (Docker Compose)
Already covered in main [README.md](README.md).

### Staging/Production (Railway/Fly.io)

**Prerequisites:**
- PostgreSQL 15+ database provisioned
- Redis instance provisioned (for Sidekiq)
- Environment variables configured
- Rails master key or credentials file uploaded

**Environment Variables to Set:**
```bash
RAILS_ENV=production
RAILS_SERVE_STATIC_FILES=true
RAILS_LOG_TO_STDOUT=true
DATABASE_URL=postgres://user:password@host:5432/database
REDIS_URL=redis://host:6379/0
SECRET_KEY_BASE=<generate with: rails secret>
RAILS_MASTER_KEY=<from config/master.key>
```

**Deploy Commands:**
```bash
# Run migrations
rails db:migrate

# Precompile assets
rails assets:precompile

# Start server
bundle exec puma -C config/puma.rb
```

### Production (Google Cloud Platform - Post-MVP)

Details TBD after MVP launch. Will use:
- **Cloud Run** for application hosting
- **Cloud SQL** for PostgreSQL
- **Cloud Storage** for Active Storage uploads
- **Memorystore** for Redis

## Docker Commands Reference

```bash
# Build images
docker compose build

# Rebuild without cache
docker compose build --no-cache

# Start all services
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f web

# Shell into web container
docker compose exec web sh

# Run bundle install
docker compose run --rm web bundle install

# Run npm install
docker compose run --rm web npm install

# Check container status
docker compose ps

# Remove all containers and volumes (DESTRUCTIVE)
docker compose down -v
```

## Troubleshooting

### Bundle install issues
```bash
# Clear bundle cache and reinstall
docker compose down
docker volume rm clay_companion_bundle_cache
docker compose build --no-cache
docker compose run --rm web bundle install
```

### Database connection issues
```bash
# Check if database is healthy
docker compose ps db

# Restart database
docker compose restart db

# Check database logs
docker compose logs db
```

### Port already in use
```bash
# Find process using port 3000
lsof -i :3000

# Kill process
kill <PID>
```

### Rails server won't start
```bash
# Remove PID file
docker compose exec web rm -f tmp/pids/server.pid

# Restart web container
docker compose restart web
```

## Additional Resources

- [Rails Guides](https://guides.rubyonrails.org/)
- [RSpec Documentation](https://rspec.info/)
- [Hotwire Handbook](https://hotwired.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

---

For general project information, architecture decisions, and implementation roadmap, see the main [README.md](README.md).
