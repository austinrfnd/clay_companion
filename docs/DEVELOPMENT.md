# Clay Companion - Development Guide

Complete guide for setting up, developing, and testing Clay Companion.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Initial Setup](#initial-setup)
3. [Docker Environment](#docker-environment)
4. [Development Workflow](#development-workflow)
5. [Test-Driven Development](#test-driven-development)
6. [HTML Test Attributes](#html-test-attributes)
7. [Database Management](#database-management)
8. [Common Tasks](#common-tasks)
9. [Debugging](#debugging)
10. [Code Quality](#code-quality)
11. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software
- **Docker Desktop** 4.25+ ([Download](https://www.docker.com/products/docker-desktop))
  - Includes Docker Compose
  - Minimum: 4GB RAM allocated to Docker
  - Recommended: 8GB RAM allocated

- **Git** 2.30+ ([Download](https://git-scm.com/downloads))

- **Code Editor**
  - VS Code (recommended) with extensions:
    - Ruby (Shopify)
    - Rails (Hridoy)
    - ERB Formatter/Beautify
    - Tailwind CSS IntelliSense
    - Docker

### Optional Tools
- **TablePlus** or **Postico** - Database GUI
- **Postman** or **Insomnia** - API testing (future)
- **Redis Insight** - Redis GUI (future)

---

## Initial Setup

### 1. Clone Repository

```bash
git clone <repository-url>
cd clay_companion
```

### 2. Build Docker Containers

```bash
# Build all services (first time only)
docker-compose build

# This will:
# - Download Ruby 3.3.0 image
# - Install system dependencies (PostgreSQL, ImageMagick, etc.)
# - Install Ruby gems
# - Install Node packages
```

### 3. Create Database

```bash
# Start database service
docker-compose up -d db

# Create and migrate database
docker-compose exec web bundle exec rails db:create db:migrate

# Optional: Load sample data
docker-compose exec web bundle exec rails db:seed
```

### 4. Start Application

```bash
# Start all services
docker-compose up

# Or run in background
docker-compose up -d

# View logs
docker-compose logs -f web
```

### 5. Verify Installation

Open browser: http://localhost:3000

You should see the Clay Companion homepage.

---

## Docker Environment

### Services

```yaml
web       # Rails application (port 3000)
db        # PostgreSQL 15 (port 5432)
redis     # Redis 7 (port 6379) - for future use
test      # Isolated test environment
```

### Container Commands

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Stop and remove volumes (fresh start)
docker-compose down -v

# View logs
docker-compose logs -f
docker-compose logs -f web        # Just web service

# Restart a service
docker-compose restart web

# Rebuild containers (after Gemfile changes)
docker-compose build
docker-compose up -d

# Check service status
docker-compose ps
```

### Executing Commands

```bash
# Rails console
docker-compose exec web bundle exec rails console

# Rails commands
docker-compose exec web bundle exec rails routes
docker-compose exec web bundle exec rails db:migrate

# RSpec tests
docker-compose run --rm test bundle exec rspec

# Bash shell in container
docker-compose exec web bash

# Run any command
docker-compose exec web [command]
```

### Environment Variables

```bash
# .env (not committed to git)
DATABASE_URL=postgres://clay_companion:development_password@db:5432/clay_companion_development
REDIS_URL=redis://redis:6379/0
RAILS_ENV=development
```

---

## Development Workflow

### Daily Development Routine

```bash
# 1. Start services
docker-compose up -d

# 2. Watch logs
docker-compose logs -f web

# 3. Open new terminal for commands
docker-compose exec web bash

# 4. Inside container: Run tests in watch mode
bundle exec guard

# 5. Make changes to code (outside container)
# - Tests automatically run when files change
# - Browser auto-refreshes with Turbo

# 6. Stop services when done
docker-compose down
```

### File Changes & Hot Reloading

**Automatic reload** (no restart needed):
- `.rb` files (models, controllers, services)
- `.erb` files (views)
- `.css` files (stylesheets)
- `.js` files (Stimulus controllers)

**Requires restart**:
- `Gemfile` changes (requires rebuild: `docker-compose build`)
- `config/routes.rb` changes
- `config/*.yml` changes
- Database migrations

```bash
# After changes requiring restart
docker-compose restart web
```

### Database Changes

```bash
# Generate migration
docker-compose exec web bundle exec rails generate migration AddUsernameToArtists username:string

# Run migrations
docker-compose exec web bundle exec rails db:migrate

# Rollback last migration
docker-compose exec web bundle exec rails db:rollback

# Reset database (WARNING: deletes all data)
docker-compose exec web bundle exec rails db:drop db:create db:migrate db:seed
```

---

## Test-Driven Development

### TDD Workflow (Red-Green-Refactor)

This project follows **strict TDD**. Here's the mandatory workflow:

**Additional Resources:**
- [MODEL_IMPLEMENTATION_CHECKLIST.md](MODEL_IMPLEMENTATION_CHECKLIST.md) - Step-by-step checklist for implementing models with TDD
- [TEST_SUITE_SUMMARY.md](TEST_SUITE_SUMMARY.md) - Overview of the complete test suite structure and coverage

#### 1. Write Failing Test (RED)

```bash
# Example: Adding artwork title validation

# Create test file
touch spec/models/artwork_spec.rb
```

```ruby
# spec/models/artwork_spec.rb
require 'rails_helper'

RSpec.describe Artwork, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
  end
end
```

```bash
# Run test - should FAIL
docker-compose run --rm test bundle exec rspec spec/models/artwork_spec.rb

# Expected output:
# Failure: expected Artwork to validate presence of title
```

#### 2. Write Minimal Code (GREEN)

```ruby
# app/models/artwork.rb
class Artwork < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
end
```

```bash
# Run test - should PASS
docker-compose run --rm test bundle exec rspec spec/models/artwork_spec.rb

# Expected output:
# 2 examples, 0 failures
```

#### 3. Refactor (Clean Up)

```ruby
# app/models/artwork.rb
class Artwork < ApplicationRecord
  # Constants for validation
  MAX_TITLE_LENGTH = 100

  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
end
```

```bash
# Run test again - should still PASS
docker-compose run --rm test bundle exec rspec spec/models/artwork_spec.rb
```

### Test Types

#### Unit Tests (Models, Services)
Test individual components in isolation.

```ruby
# spec/models/artist_spec.rb
RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:artworks).dependent(:destroy) }
  end

  describe '#portfolio_url' do
    it 'returns the public portfolio URL' do
      artist = build(:artist, username: 'jane_potter')
      expect(artist.portfolio_url).to eq('/jane_potter')
    end
  end
end
```

#### Integration Tests (Controllers, Requests)
Test multiple components working together.

```ruby
# spec/requests/dashboard/artworks_spec.rb
RSpec.describe 'Dashboard::Artworks', type: :request do
  let(:artist) { create(:artist) }

  before { sign_in artist }

  describe 'POST /dashboard/artworks' do
    context 'with valid params' do
      it 'creates a new artwork' do
        expect {
          post dashboard_artworks_path, params: {
            artwork: { title: 'Celadon Vase', year: 2024 }
          }
        }.to change(Artwork, :count).by(1)
      end

      it 'redirects to dashboard' do
        post dashboard_artworks_path, params: {
          artwork: { title: 'Celadon Vase', year: 2024 }
        }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'with invalid params' do
      it 'does not create artwork' do
        expect {
          post dashboard_artworks_path, params: {
            artwork: { title: '' }
          }
        }.not_to change(Artwork, :count)
      end

      it 'renders new template' do
        post dashboard_artworks_path, params: {
          artwork: { title: '' }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
```

#### E2E Tests (System, Feature) - After Feature Complete
Test complete user flows through the UI.

```ruby
# spec/system/artwork_creation_spec.rb
RSpec.describe 'Artwork Creation', type: :system do
  let(:artist) { create(:artist) }

  before do
    sign_in artist
    visit dashboard_path
  end

  it 'allows artist to create artwork' do
    click_link 'Add Artwork'

    fill_in 'Title', with: 'Celadon Vase'
    fill_in 'Year', with: '2024'
    select 'Bowl', from: 'Type'
    fill_in 'Description', with: 'A beautiful celadon vase...'
    attach_file 'Images', 'spec/fixtures/files/vase.jpg'

    click_button 'Create Artwork'

    expect(page).to have_content('Artwork created successfully')
    expect(page).to have_content('Celadon Vase')
  end
end
```

### Running Tests

```bash
# Run all tests
docker-compose run --rm test bundle exec rspec

# Run specific file
docker-compose run --rm test bundle exec rspec spec/models/artist_spec.rb

# Run specific test (by line number)
docker-compose run --rm test bundle exec rspec spec/models/artist_spec.rb:10

# Run tests matching pattern
docker-compose run --rm test bundle exec rspec --pattern "spec/models/**/*_spec.rb"

# Run tests in watch mode (auto-run on file changes)
docker-compose exec web bundle exec guard

# Run tests with coverage report
docker-compose run --rm test bundle exec rspec --format documentation
open coverage/index.html  # View coverage report
```

### Test Helpers

#### Factory Bot

```ruby
# spec/factories/artists.rb
FactoryBot.define do
  factory :artist do
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 'password123' }

    trait :with_artworks do
      transient do
        artworks_count { 3 }
      end

      after(:create) do |artist, evaluator|
        create_list(:artwork, evaluator.artworks_count, artist: artist)
      end
    end
  end
end

# Usage in tests
artist = create(:artist)  # Persisted
artist = build(:artist)   # In-memory
artist = create(:artist, :with_artworks, artworks_count: 5)
```

#### Request Helpers

```ruby
# spec/support/request_helpers.rb
module RequestHelpers
  def sign_in(artist)
    post artist_session_path, params: {
      artist: { email: artist.email, password: artist.password }
    }
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
```

### TDD with Claude Skill

```bash
# When implementing a feature, use the Claude TDD skill
# Example prompt:

"Use the test-driven-development skill to implement artwork creation.
The feature should:
- Allow artists to create artworks with title, description, year, and images
- Validate presence of title
- Allow up to 10 images per artwork
- Set visibility to 'private' by default"

# Claude will:
# 1. Write failing unit tests for Artwork model
# 2. Write failing integration tests for ArtworksController
# 3. Show test failures
# 4. Write minimal implementation
# 5. Show tests passing
# 6. Refactor if needed
```

---

## HTML Test Attributes

### Mandatory data-test-id Attributes

**ALL interactive HTML elements MUST have `data-test-id` attributes** for reliable E2E testing.

### Why This Matters

- Tests are resilient to CSS/styling changes
- Tests are resilient to i18n text changes
- Clear intent (test-specific attributes)
- No reliance on implementation details

### Naming Convention

**Format**: `{resource}-{element}-{type}`
- Use kebab-case (lowercase with hyphens)
- Be specific and descriptive

**Examples**:
```
artwork-title-input
artwork-submit-button
series-delete-link
gallery-image-card
nav-dashboard-link
modal-confirm-button
dropdown-visibility-select
```

### Elements That MUST Have data-test-id

- ✅ All form inputs (`<input>`, `<textarea>`, `<select>`)
- ✅ All buttons (`<button>`, `<input type="submit">`)
- ✅ All links that trigger actions (`<a>`)
- ✅ All interactive cards or containers
- ✅ All modals, dialogs, dropdowns
- ✅ All navigation elements
- ✅ Any element referenced in E2E tests

### Example: Form with Test Attributes

```erb
<!-- app/views/dashboard/artworks/_form.html.erb -->
<div data-test-id="artwork-form-container">
  <%= form_with model: @artwork, data: { test_id: 'artwork-form' } do |f| %>
    <div class="form-group">
      <%= f.label :title, t('.title_label') %>
      <%= f.text_field :title,
                       class: 'form-input',
                       data: { test_id: 'artwork-title-input' } %>
    </div>

    <div class="form-group">
      <%= f.label :year, t('.year_label') %>
      <%= f.number_field :year,
                         class: 'form-input',
                         data: { test_id: 'artwork-year-input' } %>
    </div>

    <div class="form-group">
      <%= f.label :visibility, t('.visibility_label') %>
      <%= f.select :visibility,
                   options_for_select(@visibility_options),
                   {},
                   { class: 'form-select', data: { test_id: 'artwork-visibility-select' } } %>
    </div>

    <div class="form-group">
      <%= f.label :images, t('.images_label') %>
      <%= f.file_field :images,
                       multiple: true,
                       class: 'form-file',
                       data: { test_id: 'artwork-images-input' } %>
    </div>

    <div class="form-actions">
      <%= f.submit t('.submit'),
                   class: 'btn btn-primary',
                   data: { test_id: 'artwork-submit-button' } %>
      <%= link_to t('.cancel'),
                  dashboard_path,
                  class: 'btn btn-secondary',
                  data: { test_id: 'artwork-cancel-link' } %>
    </div>
  <% end %>
</div>
```

### Example: Navigation with Test Attributes

```erb
<!-- app/views/layouts/_navigation.html.erb -->
<nav data-test-id="main-navigation" class="navbar">
  <%= link_to t('.dashboard'),
              dashboard_path,
              class: 'nav-link',
              data: { test_id: 'nav-dashboard-link' } %>

  <%= link_to t('.catalog'),
              dashboard_artworks_path,
              class: 'nav-link',
              data: { test_id: 'nav-catalog-link' } %>

  <%= link_to t('.series'),
              dashboard_series_path,
              class: 'nav-link',
              data: { test_id: 'nav-series-link' } %>

  <%= link_to t('.settings'),
              dashboard_settings_path,
              class: 'nav-link',
              data: { test_id: 'nav-settings-link' } %>
</nav>
```

### Using data-test-id in Tests

```ruby
# spec/system/artwork_creation_spec.rb
RSpec.describe 'Artwork Creation', type: :system do
  let(:artist) { create(:artist) }

  before do
    sign_in artist
    visit new_dashboard_artwork_path
  end

  it 'creates artwork successfully' do
    # Find form by test-id
    within('[data-test-id="artwork-form"]') do
      # Fill inputs by test-id (not by label text!)
      fill_in '[data-test-id="artwork-title-input"]', with: 'Celadon Vase'
      fill_in '[data-test-id="artwork-year-input"]', with: '2024'
      select 'Public', from: '[data-test-id="artwork-visibility-select"]'
      attach_file '[data-test-id="artwork-images-input"]', file_fixture('vase.jpg')

      # Click button by test-id
      click_button '[data-test-id="artwork-submit-button"]'
    end

    expect(page).to have_content(I18n.t('dashboard.artworks.create.success'))
  end

  it 'navigates to catalog' do
    within('[data-test-id="main-navigation"]') do
      click_link '[data-test-id="nav-catalog-link"]'
    end

    expect(page).to have_current_path(dashboard_artworks_path)
  end
end
```

### Quick Tips

1. **Add test-id when creating HTML** - Don't wait until writing tests
2. **Use test-id finder in tests** - `find('[data-test-id="..."]')`
3. **Keep names consistent** - Follow the `{resource}-{element}-{type}` pattern
4. **Document complex test-ids** - Add comments in views if needed
5. **Run RuboCop** - We'll add a custom cop to enforce test-id presence

---

## Database Management

### Migrations

```bash
# Generate migration
docker-compose exec web bundle exec rails generate migration MigrationName

# Common migration types
docker-compose exec web bundle exec rails generate migration AddColumnToTable column:type
docker-compose exec web bundle exec rails generate migration RemoveColumnFromTable column:type
docker-compose exec web bundle exec rails generate migration CreateTableName

# Run migrations
docker-compose exec web bundle exec rails db:migrate

# Rollback last migration
docker-compose exec web bundle exec rails db:rollback

# Rollback multiple migrations
docker-compose exec web bundle exec rails db:rollback STEP=3

# Reset database (danger!)
docker-compose exec web bundle exec rails db:drop db:create db:migrate

# Check migration status
docker-compose exec web bundle exec rails db:migrate:status
```

### Seeds

```bash
# Run seeds
docker-compose exec web bundle exec rails db:seed

# Reset and seed
docker-compose exec web bundle exec rails db:reset
```

### Database Console

```bash
# PostgreSQL console
docker-compose exec db psql -U clay_companion -d clay_companion_development

# Common psql commands
\dt                 # List tables
\d table_name       # Describe table
\q                  # Quit

# Or use Rails dbconsole
docker-compose exec web bundle exec rails dbconsole
```

### Backups (Production)

```bash
# Export database
docker-compose exec db pg_dump -U clay_companion clay_companion_production > backup.sql

# Import database
docker-compose exec -T db psql -U clay_companion clay_companion_production < backup.sql
```

---

## Common Tasks

### Generating Code

```bash
# Model
docker-compose exec web bundle exec rails generate model Artist username:string email:string

# Controller
docker-compose exec web bundle exec rails generate controller Dashboard::Artworks

# Migration
docker-compose exec web bundle exec rails generate migration AddBioToArtists bio:text

# Service object (manual)
mkdir -p app/services
touch app/services/artwork_creator.rb

# Stimulus controller
docker-compose exec web bundle exec rails generate stimulus gallery
```

### Rails Console

```bash
# Start console
docker-compose exec web bundle exec rails console

# Inside console
Artist.count
artist = Artist.first
artist.artworks.create(title: 'Test Vase')

# Reload code (after changes)
reload!

# Exit
exit
```

### Viewing Routes

```bash
# All routes
docker-compose exec web bundle exec rails routes

# Search routes
docker-compose exec web bundle exec rails routes | grep artwork

# Specific controller
docker-compose exec web bundle exec rails routes -c dashboard/artworks
```

### Clearing Caches

```bash
# Clear Rails cache
docker-compose exec web bundle exec rails cache:clear

# Clear tmp directory
docker-compose exec web bundle exec rails tmp:clear

# Rebuild assets
docker-compose exec web bundle exec rails assets:clobber assets:precompile
```

---

## Debugging

### Debugging with Pry

```ruby
# Add to Gemfile
group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end
```

```ruby
# In code
def create
  binding.pry  # Debugger will stop here
  @artwork = Artwork.new(artwork_params)
end
```

```bash
# Attach to running container to use debugger
docker attach $(docker-compose ps -q web)

# Detach without stopping: Ctrl+P, Ctrl+Q
```

### Server Logs

```bash
# View logs
docker-compose logs -f web

# View last 100 lines
docker-compose logs --tail=100 web

# View logs with timestamps
docker-compose logs -t web
```

### Database Queries

```bash
# Enable query logging in development
# config/environments/development.rb
config.log_level = :debug
config.active_record.verbose_query_logs = true
```

### Performance Profiling

```ruby
# Add to Gemfile
group :development do
  gem 'rack-mini-profiler'
  gem 'bullet'  # N+1 query detection
end
```

---

## Code Quality

This project enforces **strict code quality standards**. See [CODE_QUALITY.md](CODE_QUALITY.md) for complete documentation.

### Quick Reference

**Documentation (Mandatory)**
```ruby
# frozen_string_literal: true

##
# Artist model
#
# Represents a ceramic artist account with portfolio management.
class Artist < ApplicationRecord
  ##
  # Returns the public portfolio URL for this artist
  #
  # @return [String] the portfolio URL path
  def portfolio_url
    "/#{username}"
  end
end
```

**Internationalization (Mandatory)**
```ruby
# ❌ BAD: Hardcoded string
flash[:notice] = "Artwork created successfully"

# ✅ GOOD: i18n key
flash[:notice] = t('.success')
```

```yaml
# config/locales/en.yml
en:
  dashboard:
    artworks:
      create:
        success: "Artwork created successfully"
```

**HTML Test Attributes (Mandatory)**
```erb
<!-- ❌ BAD: No test-id -->
<button type="submit">Create</button>

<!-- ✅ GOOD: Has test-id -->
<button type="submit" data-test-id="artwork-submit-button">
  <%= t('.submit') %>
</button>
```

**Ruby Style**
```ruby
# Use 2-space indentation
# Use snake_case for methods and variables
# Use SCREAMING_SNAKE_CASE for constants
# Use CamelCase for classes and modules
# Prefer single quotes unless interpolation needed
# Use guard clauses for early returns
```

### Linting

```bash
# RuboCop (Ruby linter)
docker-compose exec web bundle exec rubocop

# Auto-fix issues
docker-compose exec web bundle exec rubocop -a

# Check specific file
docker-compose exec web bundle exec rubocop app/models/artist.rb
```

### Code Coverage

```bash
# Run tests with coverage
docker-compose run --rm test bundle exec rspec

# View coverage report
open coverage/index.html

# Goal: 90%+ coverage for models and services
```

### Security Audit

```bash
# Brakeman (security scanner)
docker-compose exec web bundle exec brakeman

# Bundler audit (vulnerable gems)
docker-compose exec web bundle exec bundle audit check --update
```

### Code Quality Tools

```bash
# Run all quality checks before commit
docker-compose exec web bundle exec rubocop
docker-compose exec web bundle exec brakeman
docker-compose run --rm test bundle exec rspec
```

### Pre-Commit Checklist

Before committing code, ensure:

- [ ] All tests pass (`bundle exec rspec`)
- [ ] RuboCop passes (`bundle exec rubocop`)
- [ ] Brakeman passes (`bundle exec brakeman`)
- [ ] All files have header documentation
- [ ] All public methods have YARD documentation
- [ ] No hardcoded strings (i18n used everywhere)
- [ ] All interactive HTML elements have `data-test-id` attributes
- [ ] No N+1 queries (checked with Bullet gem)
- [ ] Code follows style guide
- [ ] Git commit message follows format

See [CODE_QUALITY.md](CODE_QUALITY.md) for complete standards.

---

## Troubleshooting

### Database Connection Issues

```bash
# Check database is running
docker-compose ps db

# Restart database
docker-compose restart db

# Check database logs
docker-compose logs db

# Recreate database
docker-compose down -v
docker-compose up -d db
docker-compose exec web bundle exec rails db:create db:migrate
```

### Port Already in Use

```bash
# Find process using port 3000
lsof -ti:3000

# Kill process
kill -9 $(lsof -ti:3000)

# Or change port in docker-compose.yml
ports:
  - "3001:3000"  # Use port 3001 instead
```

### Container Won't Start

```bash
# Check logs
docker-compose logs web

# Rebuild container
docker-compose build --no-cache web
docker-compose up -d

# Remove all containers and volumes (nuclear option)
docker-compose down -v
docker system prune -a
```

### Gem Installation Issues

```bash
# Clear bundle cache
docker-compose down
docker volume rm clay_companion_bundle_cache
docker-compose build --no-cache
docker-compose up -d
```

### Tests Failing

```bash
# Ensure test database is clean
docker-compose run --rm test bundle exec rails db:test:prepare

# Clear test cache
docker-compose run --rm test bundle exec rails tmp:clear

# Run tests with verbose output
docker-compose run --rm test bundle exec rspec --format documentation
```

### Asset Issues

```bash
# Precompile assets
docker-compose exec web bundle exec rails assets:precompile

# Clear assets
docker-compose exec web bundle exec rails assets:clobber
```

---

## Quick Reference

### Most Used Commands

```bash
# Start development
docker-compose up -d && docker-compose logs -f web

# Run tests
docker-compose run --rm test bundle exec rspec

# Rails console
docker-compose exec web bundle exec rails console

# Run migration
docker-compose exec web bundle exec rails db:migrate

# View logs
docker-compose logs -f web

# Restart app
docker-compose restart web

# Stop all
docker-compose down
```

### Keyboard Shortcuts (VS Code)

- `Cmd+Shift+P` - Command palette
- `Cmd+P` - Quick file open
- `Cmd+Shift+F` - Search in files
- `Cmd+/` - Toggle comment
- `F12` - Go to definition
- `Shift+F12` - Find references

---

## Next Steps

1. **Read** [ARCHITECTURE.md](ARCHITECTURE.md) to understand the system design
2. **Read** [CODE_QUALITY.md](CODE_QUALITY.md) to understand coding standards
3. **Review** [../requirements/](../requirements/) for feature specifications
4. **Start developing** using TDD workflow

---

**Questions?** Check the [requirements documentation](../requirements/), [architecture docs](ARCHITECTURE.md), or [code quality standards](CODE_QUALITY.md).
