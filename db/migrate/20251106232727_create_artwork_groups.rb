class CreateArtworkGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :artwork_groups, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid
      t.references :series, null: true, foreign_key: true, type: :uuid

      t.string :title, null: false, limit: 200
      t.text :description, limit: 2000

      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :artwork_groups, [:artist_id, :display_order]
    add_index :artwork_groups, [:series_id, :display_order]
  end
end
