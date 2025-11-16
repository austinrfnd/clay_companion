# frozen_string_literal: true

FactoryBot.define do
  factory :artwork_image do
    artwork
    sequence(:image_url) { |n| "https://example.com/images/artwork_#{n}.jpg" }
    alt_text { "Detailed view of ceramic artwork" }
    width { 1920 }
    height { 1080 }
    file_size { 524_288 } # 512 KB
    is_primary { false }
    display_order { 0 }

    trait :primary do
      is_primary { true }
    end

    trait :minimal do
      alt_text { nil }
      width { nil }
      height { nil }
      file_size { nil }
    end

    trait :high_resolution do
      width { 4000 }
      height { 3000 }
      file_size { 2_097_152 } # 2 MB
    end
  end
end
