# Model Implementation Checklist

Use this checklist when implementing each model to ensure all test requirements are met.

---

## 1. Artist Model

**File**: `app/models/artist.rb`

### Associations
- [ ] `has_many :series, dependent: :destroy`
- [ ] `has_many :artwork_groups, dependent: :destroy`
- [ ] `has_many :artworks, dependent: :destroy`
- [ ] `has_many :press_mentions, dependent: :destroy`
- [ ] `has_many :studio_images, dependent: :destroy`
- [ ] `has_many :exhibitions, dependent: :destroy`

### Validations
- [ ] `validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }`
- [ ] `validates :full_name, presence: true, length: { maximum: 100 }`
- [ ] `validates :bio, length: { maximum: 2000 }`
- [ ] `validates :artist_statement, length: { maximum: 2000 }`
- [ ] `validates :location, length: { maximum: 100 }`
- [ ] `validates :contact_phone, length: { maximum: 20 }`

### Notes
- UUID primary key (handled by schema)
- JSONB fields: `education`, `awards`, `other_links` default to `[]` (handled by schema)

---

## 2. Series Model

**File**: `app/models/series.rb`

### Associations
- [ ] `belongs_to :artist`
- [ ] `has_many :artwork_groups, dependent: :destroy`
- [ ] `has_many :artworks, through: :artwork_groups`

### Validations
- [ ] `validates :title, presence: true, length: { maximum: 200 }`
- [ ] `validates :description, length: { maximum: 2000 }`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`
- [ ] `scope :ongoing, -> { where(is_ongoing: true) }`
- [ ] `scope :completed, -> { where(is_ongoing: false) }`

### Notes
- `is_ongoing` defaults to `true` (handled by schema)
- `display_order` defaults to `0` (handled by schema)

---

## 3. ArtworkGroup Model

**File**: `app/models/artwork_group.rb`

### Associations
- [ ] `belongs_to :artist`
- [ ] `belongs_to :series, optional: true`
- [ ] `has_many :artworks, dependent: :nullify`

### Validations
- [ ] `validates :title, presence: true, length: { maximum: 200 }`
- [ ] `validates :description, length: { maximum: 2000 }`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`

### Notes
- `series` is optional
- `display_order` defaults to `0` (handled by schema)

---

## 4. Artwork Model

**File**: `app/models/artwork.rb`

### Associations
- [ ] `belongs_to :artist`
- [ ] `belongs_to :artwork_group, optional: true`
- [ ] `has_many :artwork_images, dependent: :destroy`

### Validations
- [ ] `validates :title, presence: true, length: { maximum: 200 }`
- [ ] `validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: -> { Date.current.year + 1 } }`
- [ ] `validates :medium, length: { maximum: 200 }`
- [ ] `validates :dimensions, length: { maximum: 200 }`
- [ ] `validates :description, length: { maximum: 2000 }`
- [ ] `validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true`

### Scopes
- [ ] `scope :featured, -> { where(is_featured: true) }`
- [ ] `scope :for_sale, -> { where(is_for_sale: true, is_sold: false) }`
- [ ] `scope :sold, -> { where(is_sold: true) }`
- [ ] `scope :ordered, -> { order(display_order: :asc) }`

### Methods
- [ ] `def primary_image` - Returns `artwork_images.find_by(is_primary: true)` or `artwork_images.order(:display_order).first`

### Notes
- Boolean flags default to `false` (handled by schema)
- `display_order` defaults to `0` (handled by schema)

---

## 5. ArtworkImage Model

**File**: `app/models/artwork_image.rb`

### Associations
- [ ] `belongs_to :artwork`

### Validations
- [ ] `validates :image_url, presence: true`
- [ ] `validates :alt_text, length: { maximum: 500 }`
- [ ] `validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`
- [ ] `scope :primary, -> { where(is_primary: true) }`

### Methods
- [ ] `def set_as_primary` - Unset other primary images for same artwork, then set this as primary

```ruby
def set_as_primary
  transaction do
    artwork.artwork_images.where.not(id: id).update_all(is_primary: false)
    update!(is_primary: true)
  end
end
```

### Notes
- `is_primary` defaults to `false` (handled by schema)
- `display_order` defaults to `0` (handled by schema)

---

## 6. Exhibition Model

**File**: `app/models/exhibition.rb`

### Associations
- [ ] `belongs_to :artist`
- [ ] `has_many :exhibition_images, dependent: :destroy`

### Validations
- [ ] `validates :title, presence: true, length: { maximum: 200 }`
- [ ] `validates :description, length: { maximum: 2000 }`
- [ ] `validates :venue, length: { maximum: 200 }`
- [ ] `validates :location, length: { maximum: 200 }`
- [ ] `validates :exhibition_type, presence: true, length: { maximum: 20 }, inclusion: { in: %w[solo group art_fair museum] }`
- [ ] `validates :start_date, presence: true`
- [ ] `validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_nil: true`
- [ ] `validates :curator, length: { maximum: 100 }`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`
- [ ] `scope :ongoing, -> { where('start_date <= ? AND (end_date >= ? OR end_date IS NULL)', Date.current, Date.current) }`
- [ ] `scope :past, -> { where('end_date < ?', Date.current).where.not(end_date: nil) }`
- [ ] `scope :upcoming, -> { where('start_date > ?', Date.current) }`
- [ ] `scope :by_type, ->(type) { where(exhibition_type: type) }`

### Methods
- [ ] `def ongoing?` - Check if current date is between start_date and end_date (or after start_date if no end_date)

```ruby
def ongoing?
  return false if start_date > Date.current
  return true if end_date.nil?
  end_date >= Date.current
end
```

### Notes
- `display_order` defaults to `0` (handled by schema)

---

## 7. ExhibitionImage Model

**File**: `app/models/exhibition_image.rb`

### Associations
- [ ] `belongs_to :exhibition`

### Validations
- [ ] `validates :image_url, presence: true`
- [ ] `validates :alt_text, length: { maximum: 500 }`
- [ ] `validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`

### Notes
- `display_order` defaults to `0` (handled by schema)

---

## 8. PressMention Model

**File**: `app/models/press_mention.rb`

### Associations
- [ ] `belongs_to :artist`

### Validations
- [ ] `validates :title, presence: true, length: { maximum: 200 }`
- [ ] `validates :publication, presence: true, length: { maximum: 200 }`
- [ ] `validates :author, length: { maximum: 100 }`
- [ ] `validates :excerpt, length: { maximum: 1000 }`
- [ ] `validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_nil: true`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`
- [ ] `scope :recent, -> { order(published_date: :desc) }`

### Notes
- `display_order` defaults to `0` (handled by schema)

---

## 9. StudioImage Model

**File**: `app/models/studio_image.rb`

### Associations
- [ ] `belongs_to :artist`

### Validations
- [ ] `validates :image_url, presence: true`
- [ ] `validates :alt_text, length: { maximum: 500 }`
- [ ] `validates :caption, length: { maximum: 1000 }`
- [ ] `validates :width, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :height, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`
- [ ] `validates :file_size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true`

### Scopes
- [ ] `scope :ordered, -> { order(display_order: :asc) }`

### Notes
- `display_order` defaults to `0` (handled by schema)

---

## Implementation Tips

### 1. Start with simplest models first
Order of implementation (easiest to hardest):
1. StudioImage, ExhibitionImage (simple image models)
2. PressMention (no complex associations)
3. Artist (JSONB fields, but no complex methods)
4. Series, ArtworkGroup (basic associations)
5. Exhibition (date logic, ongoing? method)
6. ArtworkImage (set_as_primary method)
7. Artwork (primary_image method, multiple scopes)

### 2. Use TDD workflow
- Run test → See failure → Write minimal code → Test passes → Refactor

### 3. Test each change
After adding validations or associations, run the specific test file:
```bash
docker compose exec web bundle exec rspec spec/models/artist_spec.rb
```

### 4. Check coverage
```bash
docker compose exec web bundle exec rspec spec/models --format documentation
```

### 5. Common patterns

**Email validation**:
```ruby
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
```

**URL validation**:
```ruby
validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
```

**Dynamic year validation**:
```ruby
validates :year, numericality: {
  greater_than_or_equal_to: 1900,
  less_than_or_equal_to: -> { Date.current.year + 1 }
}
```

**Date comparison validation**:
```ruby
validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_nil: true
```

---

**Ready to implement?** Start with the simplest model and work your way up!
