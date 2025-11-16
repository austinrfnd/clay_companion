class CreateArtworks < ActiveRecord::Migration[7.2]
  def change
    create_table :artworks, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid
      t.references :artwork_group, null: true, foreign_key: true, type: :uuid

      # Basic Information
      t.string :title, null: false, limit: 200
      t.integer :year, null: false
      t.string :medium, limit: 200
      t.string :dimensions, limit: 200
      t.text :description, limit: 2000

      # Pricing & Availability
      t.decimal :price, precision: 10, scale: 2
      t.boolean :is_sold, default: false, null: false
      t.boolean :is_for_sale, default: false, null: false

      # Display Options
      t.boolean :is_featured, default: false, null: false
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :artworks, [:artist_id, :display_order]
    add_index :artworks, [:artwork_group_id, :display_order]
    add_index :artworks, :is_featured
  end
end
