# Artist Profile Management Implementation Plan

**Date**: 2025-01-15  
**Status**: In Progress  
**Branch**: `feature/artist-profile-management`

---

## Overview

Implement the artist profile management feature with a centralized Settings hub (`/dashboard/settings`) that organizes settings into logical sections:
- **Account**: Basic account info (name, location, profile photo)
- **Privacy**: Password and security (password change, email change post-MVP)
- **Profile**: Public profile content (bio, statement, education, awards, social links, contact info)
- **My Studio**: Studio photos and process page settings
- **My Work**: Links to artwork, series, exhibitions, and press management

This plan focuses on implementing the **Settings Index**, **Account Settings**, and **Profile Settings** pages.

## Current State

- Artist model exists with most fields (bio, artist_statement, location, education, awards, contact info, social links)
- Profile photo already uses Active Storage (`has_one_attached :profile_photo`)
- Profile setup page exists for initial onboarding (different from settings)
- Database schema has `studio_photo_url` as string (needs migration to Active Storage)
- Dashboard structure exists but settings hub needs to be created

## Implementation Tasks

### 1. Create Settings Index Page

**File**: `app/controllers/dashboard/settings_controller.rb`
**View**: `app/views/dashboard/settings/index.html.erb`

- `GET /dashboard/settings` - Show settings hub with persistent sidebar navigation
- Require authentication
- **Sidebar Navigation**: Persistent left sidebar (240px) with all 5 settings sections:
  - **Account & Security Section**:
    - Account (User icon, Lucide)
    - Privacy (Lock icon, Lucide)
  - **Content & Portfolio Section**:
    - Profile (FileText icon, Lucide)
    - My Studio (Home icon, Lucide)
    - My Work (Image icon, Lucide)
- **Main Content**: Placeholder for future dashboard content (stats, notifications, activity)
- Sidebar uses improved navigation specifications (see DESIGN_SYSTEM.md)

**Sidebar Specifications**:
- Sidebar header: "Settings" (optional, uppercase)
- Section headers: Uppercase, 12px, Semibold 600, Slate color
- Menu items: 44px height, Lucide icons (20px), proper spacing
- Active state: Misty White bg, 3px left border, Semibold 600
- Hover state: Misty White at 70% opacity
- Focus state: 2px Celadon Green ring with offset
- Section dividers between groups

**Wireframe Reference**: `requirements/wireframes/dashboard/settings-index.md`  
**Design System Reference**: `requirements/DESIGN_SYSTEM.md` (Sidebar Navigation Specifications)

### 2. Create Account Settings

**File**: `app/controllers/dashboard/settings/account_controller.rb`
**View**: `app/views/dashboard/settings/account/show.html.erb`

- `GET /dashboard/settings/account` - Show account form
- `PATCH /dashboard/settings/account` - Update account info
- Require authentication
- Handle profile_photo upload (Active Storage)
- Strong parameters: `:full_name, :location, :profile_photo`
- Redirect to account settings on success

**Wireframe Reference**: `requirements/wireframes/dashboard/account-settings.md`

### 3. Database Migration

**File**: `db/migrate/YYYYMMDD_add_studio_photo_to_artists.rb`

- Add Active Storage attachment for studio_photo
- Remove `studio_photo_url` string column (or keep for migration period)
- Update Artist model to use `has_one_attached :studio_photo`

**Reference**: Follow pattern from `profile_photo` implementation

### 4. Update Artist Model

**File**: `app/models/artist.rb`

- Add `has_one_attached :studio_photo`
- Add validations for studio_photo (JPG/PNG, max 5MB, optional)
- Add validation for education/awards JSON structure
- Add URL validations for social links (website_url, instagram_url, facebook_url)
- Add validation for contact_email format (if different from login email)

**Validation Rules**:
- Education: Array of objects with institution, degree, year
- Awards: Array of objects with title, organization, year
- URLs: Valid HTTP/HTTPS format
- Studio photo: JPG/PNG, max 5MB (optional)

### 5. Create Profile Settings Controller

**File**: `app/controllers/dashboard/settings/profile_controller.rb`

- `GET /dashboard/settings/profile` - Show profile form
- `PATCH /dashboard/settings/profile` - Update profile
- Require authentication
- Handle JSON fields (education, awards, other_links)
- Strong parameters for profile fields (NO account fields or photos)
- Redirect to profile settings on success with flash message

**Strong Parameters**:
```ruby
params.require(:artist).permit(
  :bio, :artist_statement,
  :contact_email, :contact_phone,
  :website_url, :instagram_url, :facebook_url,
  education: [:institution, :degree, :year],
  awards: [:title, :organization, :year],
  other_links: [:label, :url]
)
```

**Note**: Account fields (full_name, location, profile_photo) are handled in Account Settings. Studio photo is handled in Studio Settings.

### 6. Create Profile Settings View

**File**: `app/views/dashboard/settings/profile/show.html.erb`

**Wireframe Reference**: `requirements/wireframes/dashboard/profile-settings.md`

**Layout Structure**:
- **Persistent Sidebar**: Include `_settings_sidebar.html.erb` partial
  - Profile item should be active (highlighted with Misty White bg, left border, Semibold 600)
- **Main Content Area**: Profile form content (Misty White background for separation)

**Form Sections** (matching wireframe - Profile content only):
- About Content section:
  - Biography textarea (third-person, max 2000 chars, character counter)
  - Artist statement textarea (first-person, max 2000 chars, character counter)
- Education section:
  - Dynamic list of education entries
  - Add/Remove/Reorder functionality
  - Fields: Institution, Degree/Program, Year
- Awards section:
  - Dynamic list of award entries
  - Add/Remove/Reorder functionality
  - Fields: Title, Organization, Year
- Social Links section:
  - Website URL
  - Instagram URL
  - Facebook URL
  - Other links (dynamic list: Label + URL pairs)
- Actions:
  - Save Changes button
  - Preview Public Profile link (stub for now)

**Design System Compliance**:
- Use design system colors, spacing, typography
- Include persistent sidebar navigation (`_settings_sidebar.html.erb` partial)
- Main content area uses Misty White background for visual separation
- Responsive design (mobile-first)
- Accessibility (ARIA labels, focus states, keyboard navigation)
- Reuse form input patterns from auth views

### 7. Add Routes

**File**: `config/routes.rb`

```ruby
namespace :dashboard do
  namespace :settings do
    get '/', to: 'settings#index', as: :index
    resource :account, only: [:show, :update]
    resource :profile, only: [:show, :update]
    # Privacy, Studio, Work routes to be added in future phases
  end
end
```

Routes:
- `GET /dashboard/settings` → `dashboard/settings#index` (Settings hub)
- `GET /dashboard/settings/account` → `dashboard/settings/account#show`
- `PATCH /dashboard/settings/account` → `dashboard/settings/account#update`
- `GET /dashboard/settings/profile` → `dashboard/settings/profile#show`
- `PATCH /dashboard/settings/profile` → `dashboard/settings/profile#update`

### 8. Stimulus Controllers

**Reuse Existing**:
- `photo_upload_controller.js` - For profile_photo upload (Account Settings)
- `character_counter_controller.js` - For bio and artist_statement textareas (Profile Settings)

**New Controller**: `app/javascript/controllers/dynamic_list_controller.js`

- Handle add/remove/reorder for education, awards, other_links
- Form field cloning and removal
- Display order management
- Validation (ensure at least institution/degree/year for education, etc.)

### 10. Write Tests (TDD)

**Model Tests**: `spec/models/artist_spec.rb`
- Test studio_photo attachment
- Test education/awards JSON validation
- Test URL validation
- Test URL format validations

**Controller Tests**: 
- `spec/controllers/dashboard/settings_controller_spec.rb` - Settings index
- `spec/controllers/dashboard/settings/account_controller_spec.rb` - Account settings
- `spec/controllers/dashboard/settings/profile_controller_spec.rb` - Profile settings

**Account Controller Tests**:
- Test authentication requirement
- Test GET #show (renders form)
- Test PATCH #update (valid attributes)
- Test PATCH #update (invalid attributes)
- Test profile_photo upload handling
- Test redirect and flash messages

**Profile Controller Tests**:
- Test authentication requirement
- Test GET #show (renders form)
- Test PATCH #update (valid attributes)
- Test PATCH #update (invalid attributes)
- Test JSON field handling (education, awards, other_links)
- Test redirect and flash messages

**Request Tests**: 
- `spec/requests/dashboard/settings_spec.rb` - Settings index page
- `spec/requests/dashboard/settings/account_spec.rb` - Account settings page
- `spec/requests/dashboard/settings/profile_spec.rb` - Profile settings page

**Account Request Tests**:
- Test page rendering
- Test form submission
- Test profile_photo upload
- Test validation errors
- Test accessibility

**Profile Request Tests**:
- Test page rendering
- Test form submission
- Test dynamic list additions/removals
- Test validation errors
- Test accessibility

**Helper Tests** (if needed): `spec/helpers/dashboard/settings/profile_helper_spec.rb`

### 11. Internationalization

**File**: `config/locales/en.yml`

Add translations for:
- Page title, headings, section titles
- Form labels and placeholders
- Button text (Save Changes, Add Education, Remove, etc.)
- Error messages
- Success messages
- Helper text (character limits, file requirements)

**Structure**:
```yaml
en:
  dashboard:
    settings:
      index:
        title: "Settings"
        # ... settings hub labels
      account:
        title: "Account Settings"
        # ... account labels, messages
      profile:
        title: "Profile Settings"
        # ... profile labels, messages
```

### 12. Create Settings Sidebar Partial

**File**: `app/views/shared/_settings_sidebar.html.erb`

- Reusable partial for persistent sidebar navigation
- Used across all settings pages
- Implements improved sidebar specifications:
  - Sidebar header ("Settings")
  - Section grouping (Account & Security, Content & Portfolio)
  - Lucide icons (User, Lock, FileText, Home, Image)
  - Proper active/inactive states
  - Focus states for accessibility
  - Section dividers
- Accepts `current_page` parameter to highlight active item
- Responsive: Hidden on mobile, collapsible on tablet

**Specifications**: See `requirements/DESIGN_SYSTEM.md` (Sidebar Navigation Specifications)

**Note**: Main dashboard navigation (top/sidebar) should link to `/dashboard/settings` which shows the settings hub with sidebar.

## File Structure

```
app/
├── controllers/
│   └── dashboard/
│       └── settings/
│           ├── settings_controller.rb (index)
│           ├── account_controller.rb
│           └── profile_controller.rb
├── views/
│   ├── shared/
│   │   └── _settings_sidebar.html.erb (reusable sidebar partial)
│   └── dashboard/
│       └── settings/
│           ├── index.html.erb
│           ├── account/
│           │   └── show.html.erb
│           └── profile/
│               └── show.html.erb
├── models/
│   └── artist.rb (update)
├── javascript/
│   └── controllers/
│       └── dynamic_list_controller.js (new)
└── helpers/
    └── dashboard/
        └── settings/
            └── profile_helper.rb (if needed)

db/
└── migrate/
    └── YYYYMMDD_add_studio_photo_to_artists.rb

spec/
├── models/
│   └── artist_spec.rb (update)
├── controllers/
│   └── dashboard/
│       └── settings/
│           ├── settings_controller_spec.rb
│           ├── account_controller_spec.rb
│           └── profile_controller_spec.rb
└── requests/
    └── dashboard/
        └── settings/
            ├── settings_spec.rb
            ├── account_spec.rb
            └── profile_spec.rb

config/
├── routes.rb (update)
└── locales/
    └── en.yml (update)
```

## Design System References

- Colors: Celadon Green (#6E9180), Celadon Dark (#527563), etc.
- Spacing: 4px base unit, responsive padding
- Typography: Inter font, defined scale
- Form inputs: Reuse patterns from auth views
- Buttons: Primary/secondary button styles

**References**: 
- `requirements/DESIGN_SYSTEM.md` - Complete design system specifications
- `requirements/wireframes/dashboard/settings-index.md` - Settings hub wireframe
- `requirements/wireframes/dashboard/account-settings.md` - Account settings wireframe
- `requirements/wireframes/dashboard/profile-settings.md` - Profile settings wireframe

## Testing Requirements

- TDD approach: Write tests before implementation
- Test coverage goal: 90%+ for new code
- Test all validations
- Test file uploads (profile_photo, studio_photo)
- Test JSON field handling (education, awards, other_links)
- Test error states
- Test accessibility (keyboard navigation, ARIA labels)

## Dependencies

- Active Storage (already configured)
- Stimulus (already configured)
- Tailwind CSS (already configured)
- Existing photo_upload_controller.js
- Existing character_counter_controller.js

## Notes

- **Settings Structure**: Centralized hub (`/dashboard/settings`) with persistent sidebar navigation
- **Sidebar Navigation**: All settings pages share the same sidebar partial (`_settings_sidebar.html.erb`)
  - Uses Lucide icons (User, Lock, FileText, Home, Image)
  - Section grouping: Account & Security, Content & Portfolio
  - Improved spacing, hover states, and focus states
  - See `requirements/DESIGN_SYSTEM.md` for full specifications
- **Account vs Profile**: Account = basic info (name, location, photo). Profile = public content (bio, education, awards, social links)
- **Profile Setup vs Settings**: Profile setup (`/profile_setup`) is for initial onboarding. Settings pages are for ongoing management
- **Studio Photo**: Will be handled in Studio Settings (future phase), not in Profile Settings
- **Education/Awards**: Store as JSONB arrays in database, handle in form as dynamic lists
- **Social Links**: Validate URL format, allow empty (optional fields)
- **Contact Email**: Can be different from login email (for public display)
- **Privacy Settings**: Password change and email change (post-MVP) will be in Privacy Settings section

## Success Criteria

- Settings hub provides clear navigation with persistent sidebar
- Sidebar navigation follows improved specifications (Lucide icons, section grouping, proper states)
- Artists can edit account info (name, location, profile photo) through Account Settings
- Artists can edit profile content (bio, education, awards, social links, contact) through Profile Settings
- File uploads work for profile_photo in Account Settings
- Education/awards can be added/removed/reordered in Profile Settings
- Social links can be added/edited in Profile Settings
- All validations work correctly
- Forms are accessible and responsive
- Sidebar is keyboard navigable with visible focus states
- Tests pass with 90%+ coverage
- Design system compliance verified

