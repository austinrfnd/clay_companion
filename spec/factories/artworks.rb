# frozen_string_literal: true

FactoryBot.define do
  factory :artwork do
    artist
    artwork_group { nil }
    sequence(:title) { |n| "Artwork #{n}" }
    year { 2023 }
    medium { "Stoneware, glazed" }
    dimensions { "10 × 8 × 6 in" }
    description { "A beautiful ceramic piece demonstrating exceptional craftsmanship and attention to detail." }
    price { nil }
    is_sold { false }
    is_for_sale { false }
    is_featured { false }
    display_order { 0 }

    trait :featured do
      is_featured { true }
    end

    trait :sold do
      is_sold { true }
      is_for_sale { false }
    end

    trait :for_sale do
      is_for_sale { true }
      is_sold { false }
      price { 500.00 }
    end

    trait :not_for_sale do
      is_for_sale { false }
      price { nil }
    end

    trait :minimal do
      medium { nil }
      dimensions { nil }
      description { nil }
      price { nil }
    end

    trait :with_images do
      after(:create) do |artwork|
        create_list(:artwork_image, 3, artwork: artwork)
      end
    end

    trait :with_primary_image do
      after(:create) do |artwork|
        create(:artwork_image, :primary, artwork: artwork)
      end
    end

    trait :in_group do
      artwork_group { association :artwork_group, artist: artist }
    end

    trait :in_series do
      association :series, artist: artist
    end
  end
end
