# frozen_string_literal: true

FactoryBot.define do
  factory :exhibition_image do
    exhibition
    sequence(:image_url) { |n| "https://example.com/images/exhibition_#{n}.jpg" }
    alt_text { "Exhibition installation view" }
    width { 1920 }
    height { 1080 }
    file_size { 786_432 } # 768 KB
    display_order { 0 }

    trait :minimal do
      alt_text { nil }
      width { nil }
      height { nil }
      file_size { nil }
    end

    trait :high_resolution do
      width { 4000 }
      height { 3000 }
      file_size { 3_145_728 } # 3 MB
    end
  end
end
