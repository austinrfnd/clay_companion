class CreateExhibitions < ActiveRecord::Migration[7.2]
  def change
    create_table :exhibitions, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid

      # Basic Information
      t.string :title, null: false, limit: 200
      t.text :description, limit: 2000
      t.string :venue, limit: 200
      t.string :location, limit: 200

      # Exhibition Type & Dates
      t.string :exhibition_type, null: false, limit: 20
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :is_ongoing, default: false, null: false

      # Additional Info
      t.string :curator, limit: 100
      t.string :press_release_url

      # Display Options
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :exhibitions, [:artist_id, :start_date]
    add_index :exhibitions, [:artist_id, :display_order]
    add_index :exhibitions, :exhibition_type
  end
end
