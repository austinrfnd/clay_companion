# Clay Companion - Tech-Agnostic Requirements

**Created**: 2025-11-05
**Purpose**: Complete product requirements for starting fresh with any tech stack

---

## 📁 What's in This Folder?

This folder contains **all** the product requirements and development documentation for Clay Companion. It's organized to support both product planning and active development phases.

**Structure**:
- Core requirements documents (root level)
- Wireframes for UI reference
- Development guides and standards (in `development/` subfolder)
- Archived planning documents (in `archive/` subfolder for reference)

---

## 📋 Core Requirements Documents

### 1. [PRODUCT_OVERVIEW.md](PRODUCT_OVERVIEW.md)
**Read this first!**

- What is Clay Companion?
- Vision and mission
- Target users
- MVP scope (included/excluded features)
- Core features overview
- Success metrics

**When to use**: Starting the project, onboarding team members, understanding the "why"

---

### 2. [FEATURES.md](FEATURES.md)
**Detailed feature specifications**

- Authentication & account management
- Dashboard features (catalog, series, settings)
- Public portfolio features (gallery, about, exhibitions, press, contact)
- Platform features (discovery, homepage)
- User experience features (accessibility, loading states, error handling)
- Performance and SEO features
- Post-MVP feature list

**When to use**: Implementing specific features, estimating work, planning sprints

---

### 3. [USER_FLOWS.md](USER_FLOWS.md)
**User journeys and interaction flows**

- Artist user flows (onboarding, login, add artwork, organize series, publish content)
- Public visitor flows (discover artists, explore portfolio, find artwork via SEO)
- Edge cases and error flows
- Mobile-specific flows
- Accessibility flows (keyboard navigation, screen reader)

**When to use**: Implementing features, understanding user expectations, writing tests

---

### 4. [DATA_MODEL.md](DATA_MODEL.md)
**Database schema and data requirements**

- All entity definitions (ArtistProfile, Artworks, Series, Exhibitions, Press, etc.)
- Entity relationships (one-to-many, foreign keys)
- Attribute specifications (data types, constraints, validations)
- Indexes and performance considerations
- Access control requirements
- Data lifecycle (creation, updates, deletion)

**When to use**: Setting up database, creating migrations, implementing data validation

---

### 5. [PAGE_STRUCTURE.md](PAGE_STRUCTURE.md)
**URLs, navigation, and information architecture**

- Complete site map (platform, artist portfolios, dashboard)
- URL structure and naming conventions
- Navigation systems (public, dashboard)
- Route protection matrix
- Error pages (404, 403, 500)
- Redirects and edge cases
- Mobile navigation patterns

**When to use**: Setting up routing, implementing navigation, planning sitemap

---

### 6. [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md)
**Visual design specifications**

- **Color Palette**: Celadon Green scheme (WCAG AA compliant)
  - Primary: Celadon Green (#6E9180), Celadon Dark (#527563)
  - Neutrals: Charcoal, Slate, Pale Celadon, Misty White, White
  - Semantic: Success, Error, Warning, Info
- **Typography**: Inter font, type scale, weights
- **Spacing**: 4px base unit, 12-scale system
- **Shadows & Effects**: Minimal shadows, border radius, transitions
- **Component Specs**: Buttons, forms, cards, modals, toasts, etc.
- **Icons**: Lucide Icons (1,400+ icons)
- **Accessibility**: WCAG AA guidelines, focus states, keyboard navigation

**When to use**: Styling components, creating CSS/design tokens, ensuring consistency

---

### 7. [POST_MVP_FEATURES.md](POST_MVP_FEATURES.md)
**Post-MVP features and enhancement roadmap**

- Phase 1, 2, 3 features across all feature areas
- Grid layout configurability, process videos, gallery filtering
- Bulk image organization, image optimization & CDN
- Custom domains, analytics, social sharing, and more
- Effort and priority estimates for each feature

**When to use**: Planning post-launch features, prioritizing enhancements, understanding the future roadmap

---

### 8. [development/](development/) 📁
**Development phase documentation**

This subdirectory contains guides for developers actively building the application:

- **[DEVELOPMENT_SETUP.md](development/DEVELOPMENT_SETUP.md)** - Local environment setup, prerequisites, installation steps, database management, debugging
- **[CODING_STANDARDS.md](development/CODING_STANDARDS.md)** - Code conventions, naming, style guidelines, PR standards for Ruby, JavaScript, HTML, CSS
- **[TESTING_STRATEGY.md](development/TESTING_STRATEGY.md)** - Testing approach, unit/integration/E2E test patterns, coverage goals, CI/CD integration
- **[API_DOCUMENTATION.md](development/API_DOCUMENTATION.md)** - REST API endpoints, authentication, request/response formats, error handling

**When to use**: Setting up your development environment, writing code, setting up tests, integrating with APIs

---

### 9. [wireframes/](wireframes/)
**UI mockups and layouts**

- [artist-profile.md](wireframes/artist-profile.md) - Landing page
- [gallery.md](wireframes/gallery.md) - Artwork gallery with filtering
- [about.md](wireframes/about.md) - Artist bio and statement
- [process-studio.md](wireframes/process-studio.md) - Behind-the-scenes photos (✨ includes post-MVP features)
- [exhibitions.md](wireframes/exhibitions.md) - Exhibition history
- [press.md](wireframes/press.md) - Press mentions
- [contact.md](wireframes/contact.md) - Contact page with Instagram
- [platform-homepage.md](wireframes/platform-homepage.md) - Platform discovery page
- [platform-about.md](wireframes/platform-about.md) - Platform about page
- [add-edit-artwork.md](wireframes/add-edit-artwork.md) - Dashboard artwork form

**When to use**: Building UI, understanding layout, checking specifications

---

### 10. [archive/](archive/) 📁
**Archived planning and historical documents**

Contains documents from earlier planning phases that are kept for historical reference:

- `MIGRATION_GUIDE.md` - Original tech stack analysis and migration strategy
- `DEVELOPMENT_PLAN_PROCESS_STUDIO.md` - Studio feature development plan
- `SESSION_HANDOFF_STUDIO_FEATURE.md` - Session handoff documentation
- `QUICK_REFERENCE_TOMORROW.md` - Quick reference for continuation
- `IMPLEMENTATION_SUMMARY_STUDIO_FEATURE.md` - Studio feature implementation summary
- `SESSION_COMPLETE.txt` - Session completion notes
- `SIDEBAR_NAVIGATION_IMPROVEMENTS.md` - Original sidebar improvement proposals (merged into PAGE_STRUCTURE.md)

**When to use**: Reference only - these are archived from earlier phases

---

## 🚀 Quick Start

### If You're Setting Up Development Environment

1. **Read** [development/DEVELOPMENT_SETUP.md](development/DEVELOPMENT_SETUP.md) for local setup
2. **Review** [development/CODING_STANDARDS.md](development/CODING_STANDARDS.md) for code conventions
3. **Check** [development/TESTING_STRATEGY.md](development/TESTING_STRATEGY.md) for testing approach
4. **Reference** [development/API_DOCUMENTATION.md](development/API_DOCUMENTATION.md) for API details

### If You're Implementing a Specific Feature

1. **Read** the feature spec in [FEATURES.md](FEATURES.md)
2. **Check** the user flow in [USER_FLOWS.md](USER_FLOWS.md)
3. **Review** the data model in [DATA_MODEL.md](DATA_MODEL.md)
4. **Look at** the page structure in [PAGE_STRUCTURE.md](PAGE_STRUCTURE.md)
5. **Reference** the design specs in [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md)
6. **View** the wireframe in [wireframes/](wireframes/)
7. **Follow** code standards in [development/CODING_STANDARDS.md](development/CODING_STANDARDS.md)
8. **Write** tests using [development/TESTING_STRATEGY.md](development/TESTING_STRATEGY.md)

### If You Need to Understand Post-MVP Features

1. **Review** [POST_MVP_FEATURES.md](POST_MVP_FEATURES.md) for future roadmap

---

## ✅ What's Decided (Don't Change)

These decisions are **finalized and tested**:

- ✅ **Color Scheme**: Celadon Green palette (#6E9180, #527563, etc.)
- ✅ **Typography**: Inter font family
- ✅ **Spacing**: 4px base unit with 12-scale system
- ✅ **Icons**: Lucide Icons (or equivalent like Heroicons, Phosphor)
- ✅ **Design Aesthetic**: Gallery-like minimalism, flat design, generous spacing
- ✅ **Accessibility**: WCAG AA minimum (4.5:1 contrast ratios)
- ✅ **MVP Scope**: All features in [FEATURES.md](FEATURES.md) marked as "MVP"

---

## 🔄 What's Flexible (Your Choice)

You can choose:

- ⚙️ Programming language (Python, Ruby, PHP, Go, Rust, Elixir, Java, JavaScript, etc.)
- ⚙️ Framework (Django, Rails, Laravel, Phoenix, SvelteKit, etc.)
- ⚙️ Database (PostgreSQL, MySQL, SQLite, MongoDB, etc.)
- ⚙️ Hosting (Vercel, Heroku, Railway, Fly.io, AWS, DigitalOcean, etc.)
- ⚙️ CSS approach (Tailwind, Bootstrap, plain CSS, CSS-in-JS, etc.)
- ⚙️ Icon library (Lucide, Heroicons, Phosphor, Font Awesome, etc. - as long as similar style)

---

## 📖 Document Status

All requirements documents are **complete and ready to use**:

### Product Requirements (Root Level)
- ✅ Product overview and vision
- ✅ Feature specifications
- ✅ User flows and journeys
- ✅ Data model and database schema
- ✅ Page structure and navigation
- ✅ Design system (colors, fonts, spacing, components)
- ✅ Post-MVP features and roadmap
- ✅ Wireframes for all pages (10 wireframes)

### Development Documentation (development/)
- ✅ Development setup guide
- ✅ Coding standards and conventions
- ✅ Testing strategy and patterns
- ✅ API documentation and endpoints

### Archived Documents (archive/)
- 📋 Planning documents from earlier phases (reference only)

**Total Pages**: 7 core requirement docs + 4 development guides + 10 wireframes = **21 documents**

---

## 💡 Tips

### Do's

✅ Read requirements docs before implementing features

✅ Follow the design system (colors, fonts, spacing)

✅ Implement in order: Auth → Data → Dashboard → Public Portfolio

✅ Test as you go

✅ Refer to wireframes for UI layout

✅ Ensure WCAG AA accessibility

### Don'ts

❌ Don't change the color scheme (Celadon Green is decided and tested)

❌ Don't skip requirements docs (you'll miss important details)

❌ Don't add features not in MVP scope

❌ Don't ignore mobile responsiveness

❌ Don't skip accessibility testing

---

## 🎯 Next Steps

### For New Development Setup
1. Read [development/DEVELOPMENT_SETUP.md](development/DEVELOPMENT_SETUP.md) for environment setup
2. Review [development/CODING_STANDARDS.md](development/CODING_STANDARDS.md) for code conventions
3. Start coding, reference [development/TESTING_STRATEGY.md](development/TESTING_STRATEGY.md) for test patterns

### For Product Understanding
1. Read product overview → [PRODUCT_OVERVIEW.md](PRODUCT_OVERVIEW.md)
2. Review design system → [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md)
3. Study core features → [FEATURES.md](FEATURES.md)

### For Future Planning
1. Review [POST_MVP_FEATURES.md](POST_MVP_FEATURES.md) for roadmap

---

## 📞 Questions?

If you're unsure about something:

1. Check if it's documented in one of the requirements files
2. Look at the relevant wireframe in [wireframes/](wireframes/)
3. Review the appropriate development guide in [development/](development/)

**Everything you need is in this folder!** 🎨🚀

---

**Version**: 2.0 (Development Phase Edition)
**Last Updated**: 2025-11-24
**Status**: Complete and organized for active development
