# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_06_235802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "full_name", limit: 100, null: false
    t.text "bio"
    t.text "artist_statement"
    t.string "profile_photo_url"
    t.string "studio_photo_url"
    t.string "location", limit: 100
    t.jsonb "education", default: []
    t.jsonb "awards", default: []
    t.string "contact_email"
    t.string "contact_phone", limit: 20
    t.string "website_url"
    t.string "instagram_url"
    t.string "facebook_url"
    t.jsonb "other_links", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_artists_on_email", unique: true
  end

  create_table "artwork_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.uuid "series_id"
    t.string "title", limit: 200, null: false
    t.text "description"
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "display_order"], name: "index_artwork_groups_on_artist_id_and_display_order"
    t.index ["artist_id"], name: "index_artwork_groups_on_artist_id"
    t.index ["series_id", "display_order"], name: "index_artwork_groups_on_series_id_and_display_order"
    t.index ["series_id"], name: "index_artwork_groups_on_series_id"
  end

  create_table "artwork_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artwork_id", null: false
    t.string "image_url", null: false
    t.string "alt_text", limit: 500
    t.integer "width"
    t.integer "height"
    t.integer "file_size"
    t.boolean "is_primary", default: false, null: false
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id", "display_order"], name: "index_artwork_images_on_artwork_id_and_display_order"
    t.index ["artwork_id", "is_primary"], name: "index_artwork_images_on_artwork_id_and_is_primary"
    t.index ["artwork_id"], name: "index_artwork_images_on_artwork_id"
  end

  create_table "artworks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.uuid "artwork_group_id"
    t.string "title", limit: 200, null: false
    t.integer "year", null: false
    t.string "medium", limit: 200
    t.string "dimensions", limit: 200
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.boolean "is_sold", default: false, null: false
    t.boolean "is_for_sale", default: false, null: false
    t.boolean "is_featured", default: false, null: false
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "series_id"
    t.index ["artist_id", "display_order"], name: "index_artworks_on_artist_id_and_display_order"
    t.index ["artist_id"], name: "index_artworks_on_artist_id"
    t.index ["artwork_group_id", "display_order"], name: "index_artworks_on_artwork_group_id_and_display_order"
    t.index ["artwork_group_id"], name: "index_artworks_on_artwork_group_id"
    t.index ["is_featured"], name: "index_artworks_on_is_featured"
    t.index ["series_id"], name: "index_artworks_on_series_id"
  end

  create_table "exhibition_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "exhibition_id", null: false
    t.string "image_url", null: false
    t.string "alt_text", limit: 500
    t.integer "width"
    t.integer "height"
    t.integer "file_size"
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibition_id", "display_order"], name: "index_exhibition_images_on_exhibition_id_and_display_order"
    t.index ["exhibition_id"], name: "index_exhibition_images_on_exhibition_id"
  end

  create_table "exhibitions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.string "title", limit: 200, null: false
    t.text "description"
    t.string "venue", limit: 200
    t.string "location", limit: 200
    t.string "exhibition_type", limit: 20, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "is_ongoing", default: false, null: false
    t.string "curator", limit: 100
    t.string "press_release_url"
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "display_order"], name: "index_exhibitions_on_artist_id_and_display_order"
    t.index ["artist_id", "start_date"], name: "index_exhibitions_on_artist_id_and_start_date"
    t.index ["artist_id"], name: "index_exhibitions_on_artist_id"
    t.index ["exhibition_type"], name: "index_exhibitions_on_exhibition_type"
  end

  create_table "press_mentions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.string "title", limit: 200, null: false
    t.string "publication", limit: 200, null: false
    t.string "author", limit: 100
    t.date "published_date"
    t.string "url"
    t.text "excerpt"
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "display_order"], name: "index_press_mentions_on_artist_id_and_display_order"
    t.index ["artist_id", "published_date"], name: "index_press_mentions_on_artist_id_and_published_date"
    t.index ["artist_id"], name: "index_press_mentions_on_artist_id"
  end

  create_table "series", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.string "title", limit: 200, null: false
    t.text "description"
    t.integer "year_started"
    t.integer "year_ended"
    t.boolean "is_ongoing", default: true, null: false
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "display_order"], name: "index_series_on_artist_id_and_display_order"
    t.index ["artist_id"], name: "index_series_on_artist_id"
  end

  create_table "studio_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.string "image_url", null: false
    t.string "alt_text", limit: 500
    t.text "caption"
    t.integer "width"
    t.integer "height"
    t.integer "file_size"
    t.integer "display_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "display_order"], name: "index_studio_images_on_artist_id_and_display_order"
    t.index ["artist_id"], name: "index_studio_images_on_artist_id"
  end

  add_foreign_key "artwork_groups", "artists"
  add_foreign_key "artwork_groups", "series"
  add_foreign_key "artwork_images", "artworks"
  add_foreign_key "artworks", "artists"
  add_foreign_key "artworks", "artwork_groups"
  add_foreign_key "artworks", "series"
  add_foreign_key "exhibition_images", "exhibitions"
  add_foreign_key "exhibitions", "artists"
  add_foreign_key "press_mentions", "artists"
  add_foreign_key "series", "artists"
  add_foreign_key "studio_images", "artists"
end
