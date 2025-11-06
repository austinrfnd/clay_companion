class CreateStudioImages < ActiveRecord::Migration[7.2]
  def change
    create_table :studio_images, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid

      t.string :image_url, null: false
      t.string :alt_text, limit: 500
      t.text :caption, limit: 1000

      # Image Metadata
      t.integer :width
      t.integer :height
      t.integer :file_size

      # Display Options
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :studio_images, [:artist_id, :display_order]
  end
end
