# Authorization Pattern for Studio API Controllers

## Overview

The Studio API controllers use a **layered authorization approach** combining:
1. **Authentication checks** - Ensure user is logged in
2. **Resource ownership verification** - Ensure artist owns the resource
3. **Proper HTTP status codes** - Return appropriate 401/404 responses

---

## Pattern Structure

```ruby
class Api::StudioImagesController < ApplicationController
  # Layer 1: Authentication (Devise via authenticate_artist!)
  before_action :authenticate_artist!, except: [:index, :show]

  # Layer 2: Data setup
  before_action :set_artist
  before_action :set_studio_image, only: [:show, :update, :destroy]

  # Layer 3: Authorization (Custom ownership check)
  before_action :authorize_artist!, only: [:update, :destroy]
end
```

---

## Layer 1: Authentication (`authenticate_artist!`)

**Source**: Devise (via Artist model)
**Behavior**:
- Redirects unauthenticated users to login
- On API requests, returns `401 Unauthorized`
- Used on all write operations (POST, PATCH, DELETE)
- NOT used on read operations (GET)

**Applied to**:
- `POST /api/artists/:id/studio-images` - Create
- `PATCH /api/artists/:id/studio-images/:id` - Update
- `DELETE /api/artists/:id/studio-images/:id` - Delete
- `PATCH /api/artists/:id/studio-page` - Update hero/intro

**Publicly Readable**:
- `GET /api/artists/:id/studio-images` - List (anyone can view)
- `GET /api/artists/:id/studio-images/:id` - Show (anyone can view)
- `GET /api/artists/:id/studio-page` - Hero data (anyone can view)

---

## Layer 2: Data Setup

### `set_artist`
```ruby
def set_artist
  @artist = current_artist
end
```

**Purpose**: Establish which artist context we're operating in
**Logic**: Uses Devise's `current_artist` helper from authentication
**Impact**: All subsequent operations refer to `@artist`

### `set_studio_image`
```ruby
def set_studio_image
  @studio_image = StudioImage.find(params[:id])
end
```

**Purpose**: Load the specific studio image resource
**Behavior**: Raises `ActiveRecord::RecordNotFound` if ID doesn't exist
**Result**: Returns `404 Not Found` to client

---

## Layer 3: Authorization (`authorize_artist!`)

**The Key Authorization Method**:
```ruby
def authorize_artist!
  raise ActiveRecord::RecordNotFound unless @studio_image.artist_id == @artist.id
end
```

**Logic Flow**:
```
Is this image owned by the current artist?
  ├─ YES → Continue execution
  └─ NO  → Raise ActiveRecord::RecordNotFound → Return 404 Not Found
```

**Applied to**: Update and Delete operations
- Why? These modify or destroy data
- Why NOT on show? Artists can view each other's images in the public gallery

**Key Decision**: Returns `404 Not Found` instead of `403 Forbidden`
- **Why?** Prevents information leakage
- This way, you can't discover which resources exist if you don't own them
- If you can't find it, it doesn't exist (from your perspective)

---

## Request Flow Examples

### Example 1: Artist Updates Own Image ✅

```
1. Client sends: PATCH /api/artists/abc123/studio-images/img456
   Headers: Authorization: Bearer <token>

2. Rails evaluates:
   ✓ authenticate_artist! → Finds current_artist from token
   ✓ set_artist → @artist = current_artist
   ✓ set_studio_image → @studio_image = StudioImage.find(img456)
   ✓ authorize_artist! → img456.artist_id == current_artist.id? YES
   ✓ Action executes → Image is updated
   ✓ Returns: 200 OK with updated image

Response:
{
  "id": "img456",
  "caption": "Updated caption",
  "message": "Image updated successfully"
}
```

### Example 2: Artist Updates Another Artist's Image ❌

```
1. Client sends: PATCH /api/artists/abc123/studio-images/img999
   Headers: Authorization: Bearer <token for artist abc123>

   But img999 belongs to artist xyz789

2. Rails evaluates:
   ✓ authenticate_artist! → Finds current_artist
   ✓ set_artist → @artist = current_artist (abc123)
   ✓ set_studio_image → @studio_image = StudioImage.find(img999)
   ✗ authorize_artist! → img999.artist_id (xyz789) != current_artist.id (abc123)
   ✗ Raises ActiveRecord::RecordNotFound
   ✓ Rails catches it → Returns 404 Not Found

Response:
{
  "error": "Not Found"
}

Client has NO WAY to know if:
- The image doesn't exist
- The image belongs to someone else
- They're not authorized
```

### Example 3: Unauthenticated Access ❌

```
1. Client sends: PATCH /api/artists/abc123/studio-images/img456
   Headers: (No authorization header)

2. Rails evaluates:
   ✗ authenticate_artist! → No token found
   ✗ Devise redirects to login → Returns 401 Unauthorized

Response:
{
  "error": "You need to sign in or sign up before continuing."
}

Note: No subsequent filters execute
```

### Example 4: View Public Portfolio ✅

```
1. Client sends: GET /api/artists/xyz789/studio-images
   Headers: (No authorization needed)

2. Rails evaluates:
   ✓ No authentication required (index is public)
   ✓ set_artist → @artist = Artist.find(xyz789) [from route param]
   ✓ Action executes → Lists all studio images for xyz789
   ✓ Returns: 200 OK with images array

Response:
{
  "images": [
    { "id": "...", "caption": "...", ... },
    { "id": "...", "caption": "...", ... }
  ],
  "total": 2
}

Note: Works whether or not you're logged in
```

---

## Authorization Decision Matrix

| Endpoint | Method | Auth? | Ownership Check? | Public? | Example |
|----------|--------|-------|------------------|---------|---------|
| /studio-images | GET | No | No | Yes | Anyone views gallery |
| /studio-images/:id | GET | No | No | Yes | Anyone views image detail |
| /studio-images | POST | Yes | N/A* | No | Artist uploads photo |
| /studio-images/:id | PATCH | Yes | Yes | No | Artist updates caption |
| /studio-images/:id | DELETE | Yes | Yes | No | Artist deletes photo |
| /studio-page | GET | No | No | Yes | Anyone views hero section |
| /studio-page | PATCH | Yes | N/A* | No | Artist updates intro text |

*N/A = Not needed because artist can only create/modify their own resource through current_artist context

---

## Security Implications

### ✅ What This Protects

1. **Unauthorized Creation**: Can't upload images unless logged in
2. **Unauthorized Modification**: Can't update/delete without ownership
3. **Information Leakage**: 404 doesn't reveal if resource exists or belongs to someone else
4. **Session Hijacking**: Tokens are required and validated by Devise
5. **CSRF**: Rails CSRF protection via cookies/tokens

### ⚠️ What This Doesn't Protect (Out of Scope)

1. **Rate Limiting** - No limit on API requests
2. **SQL Injection** - Mitigated by Rails ORM/params sanitization
3. **XSS** - Frontend responsibility (template escaping, CSP headers)
4. **Image Content** - No validation that image is appropriate
5. **File Upload Size** - Model validates 5MB, but no request-level limit

---

## Implementation Details

### Current Artist Determination

**Source**: `current_artist` Devise helper
```ruby
# This is available in controllers when using Devise
current_artist # Returns authenticated Artist or nil
```

**In set_artist method**:
```ruby
def set_artist
  @artist = current_artist
  # If current_artist is nil on a public endpoint, this will be nil
  # and subsequent lookups will fail appropriately
end
```

### Studio Page Authorization

**Special Case - Both Public and Authenticated**:
```ruby
# In StudioPageController
before_action :set_artist
before_action :authenticate_artist!, only: [:update]

def show
  # Public - anyone can view hero data
end

def update
  # Only authenticated artists can update
  # But which artist? The one in the URL!
  # If you're not that artist, request fails at authenticate step
end
```

---

## Testing Authorization

See `spec/requests/api/studio_images_spec.rb` for comprehensive tests:

```ruby
context 'when authenticated as the artist' do
  before { sign_in artist }
  # Tests that artist can perform action
end

context 'when authenticated as a different artist' do
  before { sign_in other_artist }
  # Tests that different artist gets 404
end

context 'when not authenticated' do
  # Tests that unauthenticated user gets 401
end
```

---

## Future Enhancements

### Potential Improvements
1. **Admin Override** - Allow admins to manage any artist's images
2. **Sharing** - Allow artists to grant edit access to collaborators
3. **Rate Limiting** - Prevent abuse via excessive requests
4. **Audit Logging** - Track who modified images and when
5. **Soft Deletes** - Archive instead of destroying images
6. **API Keys** - Alternative to session-based auth for integrations

### Simple Addition Example
```ruby
# Add admin support
def authorize_artist!
  admin_or_owner = @artist.admin? || @studio_image.artist_id == @artist.id
  raise ActiveRecord::RecordNotFound unless admin_or_owner
end
```

---

## Summary

The authorization pattern is:
1. **Authenticate** - Ensure user is logged in (write operations)
2. **Load** - Get the resource from database
3. **Verify** - Check that user owns the resource
4. **Execute** - Perform the action
5. **Return** - Send appropriate response

This provides **simple, predictable security** that's easy to audit and test.
