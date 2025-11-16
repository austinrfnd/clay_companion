class CreateSeries < ActiveRecord::Migration[7.2]
  def change
    create_table :series, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid

      t.string :title, null: false, limit: 200
      t.text :description, limit: 2000

      t.integer :year_started
      t.integer :year_ended
      t.boolean :is_ongoing, default: true, null: false

      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :series, [:artist_id, :display_order]
  end
end
