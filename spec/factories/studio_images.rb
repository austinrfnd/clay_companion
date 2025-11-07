# frozen_string_literal: true

FactoryBot.define do
  factory :studio_image do
    artist
    sequence(:image_url) { |n| "https://example.com/images/studio_#{n}.jpg" }
    alt_text { "View of ceramic studio workspace" }
    caption { "Working on a new series of minimalist vessels in my Portland studio." }
    width { 1920 }
    height { 1080 }
    file_size { 655_360 } # 640 KB
    display_order { 0 }

    trait :minimal do
      alt_text { nil }
      caption { nil }
      width { nil }
      height { nil }
      file_size { nil }
    end

    trait :with_long_caption do
      caption { "A" * 1000 }
    end

    trait :high_resolution do
      width { 4000 }
      height { 3000 }
      file_size { 2_621_440 } # 2.5 MB
    end
  end
end
