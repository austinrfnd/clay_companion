# Clay Companion - Coding Standards & Conventions

**Last Updated**: 2025-11-24

---

## Overview

This document defines coding standards and conventions for Clay Companion development. All team members should follow these guidelines to ensure consistent, maintainable code.

---

## General Principles

- **Readability** - Code should be easy to understand at a glance
- **Consistency** - Follow established patterns throughout the codebase
- **Maintainability** - Write code that future developers can understand and modify
- **Performance** - Write efficient code; optimize only when needed
- **Simplicity** - Avoid over-engineering; use the simplest solution that works
- **Testing** - Write tests as you develop; aim for high coverage

---

## Ruby / Rails Standards

### File Organization

```
app/
├── controllers/      # Request handlers
├── models/          # Business logic & data
├── views/           # HTML templates
├── helpers/         # View helpers
├── jobs/            # Background jobs
├── mailers/         # Email logic
└── services/        # Complex business logic

spec/                # Tests
config/              # Configuration
lib/                 # Shared utilities
```

### Naming Conventions

#### Classes

```ruby
# ✅ Good - PascalCase
class ArtistProfile
end

class StudioImageUploader
end

# ❌ Bad - snake_case or abbreviations
class artist_profile
end

class StudImgUpld
end
```

#### Methods

```ruby
# ✅ Good - snake_case, descriptive
def upload_image(file)
end

def validate_email_format
end

# ❌ Bad - camelCase or abbreviations
def uploadImage(file)
end

def validate_email_fmt
end
```

#### Variables

```ruby
# ✅ Good - clear, descriptive
@uploaded_images = []
user_email = artist.email

# ❌ Bad - single letters (except index), abbreviations
@imgs = []
ue = artist.email
```

#### Constants

```ruby
# ✅ Good - UPPER_SNAKE_CASE
MAX_IMAGE_SIZE = 5.megabytes
DEFAULT_IMAGE_QUALITY = 85

# ❌ Bad - lowercase or PascalCase
max_image_size = 5.megabytes
MaxImageSize = 5.megabytes
```

### Method Size & Complexity

**Ideal method length**: 5-10 lines

```ruby
# ✅ Good - Short, focused
def create_artist(params)
  artist = Artist.new(artist_params(params))
  artist.save ? artist : nil
end

# ❌ Bad - Too long, mixed concerns
def create_artist(params)
  # validation
  # email sending
  # logging
  # database operations
  # ... 50 lines total
end
```

### Class Responsibilities

Follow Single Responsibility Principle (SRP):

```ruby
# ✅ Good - Each class has one job
class ImageUploader
  def upload(file)
    # uploading logic only
  end
end

class ImageValidator
  def validate(file)
    # validation logic only
  end
end

# ❌ Bad - Class doing too much
class ImageService
  def upload(file)
    # validation
    # uploading
    # resizing
    # email notification
    # logging
  end
end
```

### Comments

```ruby
# ✅ Good - Explain "why", not "what"
# Compress JPEG to 85% quality to reduce file size while maintaining visual quality
@image.compress(quality: 85)

# ❌ Bad - Just restates code
# Set quality to 85
@image.compress(quality: 85)
```

### Error Handling

```ruby
# ✅ Good - Specific error handling
begin
  image.validate!
rescue ImageValidator::InvalidFormat => e
  raise "Unsupported image format: #{e.message}"
end

# ❌ Bad - Catch-all rescue
begin
  image.validate!
rescue => e
  puts "Error: #{e}"
end
```

### Database Queries

```ruby
# ✅ Good - Use scopes for complex queries
scope :published, -> { where(published: true) }
scope :by_artist, ->(artist_id) { where(artist_id: artist_id) }

# Usage
artworks = Artwork.published.by_artist(artist_id)

# ❌ Bad - Complex queries in controllers
@artworks = Artwork.where(published: true).where(artist_id: artist_id)
```

### Controller Actions

Keep controllers lean:

```ruby
# ✅ Good - Logic delegated to service
class ArtworksController < ApplicationController
  def create
    artwork = CreateArtwork.new(artwork_params).execute
    render json: artwork
  end
end

# ❌ Bad - Logic in controller
class ArtworksController < ApplicationController
  def create
    artwork = Artwork.new(artwork_params)
    artwork.series = Series.find(params[:series_id])
    artwork.save
    # ... validation, logging, etc.
    render json: artwork
  end
end
```

---

## JavaScript / TypeScript Standards

### File Organization

```
app/javascript/
├── controllers/     # Stimulus controllers
├── components/      # Reusable components
├── utils/          # Helper functions
└── styles/         # CSS modules
```

### Naming Conventions

```javascript
// ✅ Good - camelCase for variables/functions
const uploadedImages = [];
function validateImageFormat() { }

// ✅ Good - PascalCase for classes/components
class ImageUploader { }
function ImageCard() { }

// ❌ Bad - Mixed case conventions
const uploaded_images = [];
function validate_image_format() { }
```

### Code Style

```javascript
// ✅ Good - Use const/let, arrow functions, template literals
const formatDate = (date) => date.toLocaleDateString();
const message = `Image uploaded: ${filename}`;

// ❌ Bad - var, function declarations, concatenation
var formatDate = function(date) { return date.toLocaleDateString(); };
var message = "Image uploaded: " + filename;
```

### Comments

```javascript
// ✅ Good - Explain intent
// Delay execution to allow DOM to fully render before initializing charts
setTimeout(() => initializeCharts(), 100);

// ❌ Bad - Just restates code
// Set timeout 100ms
setTimeout(() => initializeCharts(), 100);
```

---

## HTML / ERB Standards

### Semantic HTML

```erb
<!-- ✅ Good - Semantic markup -->
<article class="artwork-card">
  <header>
    <h2><%= artwork.title %></h2>
  </header>
  <img src="<%= artwork.image %>" alt="<%= artwork.title %>">
  <footer>
    <p>By <%= artwork.artist.name %></p>
  </footer>
</article>

<!-- ❌ Bad - Generic divs -->
<div class="artwork-card">
  <div>
    <span><%= artwork.title %></span>
  </div>
  <img src="<%= artwork.image %>">
  <div>
    <span>By <%= artwork.artist.name %></span>
  </div>
</div>
```

### Accessibility

```erb
<!-- ✅ Good - Accessible -->
<button aria-label="Upload image">
  <svg><!-- icon --></svg>
</button>

<img src="artwork.jpg" alt="Blue ceramic vessel">

<!-- ❌ Bad - Not accessible -->
<button>📤</button>

<img src="artwork.jpg">
```

---

## CSS / Tailwind Standards

### Class Organization

```html
<!-- ✅ Good - Logical order: layout, spacing, sizing, appearance -->
<div class="flex items-center justify-between p-4 w-full bg-white rounded-lg shadow-sm">
```

### Responsive Design

```html
<!-- ✅ Good - Mobile-first approach -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

<!-- ❌ Bad - Desktop-first -->
<div class="grid grid-cols-3 md:grid-cols-2 sm:grid-cols-1 gap-4">
```

### Custom CSS

```css
/* ✅ Good - Only when Tailwind isn't enough */
.artwork-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* ❌ Bad - Recreating Tailwind classes */
.artwork-card {
  padding: 16px;
  margin: 8px;
  background-color: white;
}
```

---

## Testing Standards

### Test Structure

```ruby
# ✅ Good - Clear setup, action, assertion
describe StudioImageUploader do
  describe "#upload" do
    it "uploads image to S3" do
      # Setup
      file = fixture_file_upload('image.jpg')

      # Action
      uploader.upload(file)

      # Assertion
      expect(S3Bucket).to have_received(:upload).with(file)
    end
  end
end

# ❌ Bad - Unclear test structure
it "works" do
  # ???
  expect(something).to be_true
end
```

### Test Naming

```ruby
# ✅ Good - Descriptive test names
it "raises error when file exceeds maximum size"
it "creates artwork with published status"
it "returns 404 when artwork not found"

# ❌ Bad - Vague test names
it "works"
it "tests upload"
it "checks status"
```

---

## Git Commit Standards

### Commit Message Format

```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `refactor:` - Code restructuring (no behavior change)
- `test:` - Adding/updating tests
- `docs:` - Documentation changes
- `style:` - Code style (formatting, semicolons, etc.)
- `chore:` - Build, dependencies, tooling

### Examples

```bash
# ✅ Good
git commit -m "feat(upload): Add image compression before S3 upload"
git commit -m "fix(auth): Redirect to login on expired session"
git commit -m "test(models): Add artist validation tests"

# ❌ Bad
git commit -m "Fixed stuff"
git commit -m "WIP"
git commit -m "updates"
```

---

## Pull Request Standards

### PR Title

```
[FEATURE] Brief description
[BUGFIX] Brief description
[REFACTOR] Brief description
```

### PR Description

Include:
- What changed and why
- Any breaking changes
- Testing instructions
- Related issues/tickets

### Code Review Checklist

Before requesting review, verify:

- [ ] Tests pass locally (`rails test`)
- [ ] Linters pass (`rubocop`, `eslint`)
- [ ] No console errors in browser
- [ ] Code follows standards in this document
- [ ] Documentation updated if needed
- [ ] No hardcoded credentials or secrets

---

## Tools & Linting

### Ruby Linting

```bash
# Run RuboCop
rubocop

# Auto-fix issues
rubocop -A
```

Configuration in `.rubocop.yml` (committed to repo)

### JavaScript Linting

```bash
# Run ESLint
npm run lint

# Auto-fix issues
npm run lint:fix
```

Configuration in `.eslintrc.json` (committed to repo)

### Automatic Formatting

```bash
# Ruby formatting (optional, use sparingly)
rubocop -A

# JavaScript formatting
npx prettier --write "app/javascript/**/*"
```

---

## Code Review Guidelines

### For Authors

- Keep PRs focused on one change
- Keep PR size manageable (under 400 lines)
- Write clear commit messages
- Test before requesting review
- Respond to feedback promptly

### For Reviewers

- Focus on logic, not style (linters handle style)
- Suggest improvements, not demands
- Approve when standards are met
- Be respectful and constructive

---

## Performance Considerations

### Database

```ruby
# ✅ Good - Use eager loading to prevent N+1
artists = Artist.includes(:artworks)

# ❌ Bad - N+1 query problem
artists = Artist.all
artists.each { |artist| puts artist.artworks.count }
```

### Caching

```ruby
# ✅ Good - Cache expensive queries
@featured_artists = Rails.cache.fetch('featured_artists', expires_in: 1.hour) do
  Artist.where(featured: true).limit(5)
end

# ❌ Bad - Query every request
@featured_artists = Artist.where(featured: true).limit(5)
```

---

## Deprecation & Technical Debt

Document with comments:

```ruby
# TODO: Refactor this method - it's getting complex
# FIXME: This query is slow when artists > 10k
# DEPRECATED: Use new_method instead (remove in v2.0)
```

---

## Questions?

If you're unsure about a standard:

1. Check this document
2. Ask in code review
3. Discuss with team
4. Update this document if needed

---

**Version**: 1.0
**Last Updated**: 2025-11-24
**Status**: Active
