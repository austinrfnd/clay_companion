# Clay Companion - API Documentation

**Last Updated**: 2025-11-24

---

## Overview

This document defines the RESTful API endpoints for Clay Companion. All endpoints use JSON for request/response bodies and follow REST conventions.

**Base URL**: `https://claycompanion.com/api`

**API Version**: v1 (currently `/api/v1/*` for future compatibility)

---

## Authentication

All protected endpoints require a Bearer token in the `Authorization` header:

```
Authorization: Bearer {jwt_token}
```

### Login Endpoint

```
POST /api/auth/login
Content-Type: application/json

{
  "email": "artist@example.com",
  "password": "securepassword"
}

Response (200 OK):
{
  "token": "eyJhbGc...",
  "expires_at": "2025-12-24T10:00:00Z",
  "user": {
    "id": "uuid",
    "email": "artist@example.com",
    "name": "Jane Doe"
  }
}
```

### Signup Endpoint

```
POST /api/auth/signup
Content-Type: application/json

{
  "email": "artist@example.com",
  "password": "securepassword",
  "password_confirmation": "securepassword",
  "name": "Jane Doe"
}

Response (201 Created):
{
  "token": "eyJhbGc...",
  "user": {
    "id": "uuid",
    "email": "artist@example.com",
    "name": "Jane Doe"
  }
}
```

---

## Response Format

### Success Response

```json
{
  "status": "success",
  "data": {
    // endpoint-specific data
  }
}
```

### Error Response

```json
{
  "status": "error",
  "message": "Human-readable error message",
  "errors": {
    "field_name": ["Error message for field"]
  }
}
```

### HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success (GET, PUT, PATCH) |
| 201 | Created (POST) |
| 204 | No Content (DELETE) |
| 400 | Bad Request (invalid data) |
| 401 | Unauthorized (no auth token) |
| 403 | Forbidden (not authorized) |
| 404 | Not Found |
| 422 | Unprocessable Entity (validation error) |
| 500 | Server Error |

---

## Artworks API

### List Artworks (Artist)

```
GET /api/artworks
Authorization: Bearer {token}

Query Parameters:
  - page: integer (default: 1)
  - per_page: integer (default: 20, max: 100)
  - status: string (draft, published)
  - series_id: uuid (filter by series)

Response (200 OK):
{
  "data": [
    {
      "id": "uuid",
      "title": "Blue Vessel",
      "description": "Hand-thrown ceramic vessel",
      "image_url": "https://s3.../image.jpg",
      "status": "published",
      "artist_id": "uuid",
      "series_id": "uuid",
      "created_at": "2025-11-20T10:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 45,
    "total_pages": 3
  }
}
```

### Get Artwork

```
GET /api/artworks/{id}
Authorization: Bearer {token}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "title": "Blue Vessel",
    "description": "Hand-thrown ceramic vessel",
    "dimensions": "H: 8in, W: 6in",
    "image_url": "https://s3.../image.jpg",
    "images": [
      { "id": "uuid", "url": "https://s3.../1.jpg", "order": 1 }
    ],
    "price": 250.00,
    "available": true,
    "status": "published",
    "artist_id": "uuid",
    "series_id": "uuid",
    "created_at": "2025-11-20T10:00:00Z",
    "updated_at": "2025-11-20T10:00:00Z"
  }
}
```

### Create Artwork

```
POST /api/artworks
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Blue Vessel",
  "description": "Hand-thrown ceramic vessel",
  "dimensions": "H: 8in, W: 6in",
  "price": 250.00,
  "available": true,
  "status": "draft",
  "series_id": "uuid"
}

Response (201 Created):
{
  "data": {
    "id": "uuid",
    "title": "Blue Vessel",
    ...
  }
}
```

### Update Artwork

```
PUT /api/artworks/{id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Blue Vessel (Updated)",
  "price": 300.00
}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "title": "Blue Vessel (Updated)",
    ...
  }
}
```

### Delete Artwork

```
DELETE /api/artworks/{id}
Authorization: Bearer {token}

Response (204 No Content)
```

---

## Studio Images API

### Upload Image

```
POST /api/studio-images
Authorization: Bearer {token}
Content-Type: multipart/form-data

{
  "image": <file>,
  "caption": "Firing the kiln",
  "category": "process",
  "display_order": 1
}

Response (201 Created):
{
  "data": {
    "id": "uuid",
    "image_url": "https://s3.../studio-image-1.jpg",
    "caption": "Firing the kiln",
    "category": "process",
    "created_at": "2025-11-20T10:00:00Z"
  }
}
```

### List Studio Images

```
GET /api/studio-images
Authorization: Bearer {token}

Query Parameters:
  - category: string (studio, process, other)
  - page: integer

Response (200 OK):
{
  "data": [
    {
      "id": "uuid",
      "image_url": "https://s3.../image.jpg",
      "caption": "Firing the kiln",
      "category": "process",
      "display_order": 1,
      "created_at": "2025-11-20T10:00:00Z"
    }
  ]
}
```

### Update Studio Image

```
PUT /api/studio-images/{id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "caption": "Updated caption",
  "display_order": 2
}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "caption": "Updated caption",
    ...
  }
}
```

### Delete Studio Image

```
DELETE /api/studio-images/{id}
Authorization: Bearer {token}

Response (204 No Content)
```

### Reorder Studio Images

```
POST /api/studio-images/reorder
Authorization: Bearer {token}
Content-Type: application/json

{
  "order": [
    { "id": "uuid1", "display_order": 1 },
    { "id": "uuid2", "display_order": 2 },
    { "id": "uuid3", "display_order": 3 }
  ]
}

Response (200 OK):
{
  "status": "success",
  "message": "Images reordered"
}
```

---

## Series API

### List Series

```
GET /api/series
Authorization: Bearer {token}

Query Parameters:
  - page: integer
  - per_page: integer

Response (200 OK):
{
  "data": [
    {
      "id": "uuid",
      "name": "2025 Collection",
      "description": "My 2025 collection of vessels",
      "artwork_count": 5,
      "created_at": "2025-11-20T10:00:00Z"
    }
  ]
}
```

### Get Series

```
GET /api/series/{id}
Authorization: Bearer {token}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "name": "2025 Collection",
    "description": "My 2025 collection of vessels",
    "artworks": [
      {
        "id": "uuid",
        "title": "Blue Vessel",
        ...
      }
    ]
  }
}
```

### Create Series

```
POST /api/series
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "2025 Collection",
  "description": "My 2025 collection of vessels"
}

Response (201 Created):
{
  "data": {
    "id": "uuid",
    "name": "2025 Collection",
    ...
  }
}
```

### Update Series

```
PUT /api/series/{id}
Authorization: Bearer {token}

{
  "name": "Spring 2025 Collection"
}

Response (200 OK):
{
  "data": { ... }
}
```

### Delete Series

```
DELETE /api/series/{id}
Authorization: Bearer {token}

Response (204 No Content)
```

---

## Profile API

### Get Profile

```
GET /api/profile
Authorization: Bearer {token}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "name": "Jane Doe",
    "email": "jane@example.com",
    "bio": "Ceramic artist based in Portland",
    "statement": "I create functional pottery...",
    "profile_image_url": "https://s3.../profile.jpg",
    "location": "Portland, OR",
    "instagram_handle": "@janedoeceramics",
    "website": "https://janedoe.com",
    "education": "BFA from RISD",
    "awards": "Young Artist Award 2024"
  }
}
```

### Update Profile

```
PUT /api/profile
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Jane Doe",
  "bio": "Ceramic artist based in Portland",
  "location": "Portland, OR",
  "instagram_handle": "@janedoeceramics",
  "website": "https://janedoe.com"
}

Response (200 OK):
{
  "data": { ... }
}
```

### Update Studio Settings

```
PUT /api/profile/studio
Authorization: Bearer {token}

{
  "studio_title": "My Studio",
  "studio_description": "Behind the scenes...",
  "hero_image_id": "uuid"
}

Response (200 OK):
{
  "data": { ... }
}
```

---

## Public API (No Auth Required)

### Get Artist Profile

```
GET /api/public/artists/{artist_slug}

Response (200 OK):
{
  "data": {
    "id": "uuid",
    "name": "Jane Doe",
    "slug": "jane-doe",
    "bio": "Ceramic artist",
    "profile_image_url": "https://s3.../profile.jpg",
    "instagram_handle": "@janedoeceramics",
    "portfolio_url": "https://claycompanion.com/jane-doe"
  }
}
```

### Get Artist Artworks

```
GET /api/public/artists/{artist_slug}/artworks

Query Parameters:
  - page: integer
  - series_id: uuid

Response (200 OK):
{
  "data": [
    {
      "id": "uuid",
      "title": "Blue Vessel",
      "image_url": "https://s3.../image.jpg",
      "price": 250.00,
      "series_id": "uuid"
    }
  ]
}
```

### Search Artists

```
GET /api/public/artists/search

Query Parameters:
  - q: string (name, bio, location)
  - location: string (filter by location)
  - page: integer

Response (200 OK):
{
  "data": [
    {
      "id": "uuid",
      "name": "Jane Doe",
      "profile_image_url": "...",
      "bio": "Ceramic artist"
    }
  ]
}
```

---

## Error Handling

### Validation Errors

```
POST /api/artworks
{
  "title": ""  // Missing required field
}

Response (422 Unprocessable Entity):
{
  "status": "error",
  "message": "Validation failed",
  "errors": {
    "title": ["can't be blank"],
    "price": ["must be greater than 0"]
  }
}
```

### Authentication Errors

```
GET /api/artworks
(No Authorization header)

Response (401 Unauthorized):
{
  "status": "error",
  "message": "Authentication required"
}
```

### Authorization Errors

```
DELETE /api/artworks/{other_artist_artwork_id}
Authorization: Bearer {token}

Response (403 Forbidden):
{
  "status": "error",
  "message": "You don't have permission to delete this artwork"
}
```

### Not Found

```
GET /api/artworks/nonexistent-id

Response (404 Not Found):
{
  "status": "error",
  "message": "Artwork not found"
}
```

---

## Rate Limiting

API requests are rate limited:

- **Authentication endpoints**: 5 requests per minute per IP
- **Other endpoints**: 100 requests per minute per user

Response headers include:

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1637410000
```

When rate limited:

```
Response (429 Too Many Requests):
{
  "status": "error",
  "message": "Rate limit exceeded. Try again in 60 seconds."
}
```

---

## Pagination

List endpoints support pagination:

```
GET /api/artworks?page=2&per_page=25

Response:
{
  "data": [ ... ],
  "pagination": {
    "page": 2,
    "per_page": 25,
    "total": 100,
    "total_pages": 4,
    "has_next": true,
    "has_previous": true
  }
}
```

---

## Sorting

List endpoints support sorting:

```
GET /api/artworks?sort=created_at:desc

Query Parameters:
  - sort: string (field:asc or field:desc)
  - Valid fields: created_at, updated_at, title, price
```

---

## Filtering

List endpoints support filtering:

```
GET /api/artworks?status=published&series_id=uuid

Query Parameters depend on endpoint - see specific endpoint docs
```

---

## Versioning

API versioning is managed via URL:

- Current: `/api/artworks`
- Future: `/api/v2/artworks`

---

## CORS

The API supports CORS requests from:

- `*.claycompanion.com`
- `localhost:3000` (development)

Add requests in headers:

```
Origin: https://claycompanion.com
```

---

## Webhooks (Future)

Webhooks will be available for:

- Artwork published
- New exhibition added
- Profile updated

(Implementation details in future documentation)

---

## SDKs (Future)

Official SDKs planned for:

- JavaScript/TypeScript
- Python
- Ruby

(Coming soon)

---

## Questions or Issues?

Refer to the [DEVELOPMENT_SETUP.md](DEVELOPMENT_SETUP.md) or contact the development team.

---

**Version**: 1.0
**Last Updated**: 2025-11-24
**Status**: Planned endpoints, implement incrementally
