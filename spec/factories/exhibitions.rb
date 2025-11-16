# frozen_string_literal: true

FactoryBot.define do
  factory :exhibition do
    artist
    sequence(:title) { |n| "Exhibition #{n}" }
    description { "A showcase of contemporary ceramic art featuring innovative techniques and timeless forms." }
    venue { "Portland Art Gallery" }
    location { "Portland, Oregon" }
    exhibition_type { "solo" }
    start_date { Date.today - 30.days }
    end_date { Date.today + 30.days }
    curator { "John Smith" }
    press_release_url { "https://example.com/press/exhibition.pdf" }
    display_order { 0 }

    trait :solo do
      exhibition_type { "solo" }
    end

    trait :group do
      exhibition_type { "group" }
    end

    trait :art_fair do
      exhibition_type { "art_fair" }
    end

    trait :museum do
      exhibition_type { "museum" }
    end

    trait :ongoing do
      start_date { Date.today - 15.days }
      end_date { Date.today + 15.days }
    end

    trait :past do
      start_date { Date.today - 90.days }
      end_date { Date.today - 30.days }
    end

    trait :upcoming do
      start_date { Date.today + 30.days }
      end_date { Date.today + 60.days }
    end

    trait :no_end_date do
      end_date { nil }
    end

    trait :minimal do
      description { nil }
      venue { nil }
      location { nil }
      curator { nil }
      press_release_url { nil }
    end

    trait :with_images do
      after(:create) do |exhibition|
        create_list(:exhibition_image, 3, exhibition: exhibition)
      end
    end
  end
end
