class AddSeriesToArtworks < ActiveRecord::Migration[7.2]
  def change
    add_reference :artworks, :series, null: true, foreign_key: true, type: :uuid
  end
end
