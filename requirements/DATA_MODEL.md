# Clay Companion - Data Model

**Last Updated**: 2025-11-24
**Document Type**: Tech-Agnostic Data Requirements
**Schema Version**: 2025_11_22_000002 (PostgreSQL)
**Status**: Mostly aligned with current implementation - see notes below

---

## ⚠️ Schema Alignment Notes

This document describes the conceptual data model. The actual Rails implementation uses PostgreSQL with Active Record migrations. Current status:

- ✅ Core entities implemented (Artists, Artworks, Series, Exhibitions, Press, Studio Images)
- ✅ All major relationships and foreign keys in place
- ✅ Image tables and associations working
- ⚠️ Some field names differ from original spec (see Migration Notes below)
- ❌ Techniques table not yet implemented (Post-MVP)
- ⚠️ Visibility logic simplified in implementation (see details)

**Last Schema Update**: 2025-11-22 (Migration 20251122000002)

---

## Migration Notes (Implementation vs. Spec)

The following differences exist between this spec and the actual database schema:

| Spec Field Name | Actual Schema Field | Notes |
|-----------------|-------------------|-------|
| `year_created` (Artworks) | `year` | Simplified for implementation |
| `year_start` (Series) | `year_started` | Naming convention change |
| `year_end` (Series) | `year_ended` | Naming convention change |
| `group_id` (Artworks) | `artwork_group_id` | More descriptive naming |
| `availability_status` (Artworks) | `is_for_sale`, `is_sold` | Booleans instead of enum |
| `is_upcoming` (Exhibitions) | `is_ongoing` | Implementation handles differently |
| N/A (Studio Images) | `image_url` missing in schema | Stored via URL field (see schema details) |
| N/A (Artists) | `studio_hero_image_id`, `studio_intro_text` | Added for studio settings feature |

**When updating this spec**: Refer to `db/schema.rb` for authoritative field names.

---

## Overview

This document describes the conceptual data model for Clay Companion. It defines entities, relationships, attributes, and constraints without specifying database technology or implementation details.

---

## Entity Relationship Diagram

```
ArtistProfile (1) ──→ (many) Series
              ├──→ (many) Artworks
              ├──→ (many) Exhibitions
              ├──→ (many) PressMentions
              ├──→ (many) StudioImages
              └──→ (many) Techniques

Series (1) ──→ (many) ArtworkGroups
       └──→ (many) Artworks

ArtworkGroups (1) ──→ (many) Artworks

Artworks (1) ──→ (many) ArtworkImages

Exhibitions (1) ──→ (many) ExhibitionImages
```

---

## Entities

### Artist Profile

**Purpose**: Stores artist account information and public profile details

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique artist identifier |
| email | String | Yes | Unique, Valid email format | Login email |
| full_name | String | Yes | Max 100 chars | Artist's full name |
| bio | Text | No | Max 2000 chars | Biography (third-person) |
| artist_statement | Text | No | Max 2000 chars | Artist statement (first-person) |
| profile_photo_url | String | No | Valid URL | Portrait image URL |
| studio_photo_url | String | No | Valid URL | Studio/workspace image URL |
| location | String | No | Max 100 chars | City, State/Country (e.g., "Portland, Oregon") |
| education | JSON/Array | No | Array of objects | Education entries (see schema below) |
| awards | JSON/Array | No | Array of objects | Awards/recognition entries (see schema below) |
| contact_email | String | No | Valid email format | Public contact email |
| contact_phone | String | No | Valid phone format | Public phone number |
| website_url | String | No | Valid URL | Personal website |
| instagram_url | String | No | Valid URL | Instagram profile |
| facebook_url | String | No | Valid URL | Facebook profile |
| other_links | JSON/Array | No | Array of objects | Additional social/portfolio links |
| created_at | Timestamp | Yes | Auto-set | Account creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Education Schema** (JSON Array):
```json
[
  {
    "institution": "Rhode Island School of Design",
    "degree": "MFA in Ceramics",
    "year": 2015
  }
]
```

**Awards Schema** (JSON Array):
```json
[
  {
    "title": "Emerging Artist Award",
    "organization": "American Craft Council",
    "year": 2020
  }
]
```

**Other Links Schema** (JSON Array):
```json
[
  {
    "label": "Etsy Shop",
    "url": "https://etsy.com/shop/example"
  }
]
```

**Validation Rules**:
- Email must be unique across all artists
- Education year must be between 1900 and current year
- Awards year must be between 1900 and current year
- All URLs must be valid HTTP/HTTPS format
- Phone numbers should be validated based on international formats

**Access Control**:
- Artist can read and update their own profile
- Public can view public-facing fields (name, bio, statement, photos, contact info, social links)
- Private fields: email (login), internal settings

---

### Series

**Purpose**: Collections of related artworks (e.g., "Minimalist Bowls 2023")

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique series identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| title | String | Yes | Max 200 chars | Series name |
| description | Text | No | Max 1000 chars | Series description for gallery |
| year_start | Integer | No | 1900 - current year | Start year |
| year_end | Integer | No | 1900 - current year | End year (null = ongoing) |
| display_order | Integer | Yes | Default 0 | Sort order in gallery |
| is_public | Boolean | Yes | Default false | Visible in public gallery |
| is_featured | Boolean | Yes | Default false | Show in featured gallery section |
| is_hidden_from_gallery | Boolean | Yes | Default false | Hide from public gallery view |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Validation Rules**:
- year_end must be >= year_start (if both provided)
- year_start and year_end must be valid years (1900 to current year + 10 for upcoming)
- display_order must be >= 0
- Cannot delete series if artworks still reference it (cascade or prevent)

**Visibility Logic**:
- `is_public = true`: Visible in public gallery (unless hidden)
- `is_featured = true`: Show in featured filter on gallery
- `is_hidden_from_gallery = true`: Keep internal only (not shown publicly)
- Only one flag should be true: public OR hidden (not both)

**Access Control**:
- Artist can CRUD their own series
- Public can view series where `is_public = true AND is_hidden_from_gallery = false`

---

### Artwork Groups

**Purpose**: Optional sub-groupings within a series (e.g., "Small Bowls", "Large Vases")

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique group identifier |
| series_id | UUID/String | Yes | Foreign Key → Series.id | Parent series |
| title | String | Yes | Max 200 chars | Group name |
| description | Text | No | Max 500 chars | Group description |
| display_order | Integer | Yes | Default 0 | Sort order within series |
| is_featured | Boolean | Yes | Default false | Show in featured gallery section |
| is_hidden_from_gallery | Boolean | Yes | Default false | Hide from public gallery view |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Validation Rules**:
- series_id must reference existing series
- display_order must be >= 0
- Groups are optional; artworks can belong to series without groups

**Access Control**:
- Artist can CRUD groups within their own series
- Public can view groups where parent series is public and group is not hidden

---

### Artworks

**Purpose**: Individual ceramic pieces with full metadata

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique artwork identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| series_id | UUID/String | No | Foreign Key → Series.id | Parent series (optional) |
| group_id | UUID/String | No | Foreign Key → ArtworkGroups.id | Parent group (optional) |
| title | String | Yes | Max 200 chars | Artwork title |
| description | Text | No | Max 2000 chars | Artwork description for public view |
| clay_type | String | No | Max 100 chars | Type of clay (Stoneware, Porcelain, etc.) |
| firing_cone | String | No | Max 50 chars | Firing cone (e.g., "Cone 10") |
| firing_schedule | String | No | Max 100 chars | Firing method (Reduction, Oxidation, etc.) |
| glaze_description | Text | No | Max 1000 chars | Glaze description or recipe |
| internal_notes | Text | No | Max 2000 chars | Private notes (not public) |
| dimensions | String | No | Max 100 chars | Physical dimensions (e.g., "10 × 8 × 6 in") |
| weight | String | No | Max 50 chars | Weight (e.g., "2.5 lbs") |
| year_created | Integer | Yes | 1900 - current year | Year completed |
| is_public | Boolean | Yes | Default false | Visible in public gallery |
| is_featured | Boolean | Yes | Default false | Show in featured gallery section |
| is_hidden_from_gallery | Boolean | Yes | Default false | Hide from public gallery view |
| availability_status | Enum | No | See options below | Current availability |
| display_order | Integer | Yes | Default 0 | Sort order in catalog/gallery |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Availability Status Options**:
- `available` - Available for purchase
- `sold` - Sold to collector
- `commissioned` - Created as commission
- `not_for_sale` - Display only

**Validation Rules**:
- Must have at least one image (enforce via ArtworkImages relationship)
- year_created must be between 1900 and current year
- If group_id is set, series_id must also be set (groups belong to series)
- group_id must belong to the specified series_id
- display_order must be >= 0

**Access Control**:
- Artist can CRUD their own artworks
- Public can view artworks where `is_public = true AND is_hidden_from_gallery = false`
- Internal notes never exposed publicly

---

### Artwork Images

**Purpose**: Multiple images per artwork (different angles, detail shots)

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique image identifier |
| artwork_id | UUID/String | Yes | Foreign Key → Artworks.id | Parent artwork |
| image_url | String | Yes | Valid URL | Image storage URL |
| caption | String | No | Max 500 chars | Image caption |
| display_order | Integer | Yes | Default 0 | Sort order in gallery |
| is_primary | Boolean | Yes | Default false | Primary/hero image for thumbnails |
| created_at | Timestamp | Yes | Auto-set | Upload timestamp |

**Validation Rules**:
- Each artwork must have at least one image
- Only one image per artwork can be marked as primary
- If artwork has only one image, it must be marked as primary
- image_url must be valid and accessible
- display_order must be >= 0

**Cascade Behavior**:
- When artwork is deleted, all associated images should be deleted
- When deleting image, if it's the last image, prevent deletion (artwork needs at least one)

**Access Control**:
- Artist can CRUD images for their own artworks
- Public can view images for public artworks

---

### Exhibitions

**Purpose**: Past and upcoming exhibitions, shows, and gallery displays

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique exhibition identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| title | String | Yes | Max 200 chars | Exhibition title |
| venue | String | Yes | Max 200 chars | Gallery/venue name |
| location | String | No | Max 200 chars | City, State/Country |
| start_date | Date | Yes | Valid date | Exhibition start date |
| end_date | Date | No | Valid date | Exhibition end date (null = ongoing/TBD) |
| description | Text | No | Max 2000 chars | Exhibition description |
| exhibition_type | Enum | No | See options below | Type of exhibition |
| is_upcoming | Boolean | Yes | Default false | Future exhibition |
| is_featured | Boolean | Yes | Default false | Feature on Exhibitions page |
| display_order | Integer | Yes | Default 0 | Sort order |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Exhibition Type Options**:
- `solo` - Solo exhibition
- `group` - Group exhibition
- `online` - Online exhibition

**Validation Rules**:
- start_date must be valid date
- end_date must be >= start_date (if provided)
- is_upcoming can be auto-calculated from start_date vs current date
- display_order must be >= 0

**Access Control**:
- Artist can CRUD their own exhibitions
- Public can view all exhibitions for an artist

---

### Exhibition Images

**Purpose**: Images for featured exhibitions (installation shots, artwork displays)

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique image identifier |
| exhibition_id | UUID/String | Yes | Foreign Key → Exhibitions.id | Parent exhibition |
| image_url | String | Yes | Valid URL | Image storage URL |
| caption | String | No | Max 500 chars | Image caption |
| display_order | Integer | Yes | Default 0 | Sort order in carousel |
| created_at | Timestamp | Yes | Auto-set | Upload timestamp |

**Validation Rules**:
- Only featured exhibitions typically have images
- display_order must be >= 0

**Cascade Behavior**:
- When exhibition is deleted, all associated images should be deleted

**Access Control**:
- Artist can CRUD images for their own exhibitions
- Public can view images for all exhibitions

---

### Press Mentions

**Purpose**: Media coverage, articles, reviews, and press mentions

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique press mention identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| title | String | Yes | Max 300 chars | Article/mention title |
| publication | String | Yes | Max 200 chars | Publication name |
| url | String | No | Valid URL | External article URL |
| published_date | Date | Yes | Valid date | Publication date |
| excerpt | Text | No | Max 1000 chars | Short excerpt (100-200 words) |
| excerpt_long | Text | No | Max 2000 chars | Longer excerpt (200-300 words for featured) |
| is_featured | Boolean | Yes | Default false | Feature on Press page |
| display_order | Integer | Yes | Default 0 | Sort order |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Validation Rules**:
- published_date must be valid date (not future)
- url must be valid HTTP/HTTPS format (if provided)
- excerpt_long only needed if is_featured = true
- display_order must be >= 0

**Access Control**:
- Artist can CRUD their own press mentions
- Public can view all press mentions for an artist

---

### Studio Images

**Purpose**: Behind-the-scenes photos of studio, workspace, and creative process

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique image identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| image_url | String | Yes | Valid URL | Image storage URL |
| caption | String | No | Max 500 chars | Image caption/description |
| category | Enum | No | See options below | Image category |
| display_order | Integer | Yes | Default 0 | Sort order on Process page |
| created_at | Timestamp | Yes | Auto-set | Upload timestamp |

**Category Options**:
- `studio` - Workspace, tools, environment
- `process` - Making, hands working, techniques
- `other` - Other behind-the-scenes content

**Validation Rules**:
- image_url must be valid and accessible
- display_order must be >= 0
- category helps organize images but is optional

**Access Control**:
- Artist can CRUD their own studio images
- Public can view all studio images for an artist

---

### Techniques

**Purpose**: Educational content about materials, techniques, and methods (Post-MVP)

**Attributes**:

| Attribute | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| id | UUID/String | Yes | Unique, Primary Key | Unique technique identifier |
| artist_id | UUID/String | Yes | Foreign Key → ArtistProfile.id | Owner artist |
| name | String | Yes | Max 200 chars | Technique name |
| description | Text | Yes | Max 2000 chars | Detailed description |
| display_order | Integer | Yes | Default 0 | Sort order |
| created_at | Timestamp | Yes | Auto-set | Creation timestamp |
| updated_at | Timestamp | Yes | Auto-update | Last update timestamp |

**Validation Rules**:
- display_order must be >= 0
- description should provide educational value

**Access Control**:
- Artist can CRUD their own techniques
- Public can view all techniques for an artist

**Note**: This entity is planned for Post-MVP

---

## Relationships

### One-to-Many Relationships

1. **ArtistProfile → Series**
   - One artist has many series
   - Cascade delete: When artist deleted, delete all series (or prevent deletion if series exist)

2. **ArtistProfile → Artworks**
   - One artist has many artworks
   - Cascade delete: When artist deleted, delete all artworks (or prevent deletion if artworks exist)

3. **ArtistProfile → Exhibitions**
   - One artist has many exhibitions
   - Cascade delete: When artist deleted, delete all exhibitions

4. **ArtistProfile → PressMentions**
   - One artist has many press mentions
   - Cascade delete: When artist deleted, delete all press mentions

5. **ArtistProfile → StudioImages**
   - One artist has many studio images
   - Cascade delete: When artist deleted, delete all studio images

6. **ArtistProfile → Techniques**
   - One artist has many techniques
   - Cascade delete: When artist deleted, delete all techniques

7. **Series → ArtworkGroups**
   - One series has many groups
   - Cascade delete: When series deleted, delete all groups (or reassign artworks)

8. **Series → Artworks**
   - One series has many artworks
   - Nullify on delete: When series deleted, set series_id to null on artworks (or prevent deletion)

9. **ArtworkGroups → Artworks**
   - One group has many artworks
   - Nullify on delete: When group deleted, set group_id to null on artworks

10. **Artworks → ArtworkImages**
    - One artwork has many images
    - Cascade delete: When artwork deleted, delete all images

11. **Exhibitions → ExhibitionImages**
    - One exhibition has many images
    - Cascade delete: When exhibition deleted, delete all images

---

## Indexes and Performance

**Recommended Indexes** (database-agnostic):

1. **Foreign Keys**: Index all foreign key columns for fast joins
   - artist_id in all child tables
   - series_id in artworks, artwork_groups
   - group_id in artworks
   - artwork_id in artwork_images
   - exhibition_id in exhibition_images

2. **Filtering/Sorting**: Index columns commonly used in WHERE and ORDER BY
   - is_public, is_featured, is_hidden_from_gallery (artworks, series, groups)
   - display_order (all tables with ordering)
   - year_created (artworks)
   - start_date (exhibitions)
   - published_date (press_mentions)

3. **Composite Indexes** for common query patterns:
   - (artist_id, is_public, display_order) on artworks
   - (artist_id, display_order) on series
   - (series_id, display_order) on artwork_groups, artworks
   - (artist_id, start_date DESC) on exhibitions
   - (artist_id, published_date DESC) on press_mentions

4. **Unique Indexes**:
   - email on artist_profile (unique constraint)
   - (artwork_id) on artwork_images WHERE is_primary = true (ensure one primary image)

---

## Data Integrity Rules

### Referential Integrity
- All foreign keys must reference existing records
- Cannot delete parent if children exist (or cascade appropriately)

### Business Logic Constraints
- Artwork must have at least one image
- Only one image per artwork can be primary
- If group_id is set, series_id must also be set
- year_end >= year_start (if both provided)
- end_date >= start_date (if both provided)
- Unique email per artist

### Data Validation
- Email format validation
- URL format validation (image URLs, social links, external links)
- Date range validation (no future dates for historical data)
- Year range validation (1900 to current year for most, +10 for upcoming)
- String length limits enforced
- Required fields cannot be null/empty

---

## Access Control Requirements

### Authentication
- Artists must authenticate to access their own data
- Authentication via email and password (secure hashing required)
- Session management for logged-in artists

### Authorization Rules

1. **Artist Profile**:
   - Artist can read/update their own profile only
   - Public can view public profile fields

2. **Artworks, Series, Groups**:
   - Artist can CRUD their own artworks, series, groups
   - Public can view items where `is_public = true AND is_hidden_from_gallery = false`

3. **Exhibitions, Press, Studio Images, Techniques**:
   - Artist can CRUD their own content
   - Public can view all content for any artist

4. **Images (Artwork, Exhibition)**:
   - Artist can CRUD images for their own items
   - Public can view images for public items

### Row-Level Security
- Implement row-level access control to ensure artists only access their own data
- Public queries automatically filter to public-only content

---

## Data Lifecycle

### Creation
- Default values set for boolean flags (is_public = false, is_featured = false, etc.)
- Timestamps auto-set on creation (created_at)
- Display order auto-calculated (e.g., max + 1)

### Updates
- Timestamps auto-updated on modification (updated_at)
- Validation runs on all updates
- Optimistic locking to prevent concurrent update conflicts (optional)

### Deletion
- Soft delete vs hard delete considerations:
  - MVP: Hard delete (permanent removal)
  - Post-MVP: Consider soft delete for recovery options
- Cascade behavior as defined in relationships
- Prevent deletion if constraints violated

---

## Backup & Recovery

**Requirements**:
- Daily automated backups
- Point-in-time recovery capability
- Manual backup option for artists (export their data)
- Backup retention policy (e.g., 30 days)
- Disaster recovery plan

---

## Data Migration & Versioning

**Schema Changes**:
- Version control all schema changes
- Migrations should be reversible when possible
- Test migrations on copy of production data before deploying
- Document all breaking changes

**Data Import/Export**:
- Artists should be able to export their data (JSON, CSV)
- Support bulk import for onboarding (CSV, JSON)
- API for data access (Post-MVP)

---

## Scalability Considerations

### Query Optimization
- Paginate long lists (artworks, exhibitions, press)
- Lazy load images (don't fetch all at once)
- Cache frequently accessed data (public portfolios)
- Optimize N+1 query problems (batch loading)

### Storage Optimization
- Images stored separately from database (file storage service)
- Database stores image URLs only, not binary data
- Implement image cleanup for deleted artworks
- Monitor database size and optimize as needed

### Performance Targets
- Gallery page load: < 2 seconds
- Artwork detail: < 1 second
- Dashboard catalog: < 2 seconds
- Image upload: < 5 seconds per image

---

## Notes

This data model is intentionally database-agnostic. It can be implemented in:
- Relational databases (PostgreSQL, MySQL, SQLite, etc.)
- NoSQL databases (MongoDB, DynamoDB, Firestore, etc.)
- ORM/ODM frameworks with appropriate adapters

Choose your database technology based on:
- Development team expertise
- Scalability requirements
- Cost constraints
- Hosting/deployment platform compatibility
- Query complexity and performance needs

---

**Document Version**: 1.0 (Tech-Agnostic)
**Source Documents**: Extracted from DATABASE_SCHEMA.md
