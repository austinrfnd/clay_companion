class CreateArtists < ActiveRecord::Migration[7.2]
  def change
    create_table :artists, id: :uuid do |t|
      # Authentication & Identity
      t.string :email, null: false, limit: 255
      t.string :full_name, null: false, limit: 100

      # Profile Content
      t.text :bio, limit: 2000
      t.text :artist_statement, limit: 2000
      t.string :profile_photo_url
      t.string :studio_photo_url
      t.string :location, limit: 100

      # Professional Information (JSON arrays)
      t.jsonb :education, default: []
      t.jsonb :awards, default: []

      # Contact Information
      t.string :contact_email
      t.string :contact_phone, limit: 20

      # Social Links
      t.string :website_url
      t.string :instagram_url
      t.string :facebook_url
      t.jsonb :other_links, default: []

      t.timestamps
    end

    add_index :artists, :email, unique: true
  end
end
