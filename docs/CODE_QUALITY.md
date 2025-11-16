# Clay Companion - Code Quality Standards

Comprehensive code quality standards for Ruby on Rails development. These standards are **mandatory** for all code contributions.

## Table of Contents
1. [Documentation Standards](#documentation-standards)
2. [Internationalization (i18n)](#internationalization-i18n)
3. [Ruby Style Guide](#ruby-style-guide)
4. [Rails Best Practices](#rails-best-practices)
5. [Testing Standards](#testing-standards)
6. [Security Standards](#security-standards)
7. [Performance Guidelines](#performance-guidelines)
8. [Accessibility Standards](#accessibility-standards)
9. [Git Commit Standards](#git-commit-standards)
10. [Code Review Checklist](#code-review-checklist)

---

## Documentation Standards

### File Headers

**Every file** must have a header comment explaining its purpose.

```ruby
# frozen_string_literal: true

##
# Artist model
#
# Represents a ceramic artist account with portfolio management capabilities.
# Artists can create artworks, organize them into series, and maintain
# public portfolios with exhibitions and press mentions.
#
# @see Artwork
# @see Series
class Artist < ApplicationRecord
  # ...
end
```

```ruby
# frozen_string_literal: true

##
# Dashboard::ArtworksController
#
# Handles CRUD operations for artworks in the artist dashboard.
# Requires authentication and enforces artist ownership for all actions.
#
# @see Artwork
# @see ArtworkCreator
class Dashboard::ArtworksController < ApplicationController
  # ...
end
```

### Method Documentation

**Every public method** must have YARD-formatted documentation.

```ruby
##
# Creates a new artwork for the given artist
#
# Handles image upload, processing, and series assignment.
# Sets default visibility to 'private' unless specified.
#
# @param artist [Artist] the artist creating the artwork
# @param params [Hash] artwork attributes
# @option params [String] :title the artwork title (required)
# @option params [Integer] :year the creation year
# @option params [String] :visibility ('private') public, private, or featured
# @option params [Array<File>] :images uploaded image files
#
# @return [Result] success result with artwork, or failure with errors
#
# @example
#   result = ArtworkCreator.new(artist, title: 'Vase', year: 2024).call
#   if result.success?
#     artwork = result.value
#   end
def call
  # Implementation
end
```

**Complex private methods** should have comments.

```ruby
private

# Processes uploaded images and generates variants
# Creates thumbnail (300x300) and gallery (800x800) versions
def process_images
  @artwork.images.each do |image|
    image.variant(resize_to_limit: [300, 300]).processed
    image.variant(resize_to_limit: [800, 800]).processed
  end
end
```

### Inline Comments

Use inline comments for:
- Complex business logic
- Non-obvious code decisions
- Performance optimizations
- Workarounds for bugs

```ruby
def portfolio_url
  # Use parameterize to ensure URL-safe username
  # Handles special characters, spaces, and unicode
  "/#{username.parameterize}"
end

# Eager load associations to prevent N+1 queries
# Average portfolio has 20-50 artworks, so this is more efficient
# than lazy loading
def featured_artworks
  artworks.includes(:series, images_attachments: :blob)
           .where(visibility: 'featured')
           .order(created_at: :desc)
end
```

### TODO Comments

Use standardized format for TODOs.

```ruby
# TODO: Add image compression before upload (Issue #45)
# TODO(austin): Implement caching for this query (Performance)
# FIXME: Handle nil case when artist has no artworks
# OPTIMIZE: Use counter_cache to avoid COUNT query
# HACK: Temporary workaround for upstream bug in Active Storage
```

---

## Internationalization (i18n)

### No Hardcoded Strings

**NEVER** hardcode user-facing text in views, controllers, or models.

```ruby
# ❌ BAD: Hardcoded string
flash[:notice] = "Artwork created successfully"

# ✅ GOOD: i18n key
flash[:notice] = t('.success')
```

```erb
<!-- ❌ BAD: Hardcoded string -->
<h1>My Artworks</h1>
<p>You haven't created any artworks yet.</p>

<!-- ✅ GOOD: i18n keys -->
<h1><%= t('.title') %></h1>
<p><%= t('.empty_state') %></p>
```

### Locale File Organization

Organize translations by namespace matching file structure.

```yaml
# config/locales/en.yml
en:
  # Global translations
  common:
    save: "Save"
    cancel: "Cancel"
    delete: "Delete"
    edit: "Edit"

  # Model names
  activerecord:
    models:
      artist:
        one: "Artist"
        other: "Artists"
      artwork:
        one: "Artwork"
        other: "Artworks"
    attributes:
      artwork:
        title: "Title"
        description: "Description"
        year: "Year Created"

  # Controller-specific
  dashboard:
    artworks:
      index:
        title: "My Artworks"
        empty_state: "You haven't created any artworks yet."
        add_button: "Add Artwork"
      create:
        success: "Artwork created successfully"
        error: "Unable to create artwork"
      update:
        success: "Artwork updated successfully"
        error: "Unable to update artwork"
      destroy:
        success: "Artwork deleted successfully"
        error: "Unable to delete artwork"
        confirm: "Are you sure you want to delete this artwork?"

  # Validation messages
  errors:
    messages:
      blank: "can't be blank"
      too_long: "is too long (maximum is %{count} characters)"
      too_short: "is too short (minimum is %{count} characters)"
      invalid_format: "has an invalid format"
```

### Using Translations

```ruby
# Controllers - use lazy lookup with leading dot
class Dashboard::ArtworksController < ApplicationController
  def create
    if @artwork.save
      flash[:notice] = t('.success')  # dashboard.artworks.create.success
      redirect_to dashboard_path
    else
      flash[:alert] = t('.error')  # dashboard.artworks.create.error
      render :new
    end
  end
end
```

```erb
<!-- Views - use lazy lookup -->
<h1><%= t('.title') %></h1>
<p><%= t('.empty_state') %></p>

<!-- With interpolation -->
<p><%= t('.artwork_count', count: @artworks.count) %></p>

<!-- With HTML -->
<p><%= t('.terms_html', link: link_to('terms', terms_path)) %></p>
```

```ruby
# Models - use activerecord namespace
class Artwork < ApplicationRecord
  validates :title, presence: {
    message: I18n.t('errors.messages.blank')
  }
end
```

### Pluralization

```yaml
en:
  artworks:
    count:
      zero: "No artworks"
      one: "1 artwork"
      other: "%{count} artworks"
```

```erb
<%= t('artworks.count', count: @artworks.count) %>
```

---

## Ruby Style Guide

### General Principles

1. **Follow Ruby Style Guide** - https://rubystyle.guide/
2. **Use RuboCop** - Automated style checking
3. **Be consistent** - Match existing code style

### Code Style

```ruby
# Use 2 spaces for indentation (no tabs)
def method_name
  if condition
    do_something
  end
end

# Use snake_case for methods and variables
def calculate_total_price
  item_count = items.size
end

# Use SCREAMING_SNAKE_CASE for constants
MAX_UPLOAD_SIZE = 10.megabytes
DEFAULT_VISIBILITY = 'private'

# Use CamelCase for classes and modules
class ArtworkCreator
  module ImageProcessor
  end
end

# Prefer single quotes unless interpolation needed
title = 'Celadon Vase'
message = "Artist #{artist.name} created #{title}"

# Use Ruby 3.0+ endless methods for simple one-liners
def full_name = "#{first_name} #{last_name}"
def portfolio_url = "/#{username}"

# Use Ruby 3.0+ pattern matching
case artwork
in { type: 'bowl', visibility: 'public' }
  show_bowl_details
in { type: 'vase', visibility: 'featured' }
  show_featured_vase
else
  show_default_view
end

# Avoid unnecessary conditionals
# ❌ BAD
def featured?
  if visibility == 'featured'
    true
  else
    false
  end
end

# ✅ GOOD
def featured?
  visibility == 'featured'
end

# Use guard clauses for early returns
# ❌ BAD
def process_artwork(artwork)
  if artwork.present?
    if artwork.images.any?
      process_images(artwork)
    end
  end
end

# ✅ GOOD
def process_artwork(artwork)
  return if artwork.blank?
  return if artwork.images.none?

  process_images(artwork)
end

# Prefer blocks with {} for single-line, do..end for multi-line
artworks.each { |artwork| artwork.publish }

artworks.each do |artwork|
  artwork.publish
  artwork.notify_followers
end

# Use &: shorthand for simple blocks
artworks.map(&:title)
artworks.select(&:featured?)

# Use safe navigation operator
@artist&.portfolio_url  # Instead of: @artist.try(:portfolio_url)
```

### Method Organization

```ruby
class Artwork < ApplicationRecord
  # 1. Constants
  MAX_IMAGES = 10
  VALID_TYPES = %w[bowl vase plate sculpture].freeze

  # 2. Concerns
  include Searchable
  include Sluggable

  # 3. Attributes/Enums
  enum visibility: { private: 0, public: 1, featured: 2 }

  # 4. Associations
  belongs_to :artist
  belongs_to :series, optional: true
  has_many_attached :images

  # 5. Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :year, numericality: { only_integer: true }

  # 6. Callbacks
  before_save :generate_slug
  after_create :notify_artist

  # 7. Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :featured, -> { where(visibility: 'featured') }

  # 8. Class methods
  def self.search(query)
    where('title ILIKE ?', "%#{query}%")
  end

  # 9. Public instance methods
  def portfolio_url
    "/#{artist.username}/artworks/#{slug}"
  end

  def thumbnail
    images.first&.variant(resize_to_limit: [300, 300])
  end

  # 10. Private instance methods
  private

  def generate_slug
    self.slug = title.parameterize
  end

  def notify_artist
    # Implementation
  end
end
```

---

## Rails Best Practices

### Controllers

**Keep controllers thin** - Move business logic to services/models.

```ruby
# ❌ BAD: Business logic in controller
class Dashboard::ArtworksController < ApplicationController
  def create
    @artwork = current_artist.artworks.build(artwork_params)
    @artwork.visibility = 'private' unless artwork_params[:visibility]

    if @artwork.save
      if params[:images].present?
        params[:images].each do |image|
          @artwork.images.attach(image)
        end

        @artwork.images.each do |image|
          image.variant(resize_to_limit: [300, 300]).processed
          image.variant(resize_to_limit: [800, 800]).processed
        end
      end

      if @artwork.series.present?
        @artwork.series.touch
      end

      flash[:notice] = t('.success')
      redirect_to dashboard_path
    else
      flash[:alert] = t('.error')
      render :new
    end
  end
end

# ✅ GOOD: Business logic in service
class Dashboard::ArtworksController < ApplicationController
  def create
    result = ArtworkCreator.new(current_artist, artwork_params).call

    if result.success?
      flash[:notice] = t('.success')
      redirect_to dashboard_path
    else
      @artwork = result.value
      flash[:alert] = t('.error')
      render :new
    end
  end
end

# app/services/artwork_creator.rb
class ArtworkCreator
  def initialize(artist, params)
    @artist = artist
    @params = params
  end

  def call
    artwork = build_artwork

    return Result.failure(artwork) unless artwork.save

    attach_images(artwork)
    process_images(artwork)
    touch_series(artwork)

    Result.success(artwork)
  end

  private

  def build_artwork
    @artist.artworks.build(@params).tap do |artwork|
      artwork.visibility ||= 'private'
    end
  end

  # ... other private methods
end
```

**Use strong parameters**

```ruby
def artwork_params
  params.require(:artwork).permit(
    :title,
    :description,
    :year,
    :type,
    :visibility,
    :series_id,
    images: []
  )
end
```

**Use before_action for common setup**

```ruby
class Dashboard::ArtworksController < ApplicationController
  before_action :authenticate_artist!
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :authorize_artwork, only: [:edit, :update, :destroy]

  private

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def authorize_artwork
    redirect_to dashboard_path unless @artwork.artist == current_artist
  end
end
```

### Models

**Use scopes for common queries**

```ruby
class Artwork < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
  scope :featured, -> { where(visibility: 'featured') }
  scope :by_year, ->(year) { where(year: year) }
  scope :with_images, -> { includes(images_attachments: :blob) }

  # Chainable
  # Artwork.featured.recent.by_year(2024)
end
```

**Validate at model level**

```ruby
class Artwork < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :year, numericality: {
    only_integer: true,
    greater_than: 1900,
    less_than_or_equal_to: -> { Date.current.year }
  }
  validates :visibility, inclusion: { in: %w[private public featured] }
  validates :images, limit: { max: 10 }

  validate :at_least_one_image

  private

  def at_least_one_image
    errors.add(:images, :blank) if images.none?
  end
end
```

**Avoid N+1 queries**

```ruby
# ❌ BAD: N+1 query (1 query + N queries for artworks)
@artists = Artist.all
@artists.each do |artist|
  puts artist.artworks.count  # Separate query for each artist!
end

# ✅ GOOD: Single query with counter cache
@artists = Artist.all
@artists.each do |artist|
  puts artist.artworks_count  # Uses counter_cache, no extra query
end

# ❌ BAD: N+1 query (1 query + N queries for images)
@artworks = Artwork.all
@artworks.each do |artwork|
  artwork.images.each { |img| puts img.url }  # Separate query!
end

# ✅ GOOD: Eager load associations
@artworks = Artwork.includes(images_attachments: :blob)
@artworks.each do |artwork|
  artwork.images.each { |img| puts img.url }  # Already loaded
end
```

**Use database constraints**

```ruby
class CreateArtworks < ActiveRecord::Migration[7.2]
  def change
    create_table :artworks do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :year, null: false
      t.string :visibility, null: false, default: 'private'

      t.timestamps
    end

    add_index :artworks, [:artist_id, :visibility]
    add_index :artworks, :created_at
  end
end
```

### Services

**Use service objects for complex business logic**

```ruby
# app/services/application_service.rb
class ApplicationService
  def self.call(...) = new(...).call
end

# app/services/artwork_creator.rb
##
# ArtworkCreator
#
# Creates a new artwork with image processing and series assignment.
class ArtworkCreator < ApplicationService
  def initialize(artist, params)
    @artist = artist
    @params = params
  end

  def call
    artwork = build_artwork

    return Result.failure(artwork) unless artwork.save

    process_creation(artwork)
    Result.success(artwork)
  end

  private

  def build_artwork
    @artist.artworks.build(@params).tap do |artwork|
      artwork.visibility ||= 'private'
    end
  end

  def process_creation(artwork)
    attach_images(artwork) if @params[:images].present?
    touch_series(artwork) if artwork.series.present?
  end

  def attach_images(artwork)
    @params[:images].each { |image| artwork.images.attach(image) }
    ImageProcessorJob.perform_later(artwork.id)
  end

  def touch_series(artwork)
    artwork.series.touch
  end
end

# Usage
result = ArtworkCreator.call(artist, params)
if result.success?
  artwork = result.value
else
  errors = result.errors
end
```

### Views

**Use partials to avoid duplication**

```erb
<!-- app/views/artworks/_artwork.html.erb -->
<div class="artwork-card">
  <%= image_tag artwork.thumbnail, alt: artwork.title %>
  <h3><%= artwork.title %></h3>
  <p><%= artwork.year %></p>
</div>

<!-- app/views/dashboard/artworks/index.html.erb -->
<%= render @artworks %>  <!-- Automatically renders _artwork partial -->
```

**Use helpers for complex view logic**

```ruby
# app/helpers/artworks_helper.rb
module ArtworksHelper
  ##
  # Returns CSS class based on artwork visibility
  def visibility_badge_class(artwork)
    case artwork.visibility
    when 'public'   then 'badge-success'
    when 'featured' then 'badge-primary'
    else                 'badge-secondary'
    end
  end
end
```

```erb
<span class="badge <%= visibility_badge_class(@artwork) %>">
  <%= @artwork.visibility %>
</span>
```

---

## Testing Standards

See [DEVELOPMENT.md](DEVELOPMENT.md) for complete TDD workflow.

**Model Implementation**: When implementing new models, refer to [MODEL_IMPLEMENTATION_CHECKLIST.md](MODEL_IMPLEMENTATION_CHECKLIST.md) for a comprehensive checklist of required associations, validations, scopes, and methods.

### HTML Test Attributes (Mandatory)

**All interactive HTML elements** must have `data-test-id` attributes for E2E testing.

```erb
<!-- ❌ BAD: No test attributes -->
<form>
  <input type="text" name="artwork[title]" />
  <button type="submit">Create Artwork</button>
</form>

<!-- ✅ GOOD: Test attributes on all interactive elements -->
<form data-test-id="artwork-form">
  <input
    type="text"
    name="artwork[title]"
    data-test-id="artwork-title-input"
  />
  <button type="submit" data-test-id="artwork-submit-button">
    <%= t('.submit') %>
  </button>
</form>
```

**Naming Convention for data-test-id**:
- Use kebab-case (lowercase with hyphens)
- Format: `{resource}-{element}-{type}`
- Examples:
  - `artwork-title-input`
  - `artwork-submit-button`
  - `series-delete-link`
  - `gallery-image-card`
  - `nav-dashboard-link`

**Elements that MUST have data-test-id**:
- All form inputs (`<input>`, `<textarea>`, `<select>`)
- All buttons (`<button>`, `<input type="submit">`)
- All links that trigger actions (`<a>`)
- All interactive cards or containers
- All modals, dialogs, dropdowns
- All navigation elements
- Any element referenced in E2E tests

**Example: Complete Form**
```erb
<div data-test-id="artwork-form-container">
  <%= form_with model: @artwork, data: { test_id: 'artwork-form' } do |f| %>
    <div class="form-group">
      <%= f.label :title, t('.title_label') %>
      <%= f.text_field :title, data: { test_id: 'artwork-title-input' } %>
    </div>

    <div class="form-group">
      <%= f.label :year, t('.year_label') %>
      <%= f.number_field :year, data: { test_id: 'artwork-year-input' } %>
    </div>

    <div class="form-group">
      <%= f.label :visibility, t('.visibility_label') %>
      <%= f.select :visibility,
                   options_for_select(@visibility_options),
                   {},
                   data: { test_id: 'artwork-visibility-select' } %>
    </div>

    <div class="form-group">
      <%= f.label :images, t('.images_label') %>
      <%= f.file_field :images,
                       multiple: true,
                       data: { test_id: 'artwork-images-input' } %>
    </div>

    <div class="form-actions">
      <%= f.submit t('.submit'), data: { test_id: 'artwork-submit-button' } %>
      <%= link_to t('.cancel'), dashboard_path, data: { test_id: 'artwork-cancel-link' } %>
    </div>
  <% end %>
</div>
```

**Example: Navigation**
```erb
<nav data-test-id="main-navigation">
  <%= link_to t('.dashboard'), dashboard_path, data: { test_id: 'nav-dashboard-link' } %>
  <%= link_to t('.catalog'), dashboard_artworks_path, data: { test_id: 'nav-catalog-link' } %>
  <%= link_to t('.series'), dashboard_series_path, data: { test_id: 'nav-series-link' } %>
  <%= link_to t('.settings'), dashboard_settings_path, data: { test_id: 'nav-settings-link' } %>
</nav>
```

**Using in Tests**
```ruby
# spec/system/artwork_creation_spec.rb
RSpec.describe 'Artwork Creation', type: :system do
  it 'allows artist to create artwork' do
    visit new_dashboard_artwork_path

    # Find elements by data-test-id
    within('[data-test-id="artwork-form"]') do
      fill_in '[data-test-id="artwork-title-input"]', with: 'Celadon Vase'
      fill_in '[data-test-id="artwork-year-input"]', with: '2024'
      select 'Public', from: '[data-test-id="artwork-visibility-select"]'
      attach_file '[data-test-id="artwork-images-input"]', file_path

      click_button '[data-test-id="artwork-submit-button"]'
    end

    expect(page).to have_content('Artwork created successfully')
  end
end
```

**Benefits**:
- Tests are resilient to CSS/class changes
- Clear intent (test-specific attributes)
- Easy to find elements in tests
- No reliance on user-facing text (which may change with i18n)
- No reliance on implementation details (CSS classes)

### Test Organization

```ruby
# spec/models/artwork_spec.rb
require 'rails_helper'

RSpec.describe Artwork, type: :model do
  # Use let for test data
  let(:artist) { create(:artist) }
  let(:artwork) { build(:artwork, artist: artist) }

  # Group related tests
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
  end

  describe 'associations' do
    it { should belong_to(:artist) }
    it { should belong_to(:series).optional }
  end

  describe '#portfolio_url' do
    it 'returns the correct URL' do
      expect(artwork.portfolio_url).to eq("/#{artist.username}/artworks/#{artwork.slug}")
    end

    context 'when artist username has spaces' do
      let(:artist) { create(:artist, username: 'jane potter') }

      it 'parameterizes the username' do
        expect(artwork.portfolio_url).to include('jane-potter')
      end
    end
  end
end
```

### Test Coverage Goals

- **Models**: 100% coverage (easy to achieve)
- **Services**: 100% coverage (critical business logic)
- **Controllers**: 90%+ coverage
- **Helpers**: 90%+ coverage
- **Overall**: 90%+ coverage

---

## Security Standards

### Never Trust User Input

```ruby
# ❌ BAD: SQL injection vulnerability
Artwork.where("title = '#{params[:title]}'")

# ✅ GOOD: Parameterized query
Artwork.where(title: params[:title])
Artwork.where("title ILIKE ?", "%#{params[:query]}%")

# ❌ BAD: XSS vulnerability
<%= raw @artwork.description %>

# ✅ GOOD: Escaped by default
<%= @artwork.description %>

# ✅ GOOD: Sanitized HTML if rich text needed
<%= sanitize @artwork.description, tags: %w[p br strong em] %>
```

### Use Strong Parameters

```ruby
# Never permit all params
params.require(:artwork).permit!  # ❌ DANGEROUS

# Explicitly permit each attribute
params.require(:artwork).permit(:title, :description, :year)  # ✅ SAFE
```

### No Hardcoded Secrets

```ruby
# ❌ BAD
AWS_ACCESS_KEY = 'AKIAIOSFODNN7EXAMPLE'

# ✅ GOOD
AWS_ACCESS_KEY = ENV.fetch('AWS_ACCESS_KEY')
```

---

## Performance Guidelines

### Database

```ruby
# Use eager loading to avoid N+1
Artwork.includes(:artist, :series, images_attachments: :blob)

# Use counter caches
class Artist < ApplicationRecord
  has_many :artworks
end
class Artwork < ApplicationRecord
  belongs_to :artist, counter_cache: true
end
# Migration: add_column :artists, :artworks_count, :integer, default: 0

# Use database indexes
add_index :artworks, :artist_id
add_index :artworks, [:artist_id, :visibility]
add_index :artists, :username, unique: true
```

### Caching (Future)

```ruby
# Fragment caching
<% cache @artwork do %>
  <%= render @artwork %>
<% end %>

# Russian doll caching
<% cache ['v1', @artist] do %>
  <% cache ['v1', @artist, @artwork] do %>
    <%= render @artwork %>
  <% end %>
<% end %>
```

---

## Accessibility Standards

### Semantic HTML

```erb
<!-- ❌ BAD -->
<div class="button" onclick="submit()">Submit</div>

<!-- ✅ GOOD -->
<button type="submit"><%= t('.submit') %></button>
```

### ARIA Labels

```erb
<button aria-label="<%= t('.delete_artwork', title: @artwork.title) %>">
  <%= icon('trash') %>
</button>

<nav aria-label="<%= t('.main_navigation') %>">
  <!-- Navigation links -->
</nav>
```

### Keyboard Navigation

```javascript
// Stimulus controller
export default class extends Controller {
  connect() {
    this.element.setAttribute('tabindex', '0')
    this.element.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    if (event.key === 'Enter' || event.key === ' ') {
      this.click()
    }
  }
}
```

---

## Git Commit Standards

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, no logic change)
- `refactor`: Code change that neither fixes bug nor adds feature
- `test`: Adding or updating tests
- `chore`: Maintenance (dependencies, config)

### Examples

```
feat(artworks): add image upload functionality

Allow artists to upload up to 10 images per artwork.
Images are automatically processed into thumbnail and
gallery variants using Active Storage.

Closes #42

---

fix(auth): prevent duplicate email registration

Add unique index to artists.email and handle
ActiveRecord::RecordNotUnique exception.

Fixes #38

---

docs(api): add API endpoint documentation

Document all API v1 endpoints with request/response
examples and authentication requirements.
```

---

## Code Review Checklist

Before submitting code for review:

- [ ] All tests pass locally
- [ ] New code has tests (unit + integration)
- [ ] Code follows style guide (RuboCop passes)
- [ ] All files have header documentation
- [ ] All public methods have YARD documentation
- [ ] No hardcoded strings (i18n used)
- [ ] All interactive HTML elements have `data-test-id` attributes
- [ ] No N+1 queries (checked with Bullet gem)
- [ ] No security vulnerabilities (Brakeman passes)
- [ ] Accessibility requirements met
- [ ] Mobile responsive (tested on small screen)
- [ ] Git commit messages follow format
- [ ] No commented-out code
- [ ] No `binding.pry` or debugging code
- [ ] Environment variables documented (if added)

---

**These standards are mandatory.** Code that doesn't meet these standards will be rejected in review.
