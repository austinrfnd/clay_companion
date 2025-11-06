class CreateArtworkImages < ActiveRecord::Migration[7.2]
  def change
    create_table :artwork_images, id: :uuid do |t|
      t.references :artwork, null: false, foreign_key: true, type: :uuid

      t.string :image_url, null: false
      t.string :alt_text, limit: 500

      # Image Metadata
      t.integer :width
      t.integer :height
      t.integer :file_size

      # Display Options
      t.boolean :is_primary, default: false, null: false
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :artwork_images, [:artwork_id, :display_order]
    add_index :artwork_images, [:artwork_id, :is_primary]
  end
end
