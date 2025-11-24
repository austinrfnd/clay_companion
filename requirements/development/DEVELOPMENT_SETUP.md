# Clay Companion - Development Setup Guide

**Last Updated**: 2025-11-24

---

## Overview

This guide covers setting up your local development environment for Clay Companion. It assumes familiarity with Ruby, Rails, Git, and typical web development workflows.

---

## Prerequisites

Before starting, ensure you have:

- **Ruby** 3.3+ installed (check with `ruby --version`)
- **Rails** 7.0+ installed (check with `rails --version`)
- **PostgreSQL** 14+ (check with `psql --version`)
- **Node.js** 18+ and npm/yarn (check with `node --version`)
- **Git** (check with `git --version`)
- A code editor (VS Code, RubyMine, Sublime Text, etc.)

---

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/austinrfnd/clay_companion.git
cd clay_companion
```

### 2. Install Ruby Dependencies

```bash
bundle install
```

This installs all gems specified in `Gemfile`.

### 3. Install Node Dependencies

```bash
npm install
# or
yarn install
```

This installs JavaScript packages for frontend assets.

### 4. Configure Environment Variables

Copy the example environment file and fill in your values:

```bash
cp .env.example .env
```

Required environment variables:
- `DATABASE_URL` - PostgreSQL connection string (default: `postgresql://localhost/clay_companion_development`)
- `REDIS_URL` - Redis connection string (for background jobs/caching)
- `AWS_ACCESS_KEY_ID` - AWS S3 credentials for image uploads
- `AWS_SECRET_ACCESS_KEY` - AWS S3 secret key
- `AWS_BUCKET` - S3 bucket name for uploads
- `RAILS_MASTER_KEY` - Master encryption key for credentials (created automatically)

### 5. Set Up Database

Create and migrate the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

This creates the development database and loads seed data.

### 6. Start the Development Server

```bash
./bin/dev
```

This starts Rails server and Webpack dev server simultaneously.

The app will be available at `http://localhost:3000`.

---

## Alternative: Docker Setup

If you prefer Docker:

```bash
docker-compose up
```

This starts the app, PostgreSQL, and Redis in containers.

Access at `http://localhost:3000`.

---

## Running Tests

### Run All Tests

```bash
rails test
# or
rspec
```

### Run Specific Test File

```bash
rails test test/models/artist_test.rb
# or
rspec spec/models/artist_spec.rb
```

### Run with Coverage

```bash
rspec --format coverage
```

---

## Database Management

### Reset Database (Clear all data)

```bash
rails db:drop db:create db:migrate
```

### Rollback Last Migration

```bash
rails db:rollback
```

### View Migration Status

```bash
rails db:migrate:status
```

---

## Common Development Tasks

### Generate a New Model

```bash
rails generate model ModelName field:type field:type
rails db:migrate
```

### Generate a New Controller

```bash
rails generate controller ControllerName action1 action2
```

### Generate a New Migration

```bash
rails generate migration AddFieldToTable field:type
rails db:migrate
```

### Create Admin User (for testing)

```bash
rails console
> Artist.create!(email: 'admin@test.com', password: 'password123')
```

---

## Debugging

### Rails Console

```bash
rails console
```

Debug queries and test code interactively:

```ruby
artist = Artist.first
artist.artworks.count
```

### View Logs

```bash
tail -f log/development.log
```

### Debugging with Byebug

Add breakpoint in code:

```ruby
def some_method
  byebug
  # code here
end
```

Then step through in console when breakpoint is hit.

---

## Useful Commands

| Command | Purpose |
|---------|---------|
| `rails routes` | View all routes |
| `rails db:seed` | Load seed data |
| `rails assets:precompile` | Precompile assets |
| `./bin/dev` | Start dev server with hot reload |
| `rails console` | Interactive Ruby shell with app context |
| `rails generate --help` | See available generators |

---

## Troubleshooting

### "Could not find PostgreSQL"

Install PostgreSQL:

```bash
# macOS
brew install postgresql

# Linux
sudo apt-get install postgresql

# Windows
Download from https://www.postgresql.org/download/windows/
```

### "Bundler version mismatch"

```bash
gem install bundler
bundle update bundler
```

### "Database connection refused"

Check if PostgreSQL is running:

```bash
# macOS
brew services start postgresql

# Linux
sudo systemctl start postgresql

# Windows
Check Services app
```

### "Assets not loading"

Recompile assets:

```bash
rails assets:precompile RAILS_ENV=development
```

---

## Git Workflow

### Create Feature Branch

```bash
git checkout -b feature/feature-name
```

### Commit Changes

```bash
git add .
git commit -m "Descriptive commit message"
```

### Push to Remote

```bash
git push -u origin feature/feature-name
```

### Create Pull Request

Visit GitHub and click "New Pull Request" or use:

```bash
gh pr create
```

---

## Code Style & Linting

### Run Linters

```bash
# Ruby/Rails linting
rubocop

# JavaScript linting
npm run lint
```

### Auto-fix Issues

```bash
rubocop -A
npm run lint:fix
```

---

## Performance Profiling

### Identify N+1 Queries

```bash
rails dev:cache  # Enable caching in development
```

### Memory Profiling

```bash
require 'benchmark'

Benchmark.measure { /* code */ }
```

---

## VS Code Setup (Recommended)

Install extensions:

- Ruby (Shopify)
- Rails (bung87)
- Ruby on Rails Snippets
- ERB Helper Tags
- PostCSS Language Support

Add to `.vscode/settings.json`:

```json
{
  "ruby.format": "rubocop",
  "[ruby]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "shopify.ruby-lsp"
  }
}
```

---

## Next Steps

1. Review [CODING_STANDARDS.md](CODING_STANDARDS.md) for code conventions
2. Check [TESTING_STRATEGY.md](TESTING_STRATEGY.md) for testing guidelines
3. Read [../PRODUCT_OVERVIEW.md](../PRODUCT_OVERVIEW.md) to understand the product
4. Start working on your first issue!

---

**Happy coding! 🚀**
