# frozen_string_literal: true

FactoryBot.define do
  factory :artwork_group do
    artist
    series { association :series, artist: artist }
    sequence(:title) { |n| "Artwork Group #{n}" }
    description { "A curated subset of works focusing on specific themes or techniques." }
    display_order { 0 }

    trait :without_series do
      series { nil }
    end

    trait :minimal do
      description { nil }
    end

    trait :with_artworks do
      after(:create) do |group|
        create_list(:artwork, 3, artwork_group: group, artist: group.artist, series: group.series)
      end
    end
  end
end
