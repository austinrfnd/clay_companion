# frozen_string_literal: true

FactoryBot.define do
  factory :press_mention do
    artist
    sequence(:title) { |n| "Press Article #{n}" }
    publication { "Ceramics Monthly" }
    author { "Sarah Johnson" }
    published_date { Date.today - 60.days }
    url { "https://example.com/articles/ceramic-artist-profile" }
    excerpt { "An insightful article exploring the innovative techniques and artistic vision behind Jane Doe's latest ceramic collection." }
    display_order { 0 }

    trait :recent do
      published_date { Date.today - 7.days }
    end

    trait :old do
      published_date { Date.today - 365.days }
    end

    trait :minimal do
      author { nil }
      url { nil }
      excerpt { nil }
      published_date { nil }
    end

    trait :with_long_excerpt do
      excerpt { "A" * 1000 }
    end
  end
end
