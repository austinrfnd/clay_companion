# Model Test Suite

This directory contains comprehensive RSpec tests for all 9 ActiveRecord models in the Clay Companion application.

## Test Statistics

- **Test Files**: 9 model specs
- **Test Cases**: 288+ individual tests
- **Test Blocks**: 158 describe/context blocks
- **Factories**: 9 FactoryBot factories with multiple traits
- **Shared Examples**: 1 file with reusable image model tests

## Files in This Directory

### Model Specs
- `artist_spec.rb` - Tests for Artist model (UUID, JSONB, validations, associations)
- `series_spec.rb` - Tests for Series model (scopes, display order, associations)
- `artwork_group_spec.rb` - Tests for ArtworkGroup model (optional series, nullify behavior)
- `artwork_spec.rb` - Tests for Artwork model (year range, price, primary_image method)
- `artwork_image_spec.rb` - Tests for ArtworkImage model (set_as_primary method, scopes)
- `exhibition_spec.rb` - Tests for Exhibition model (date range, exhibition_type enum, ongoing? method)
- `exhibition_image_spec.rb` - Tests for ExhibitionImage model (image validations)
- `press_mention_spec.rb` - Tests for PressMention model (URL format, recent scope)
- `studio_image_spec.rb` - Tests for StudioImage model (caption validation, image fields)

## Running Tests

### All model tests:
```bash
docker compose exec web bundle exec rspec spec/models
```

### Specific model test:
```bash
docker compose exec web bundle exec rspec spec/models/artist_spec.rb
```

### With documentation format:
```bash
docker compose exec web bundle exec rspec spec/models --format documentation
```

### Run a specific test:
```bash
docker compose exec web bundle exec rspec spec/models/artist_spec.rb:23
```

## Test Coverage

Each model spec covers:

1. **Associations** - belongs_to, has_many, dependent behavior
2. **Validations** - presence, length, format, numericality, custom
3. **Default Values** - boolean flags, display_order, JSONB arrays
4. **Scopes** - filtering, ordering, chaining
5. **Custom Methods** - business logic, computed values
6. **Edge Cases** - boundary values, nil handling, error conditions
7. **Factory Traits** - common test scenarios

## Implementation Guide

These tests are designed for **Test-Driven Development (TDD)**. Follow this workflow:

1. **Run tests** - See failures (models don't exist yet)
2. **Create model** - Generate Rails model: `rails g model Artist`
3. **Define associations** - Add `belongs_to`, `has_many` declarations
4. **Add validations** - Add validation rules to match test expectations
5. **Implement scopes** - Add scope definitions
6. **Implement methods** - Add custom methods (primary_image, set_as_primary, ongoing?)
7. **Run tests again** - Watch tests turn green
8. **Refactor** - Improve code while tests remain green

## Test Organization

Tests use the following structure:

```ruby
RSpec.describe ModelName, type: :model do
  describe 'associations' do
    # Test relationships with other models
  end

  describe 'validations' do
    # Test field validation rules
  end

  describe 'scopes' do
    # Test query scopes
  end

  describe '#method_name' do
    # Test custom instance methods
  end

  describe 'factory' do
    # Test factory and traits work correctly
  end
end
```

## Key Testing Patterns

### 1. Shoulda Matchers
Concise validation and association tests:
```ruby
it { is_expected.to validate_presence_of(:email) }
it { is_expected.to belong_to(:artist) }
```

### 2. FactoryBot
Generate test data easily:
```ruby
artist = create(:artist)
artwork = build(:artwork, :featured)
```

### 3. Descriptive Test Names
```ruby
it 'rejects email exceeding 255 characters'
it 'destroys associated artworks when artist is destroyed'
```

### 4. Context Blocks
Group related tests:
```ruby
context 'when exhibition is ongoing' do
  it 'returns true'
end
```

## Common Test Failures (When Implementing)

### Missing Model Class
```
NameError: uninitialized constant Artist
```
**Solution**: Create the model file: `touch app/models/artist.rb`

### Missing Validation
```
expected Artist to validate presence of email
```
**Solution**: Add validation: `validates :email, presence: true`

### Missing Scope
```
NoMethodError: undefined method 'ongoing'
```
**Solution**: Add scope: `scope :ongoing, -> { where('end_date >= ?', Date.today) }`

### Missing Method
```
NoMethodError: undefined method 'primary_image'
```
**Solution**: Implement the method in the model

## Test Dependencies

All necessary gems are configured in `spec/rails_helper.rb`:

- **RSpec Rails** - Testing framework
- **FactoryBot** - Test data factories
- **Shoulda Matchers** - Validation/association matchers
- **Database Cleaner** - Test database cleanup
- **SimpleCov** - Code coverage

## Additional Resources

- **Full Test Summary**: See `/spec/TEST_SUITE_SUMMARY.md`
- **Factories**: See `/spec/factories/`
- **Shared Examples**: See `/spec/support/shared_examples/`
- **RSpec Documentation**: https://rspec.info/
- **Rails Testing Guide**: https://guides.rubyonrails.org/testing.html

---

**Next Steps**: Start implementing models to make these tests pass!
