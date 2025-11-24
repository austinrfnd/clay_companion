# Clay Companion - Testing Strategy

**Last Updated**: 2025-11-24

---

## Overview

This document outlines the testing approach for Clay Companion. We follow Test-Driven Development (TDD) principles where practical, with comprehensive coverage across unit, integration, and end-to-end tests.

---

## Testing Philosophy

**Principles**:
- Write tests BEFORE implementation when starting new features
- Tests serve as executable documentation
- Aim for high coverage, especially on critical paths
- Test behavior, not implementation details
- Make tests fast and independent

**Coverage Goals**:
- Models: 90%+ coverage
- Controllers: 85%+ coverage
- Services: 90%+ coverage
- Views: 70%+ coverage (lower priority)
- Overall: 85%+ coverage

---

## Test Types & When to Use

### 1. Unit Tests

**Purpose**: Test individual components in isolation

**What to test**:
- Model validations and methods
- Service class logic
- Helper functions
- Utility methods

**Example**:

```ruby
describe Artist do
  describe "#valid?" do
    it "requires email" do
      artist = Artist.new(name: "Jane")
      expect(artist).not_to be_valid
      expect(artist.errors[:email]).to be_present
    end

    it "requires valid email format" do
      artist = Artist.new(email: "invalid", name: "Jane")
      expect(artist).not_to be_valid
    end
  end
end
```

**Tools**: RSpec, Minitest

---

### 2. Integration Tests

**Purpose**: Test how components work together

**What to test**:
- Controller actions with database
- Feature workflows (create → update → delete)
- Authentication & authorization
- Email/notification triggers

**Example**:

```ruby
describe "Artist uploads artwork" do
  it "creates artwork and updates dashboard" do
    artist = create(:artist)
    artwork_params = attributes_for(:artwork)

    post "/api/artworks", params: artwork_params, headers: auth_headers(artist)

    expect(response).to have_http_status(:created)
    expect(artist.artworks.count).to eq(1)
  end
end
```

**Tools**: RSpec with Rails helpers, Factory Bot

---

### 3. Request/API Tests

**Purpose**: Test HTTP endpoints

**What to test**:
- Status codes (200, 404, 403, etc.)
- Response format (JSON structure)
- Request validation
- Error messages

**Example**:

```ruby
describe "GET /api/artworks/:id" do
  it "returns artwork for authenticated user" do
    artwork = create(:artwork)
    artist = artwork.artist

    get "/api/artworks/#{artwork.id}", headers: auth_headers(artist)

    expect(response).to have_http_status(:success)
    expect(response.parsed_body["title"]).to eq(artwork.title)
  end

  it "returns 404 for non-existent artwork" do
    get "/api/artworks/999", headers: auth_headers(create(:artist))
    expect(response).to have_http_status(:not_found)
  end
end
```

**Tools**: RSpec request specs

---

### 4. End-to-End (E2E) Tests

**Purpose**: Test complete user workflows through browser

**What to test**:
- Critical user flows (signup, login, upload, publish)
- UI interactions
- Navigation
- Form submissions

**Example**:

```gherkin
Scenario: Artist uploads and publishes artwork
  Given I am an authenticated artist
  When I visit the artwork upload page
  And I upload an image
  And I fill in the artwork details
  And I click "Publish"
  Then I should see "Artwork published successfully"
  And the artwork should appear on my profile
```

**Tools**: Capybara, Selenium, Playwright

**When to use**: Only for critical paths (not everything!)

---

## Test Structure

### File Organization

```
spec/
├── models/               # Unit tests for models
├── controllers/          # Integration tests for controllers
├── requests/            # API request specs
├── views/               # View specs
├── services/            # Service class specs
├── features/            # End-to-end tests
├── support/             # Helpers, fixtures, factories
│   ├── factory_definitions.rb
│   ├── auth_helpers.rb
│   └── fixtures/
└── spec_helper.rb       # RSpec configuration
```

---

## Testing Setup

### Gems

```ruby
# Gemfile
group :test do
  gem 'rspec-rails'          # Testing framework
  gem 'factory_bot_rails'    # Test data factories
  gem 'shoulda-matchers'     # Model/controller matchers
  gem 'webmock'              # Mock HTTP requests
  gem 'timecop'              # Mock time/date
  gem 'simplecov'            # Coverage reporting
end
```

### Configuration

```ruby
# spec/spec_helper.rb
RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.before(:each) do
    # Clear cache between tests
    Rails.cache.clear
  end
end
```

---

## Testing Patterns

### Using Factories

```ruby
# spec/factories/artists.rb
FactoryBot.define do
  factory :artist do
    email { Faker::Internet.email }
    password { "securepassword" }
    name { Faker::Name.name }
  end
end

# In tests
it "creates artist" do
  artist = create(:artist)
  expect(artist).to be_persisted
end
```

### Mocking & Stubbing

```ruby
# Mock S3 upload
allow(S3Bucket).to receive(:upload).and_return("https://s3.../image.jpg")

# Stub email sending
expect { UserMailer.welcome_email(artist).deliver_later }
  .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
```

### Authentication in Tests

```ruby
# Helper for authenticated requests
def auth_headers(user)
  token = JWTToken.encode(user_id: user.id)
  { "Authorization" => "Bearer #{token}" }
end

it "requires authentication" do
  get "/api/dashboard"
  expect(response).to have_http_status(:unauthorized)
end

it "allows authenticated access" do
  get "/api/dashboard", headers: auth_headers(create(:artist))
  expect(response).to have_http_status(:success)
end
```

---

## What to Test

### Models - Always Test

```ruby
describe Artwork do
  # Validations
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:image_url) }

  # Associations
  it { is_expected.to belong_to(:artist) }
  it { is_expected.to have_many(:images) }

  # Methods
  describe "#thumbnail_url" do
    it "returns thumbnail image URL" do
      artwork = create(:artwork)
      expect(artwork.thumbnail_url).to include("thumbnail")
    end
  end

  # Edge cases
  it "handles nil descriptions gracefully" do
    artwork = create(:artwork, description: nil)
    expect(artwork.description).to be_nil
  end
end
```

### Controllers - Integration Tests

```ruby
describe Api::ArtworksController do
  describe "POST #create" do
    it "creates artwork with valid params" do
      artist = create(:artist)

      expect {
        post "/api/artworks", params: { title: "My Pot" }, headers: auth_headers(artist)
      }.to change(Artwork, :count).by(1)
    end

    it "returns validation errors" do
      artist = create(:artist)

      post "/api/artworks", params: { title: "" }, headers: auth_headers(artist)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["errors"]).to be_present
    end
  end
end
```

### Services - Unit Tests

```ruby
describe CreateArtwork do
  it "creates artwork and updates portfolio" do
    artist = create(:artist)
    service = CreateArtwork.new(
      artist_id: artist.id,
      title: "New Vessel",
      image_url: "https://..."
    )

    artwork = service.execute

    expect(artwork).to be_persisted
    expect(artist.artworks).to include(artwork)
  end

  it "raises error on invalid data" do
    service = CreateArtwork.new(artist_id: nil)

    expect { service.execute }.to raise_error(ArgumentError)
  end
end
```

---

## What NOT to Test

❌ **Don't test Rails internals**
- ActiveRecord CRUD operations (Rails handles this)
- Standard validations (covered by Rails)
- Routing (unless custom)

❌ **Don't test gems/libraries**
- Devise authentication internals
- AWS S3 SDK
- Payment processor internals

❌ **Don't test implementation details**
- Internal method calls
- Private methods (test through public interface)
- Database query structure

❌ **Don't test UI text/CSS**
- Button colors
- Text content (unless critical)
- Layout precision

---

## Running Tests

### Run All Tests

```bash
# Using Rails test command
rails test

# Using RSpec
rspec

# With coverage report
rspec --format coverage
```

### Run Specific Tests

```bash
# Single file
rspec spec/models/artist_spec.rb

# Single test
rspec spec/models/artist_spec.rb:10

# Matching pattern
rspec spec/models/ -e "validates"

# Integration tests only
rspec spec/requests/
```

### Watch for Changes

```bash
# Automatically rerun tests on file changes
rspec --format progress --watch
```

---

## Continuous Integration

### GitHub Actions

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres

    steps:
      - uses: actions/checkout@v2
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3
          bundler-cache: true

      - name: Setup database
        run: bin/rails db:test:prepare

      - name: Run tests
        run: rspec

      - name: Upload coverage
        uses: codecov/codecov-action@v2
```

---

## Test Coverage

### View Coverage Report

```bash
rspec --format RSpec::Core::Formatters::HtmlFormatter --out coverage/index.html
open coverage/index.html
```

### Coverage Requirements

- Merge PRs only if coverage doesn't decrease
- Aim for 85%+ overall coverage
- 90%+ on critical paths (auth, payments)

---

## Debugging Failed Tests

### Common Issues

**"Database is not current"**
```bash
rails db:test:prepare
```

**"Factory not found"**
```bash
# Check spec/factories/
FactoryBot.find_definitions
```

**"Test passes locally but fails in CI"**
- Check for time-dependent tests (use Timecop)
- Verify database state (use transactional fixtures)
- Check for random seed issues (set SEED=12345)

### Debugging Single Test

```bash
# Run with verbose output
rspec spec/file_spec.rb:10 -fd

# Run with pry debugger
pry-byebug (add `binding.pry` in test)

# Run with logging
rspec spec/file_spec.rb --trace
```

---

## Performance Testing

### Identify Slow Tests

```bash
rspec --profile 10  # Show 10 slowest tests
```

### Profile Queries

```ruby
it "doesn't have N+1 queries" do
  artists = Artist.includes(:artworks)

  expect {
    artists.each { |a| a.artworks.count }
  }.not_to exceed_query_limit(1)
end
```

---

## Test Maintenance

### Keep Tests Current

- Update tests when requirements change
- Delete tests for removed features
- Refactor duplicated test code

### Review Tests in PRs

- Are tests actually testing the feature?
- Is coverage sufficient?
- Are there any flaky tests?

---

## Best Practices Checklist

- [ ] Tests are isolated (no dependencies between tests)
- [ ] Tests are fast (< 1s per test)
- [ ] Tests are readable (clear setup/action/assertion)
- [ ] Tests are specific (one assertion per test when possible)
- [ ] Tests cover happy path AND edge cases
- [ ] Factories are used for test data
- [ ] No hardcoded values in tests
- [ ] Tests pass consistently (no flakes)
- [ ] Tests run in CI before merge

---

## Resources

- [RSpec Documentation](https://rspec.info/)
- [Factory Bot Guide](https://github.com/thoughtbot/factory_bot/wiki)
- [Testing Rails](https://guides.rubyonrails.org/testing.html)
- [Better Specs](http://www.betterspecs.org/)

---

**Version**: 1.0
**Last Updated**: 2025-11-24
**Status**: Active
