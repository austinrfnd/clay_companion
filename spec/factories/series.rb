# frozen_string_literal: true

FactoryBot.define do
  factory :series do
    artist
    sequence(:title) { |n| "Series #{n}" }
    description { "A collection of minimalist ceramic vessels exploring form and texture." }
    year_started { 2020 }
    year_ended { nil }
    is_ongoing { true }
    display_order { 0 }

    trait :completed do
      year_ended { 2023 }
      is_ongoing { false }
    end

    trait :minimal do
      description { nil }
      year_started { nil }
      year_ended { nil }
    end

    trait :with_groups do
      after(:create) do |series|
        create_list(:artwork_group, 2, series: series, artist: series.artist)
      end
    end

    trait :with_artworks do
      after(:create) do |series|
        group = create(:artwork_group, series: series, artist: series.artist)
        create_list(:artwork, 3, artwork_group: group, artist: series.artist)
      end
    end
  end
end
