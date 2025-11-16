class CreatePressMentions < ActiveRecord::Migration[7.2]
  def change
    create_table :press_mentions, id: :uuid do |t|
      t.references :artist, null: false, foreign_key: true, type: :uuid

      # Article Information
      t.string :title, null: false, limit: 200
      t.string :publication, null: false, limit: 200
      t.string :author, limit: 100
      t.date :published_date
      t.string :url
      t.text :excerpt, limit: 1000

      # Display Options
      t.integer :display_order, default: 0, null: false

      t.timestamps
    end

    add_index :press_mentions, [:artist_id, :published_date]
    add_index :press_mentions, [:artist_id, :display_order]
  end
end
