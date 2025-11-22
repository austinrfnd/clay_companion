# frozen_string_literal: true

##
# Artist Factory
#
# Factory for creating Artist test records with Devise authentication.
# Includes password and password_confirmation for Devise :validatable module.
#
FactoryBot.define do
  factory :artist do
    sequence(:email) { |n| "artist#{n}@example.com" }
    password { "Password123!" }
    password_confirmation { "Password123!" }
    full_name { "Jane Doe" }
    
    # Skip confirmation email sending in tests (use skip_confirmation! if needed)
    # Confirmation emails are tested separately
    bio { "Jane is a ceramic artist specializing in functional pottery with a focus on minimalist design." }
    artist_statement { "I create work that explores the intersection of form and function in everyday objects." }
    profile_photo_url { "https://example.com/photos/profile.jpg" }
    studio_photo_url { "https://example.com/photos/studio.jpg" }
    location { "Portland, Oregon" }
    education do
      [
        {
          "institution" => "Rhode Island School of Design",
          "degree" => "MFA in Ceramics",
          "year" => 2015
        },
        {
          "institution" => "University of Oregon",
          "degree" => "BFA in Studio Art",
          "year" => 2010
        }
      ]
    end
    awards do
      [
        {
          "title" => "Emerging Artist Award",
          "organization" => "American Craft Council",
          "year" => 2020
        }
      ]
    end
    contact_email { "contact@janedoe.com" }
    contact_phone { "+1-503-555-1234" }
    website_url { "https://janedoe.com" }
    instagram_url { "https://instagram.com/janedoe" }
    facebook_url { "https://facebook.com/janedoe" }
    other_links do
      [
        {
          "label" => "Etsy Shop",
          "url" => "https://etsy.com/shop/janedoe"
        },
        {
          "label" => "YouTube",
          "url" => "https://youtube.com/@janedoe"
        }
      ]
    end

    studio_intro_text { "Come behind the scenes and see where the work is made. My studio in Portland is where I spend my days throwing, trimming, glazing, and firing." }
    studio_hero_image_id { nil } # Set via associations if needed

    trait :minimal do
      bio { nil }
      artist_statement { nil }
      profile_photo_url { nil }
      studio_photo_url { nil }
      location { nil }
      education { [] }
      awards { [] }
      contact_email { nil }
      contact_phone { nil }
      website_url { nil }
      instagram_url { nil }
      facebook_url { nil }
      other_links { [] }
    end

    trait :with_long_text do
      bio { "A" * 2000 }
      artist_statement { "B" * 2000 }
    end

    trait :with_studio_images do
      after(:create) do |artist|
        # Create 5 studio images with mixed categories
        create(:studio_image, artist: artist, category: 'studio')
        create(:studio_image, artist: artist, :process_category)
        create(:studio_image, artist: artist, :studio)
        create(:studio_image, artist: artist, :other_category)
        create(:studio_image, artist: artist, :process_category)
      end
    end

    trait :with_hero_image do
      after(:create) do |artist|
        # Create a studio image and set it as hero
        hero_image = create(:studio_image, artist: artist)
        artist.update(studio_hero_image_id: hero_image.id)
      end
    end
  end
end
