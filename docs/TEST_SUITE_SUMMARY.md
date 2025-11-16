# Clay Companion - Model Test Suite Summary

**Generated**: 2025-11-06
**Purpose**: Comprehensive RSpec test suite for all ActiveRecord models

---

## Overview

This test suite provides comprehensive coverage for all 9 ActiveRecord models in the Clay Companion application. The tests are designed to fail initially (since models don't exist yet) and serve as an executable specification for implementing the models according to the database schema and requirements.

**Total Test Files**: 9 model specs + 9 factories + 1 shared examples
**Estimated Test Count**: 400+ individual test cases

---

## Test Organization

### Model Specs (`spec/models/`)
- `artist_spec.rb` - Artist profile model tests
- `series_spec.rb` - Series collection model tests
- `artwork_group_spec.rb` - Artwork grouping model tests
- `artwork_spec.rb` - Individual artwork model tests
- `artwork_image_spec.rb` - Artwork image model tests
- `exhibition_spec.rb` - Exhibition model tests
- `exhibition_image_spec.rb` - Exhibition image model tests
- `press_mention_spec.rb` - Press mention model tests
- `studio_image_spec.rb` - Studio image model tests

### Factories (`spec/factories/`)
- `artists.rb` - Artist factory with traits
- `series.rb` - Series factory with traits
- `artwork_groups.rb` - Artwork group factory
- `artworks.rb` - Artwork factory with traits
- `artwork_images.rb` - Artwork image factory
- `exhibitions.rb` - Exhibition factory with traits
- `press_mentions.rb` - Press mention factory
- `studio_images.rb` - Studio image factory

### Shared Examples (`spec/support/shared_examples/`)
- `image_model_examples.rb` - Reusable tests for image models

---

## Coverage Areas by Model

### 1. Artist Model
**Test Count**: ~70 tests

**Coverage**:
- UUID primary key generation and format
- Email validation (presence, uniqueness, format, case-insensitivity, length)
- Field validations (full_name, bio, artist_statement, location, contact_phone)
- JSONB fields (education, awards, other_links) - default values and persistence
- Associations (has_many: series, artwork_groups, artworks, press_mentions, studio_images, exhibitions)
- Dependent destroy behavior for all associated records
- Factory traits (minimal, with_long_text)

**Key Test Scenarios**:
- Email uniqueness across records (case-insensitive)
- JSONB array manipulation and persistence
- Cascading deletes of all child records
- Maximum length constraints (bio: 2000, full_name: 100, etc.)

### 2. Series Model
**Test Count**: ~40 tests

**Coverage**:
- Associations (belongs_to artist, has_many artwork_groups/artworks)
- Validations (title presence/length, description length)
- Default values (is_ongoing: true, display_order: 0)
- Scopes (ordered, ongoing, completed)
- Display order functionality
- Dependent destroy for artwork_groups

**Key Test Scenarios**:
- Ongoing vs completed series filtering
- Display order sorting
- Scope chaining (ongoing.ordered, completed.ordered)
- Factory traits (completed, minimal, with_groups, with_artworks)

### 3. ArtworkGroup Model
**Test Count**: ~35 tests

**Coverage**:
- Associations (belongs_to artist/series, has_many artworks)
- Optional series relationship
- Validations (title presence/length, description length)
- Scopes (ordered)
- Dependent nullify for artworks
- Artist-series consistency

**Key Test Scenarios**:
- Groups can exist without series
- Destroying group nullifies artwork_group_id on artworks
- Display order functionality
- Factory traits (without_series, minimal, with_artworks)

### 4. Artwork Model
**Test Count**: ~60 tests

**Coverage**:
- Associations (belongs_to artist/artwork_group, has_many artwork_images)
- Validations (title, year range 1900-current+1, medium, dimensions, description, price)
- Price validation (positive, decimal, nil allowed)
- Default values (boolean flags, display_order)
- Scopes (featured, for_sale, sold, ordered)
- Methods (primary_image with multiple fallback strategies)
- Dependent destroy for images

**Key Test Scenarios**:
- Year validation (1900 to current_year + 1)
- Price must be positive if present
- primary_image returns first is_primary or first by display_order
- Scope chaining (featured.ordered, for_sale.ordered)
- Factory traits (featured, sold, for_sale, not_for_sale, minimal, with_images, with_primary_image, in_group, in_series)

### 5. ArtworkImage Model
**Test Count**: ~45 tests

**Coverage**:
- Associations (belongs_to artwork)
- Validations (image_url presence, alt_text length, positive integers for width/height/file_size)
- Default values (is_primary: false, display_order: 0)
- Scopes (ordered, primary)
- Methods (set_as_primary - ensures only one primary per artwork)

**Key Test Scenarios**:
- set_as_primary unsets previous primary image
- Only affects images from same artwork
- Positive integer validation for dimensions
- Factory traits (primary, minimal, high_resolution)

### 6. Exhibition Model
**Test Count**: ~55 tests

**Coverage**:
- Associations (belongs_to artist, has_many exhibition_images)
- Validations (title, description, venue, location, exhibition_type enum, start_date, end_date range, curator)
- Exhibition type validation (solo, group, art_fair, museum)
- Date range validation (end_date >= start_date)
- Scopes (ordered, ongoing, past, upcoming, by_type)
- Methods (ongoing? checks if current date is within range)
- Dependent destroy for images

**Key Test Scenarios**:
- Exhibition type must be one of: solo, group, art_fair, museum
- end_date must be after or equal to start_date
- ongoing? method handles exhibitions with no end_date
- Scope filtering by status (ongoing, past, upcoming)
- by_type scope for filtering by exhibition_type
- Factory traits (solo, group, art_fair, museum, ongoing, past, upcoming, no_end_date, minimal, with_images)

### 7. ExhibitionImage Model
**Test Count**: ~30 tests

**Coverage**:
- Associations (belongs_to exhibition)
- Validations (image_url presence, alt_text length, positive integers for width/height/file_size)
- Default values (display_order: 0)
- Scopes (ordered)
- Display order functionality

**Key Test Scenarios**:
- Standard image validations
- Display order sorting
- Factory traits (minimal, high_resolution)

### 8. PressMention Model
**Test Count**: ~40 tests

**Coverage**:
- Associations (belongs_to artist)
- Validations (title, publication, author, excerpt lengths, URL format)
- URL format validation (http/https only)
- Default values (display_order: 0)
- Scopes (ordered, recent by published_date desc)

**Key Test Scenarios**:
- URL must be valid http/https format
- recent scope orders by published_date descending
- Handles nil published_date appropriately
- Factory traits (recent, old, minimal, with_long_excerpt)

### 9. StudioImage Model
**Test Count**: ~35 tests

**Coverage**:
- Associations (belongs_to artist)
- Validations (image_url presence, alt_text length, caption length, positive integers for width/height/file_size)
- Default values (display_order: 0)
- Scopes (ordered)
- Display order functionality

**Key Test Scenarios**:
- Caption validation (max 1000 characters)
- Standard image validations
- Factory traits (minimal, with_long_caption, high_resolution)

---

## Testing Patterns & Best Practices

### 1. Arrange-Act-Assert Pattern
All tests follow the AAA pattern for clarity:
```ruby
it 'unsets previous primary when setting new primary' do
  # Arrange
  old_primary = create(:artwork_image, :primary, artwork: artwork)
  new_primary = create(:artwork_image, artwork: artwork)

  # Act
  new_primary.set_as_primary

  # Assert
  expect(old_primary.reload.is_primary).to be false
  expect(new_primary.reload.is_primary).to be true
end
```

### 2. Descriptive Test Names
Test names clearly state expected behavior:
- GOOD: `'rejects year before 1900'`
- BAD: `'test year validation'`

### 3. Edge Case Coverage
Tests cover:
- Boundary values (max length, min/max years)
- Nil/empty values
- Format validation edge cases
- Dependent destroy/nullify behavior
- Scope chaining

### 4. Factory Traits for Flexibility
Factories include traits for common scenarios:
```ruby
create(:artwork, :featured)
create(:artwork, :sold)
create(:exhibition, :ongoing)
create(:series, :completed)
```

### 5. Shared Examples for DRY Tests
Common image model behavior extracted to shared examples:
```ruby
RSpec.describe ArtworkImage do
  it_behaves_like 'an image model'
  it_behaves_like 'a model with display_order'
end
```

---

## Running the Tests

### Run all model tests:
```bash
bundle exec rspec spec/models
```

### Run specific model test:
```bash
bundle exec rspec spec/models/artist_spec.rb
```

### Run with documentation format:
```bash
bundle exec rspec spec/models --format documentation
```

### Run with coverage report:
```bash
COVERAGE=true bundle exec rspec spec/models
```

---

## Expected Initial Test Results

Since the models don't exist yet, **all tests will fail initially**. This is expected behavior for TDD.

### Common Initial Errors:
1. `NameError: uninitialized constant Artist` - Model class doesn't exist
2. `ActiveRecord::StatementInvalid` - Database table exists but model is missing
3. `NoMethodError: undefined method 'ongoing'` - Scopes not implemented
4. Validation failures - Validations not defined in model

### Implementation Order:
1. Create model class inheriting from ApplicationRecord
2. Define associations
3. Add validations
4. Implement scopes
5. Implement custom methods (primary_image, set_as_primary, ongoing?)
6. Add callbacks if needed

---

## Test Coverage Goals

- **Line Coverage**: 100% for models
- **Branch Coverage**: 95%+ for conditional logic
- **All validations tested**: Presence, length, format, numericality, custom
- **All associations tested**: Relationships and dependent behavior
- **All scopes tested**: Query results and chaining
- **All methods tested**: Happy path, edge cases, error conditions

---

## Test Omissions & Justifications

### Intentionally NOT Tested:
1. **Database-level constraints** - These are tested implicitly through validation tests
2. **ActiveRecord internal methods** - We trust the framework (save, update, destroy)
3. **Timestamp fields (created_at, updated_at)** - Rails handles these automatically
4. **Foreign key constraints** - Database enforces these, validated through association tests

### Future Test Additions (Post-MVP):
1. **Performance tests** - N+1 query detection, eager loading tests
2. **Database index usage** - Query performance tests
3. **Concurrent update handling** - Optimistic locking tests
4. **Data migration tests** - Schema change compatibility

---

## Maintenance Guidelines

### When Adding New Fields:
1. Update factory with realistic default value
2. Add validation tests (presence, length, format, etc.)
3. Update relevant specs if field affects scopes/methods
4. Add factory trait if field has common states

### When Adding New Associations:
1. Add association test (belong_to/has_many)
2. Test dependent behavior (destroy/nullify)
3. Update factory to support association
4. Test cascading behavior

### When Adding New Methods:
1. Test happy path
2. Test edge cases (nil values, empty collections)
3. Test error conditions
4. Document method purpose in spec comments

### When Adding New Scopes:
1. Test scope returns correct records
2. Test scope with empty results
3. Test scope chaining with other scopes
4. Test scope parameters (if applicable)

---

## Dependencies

- **RSpec Rails** - Testing framework
- **FactoryBot** - Test data generation
- **Shoulda Matchers** - Concise validation/association tests
- **Database Cleaner** - Test isolation
- **SimpleCov** - Code coverage reporting

---

## Additional Resources

- **RSpec Documentation**: https://rspec.info/
- **FactoryBot Documentation**: https://github.com/thoughtbot/factory_bot
- **Shoulda Matchers**: https://matchers.shoulda.io/
- **Rails Testing Guide**: https://guides.rubyonrails.org/testing.html

---

**Next Steps**:
1. Run tests to see failures: `bundle exec rspec spec/models`
2. Implement models one at a time
3. Watch tests turn green as you implement features
4. Refactor with confidence knowing tests verify behavior
