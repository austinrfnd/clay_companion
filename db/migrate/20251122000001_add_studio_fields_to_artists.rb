class AddStudioFieldsToArtists < ActiveRecord::Migration[7.2]
  def change
    # Add studio intro text (optional, max ~600 characters for ~100 words)
    add_column :artists, :studio_intro_text, :text

    # Add studio hero image reference (optional, can be NULL for default gradient)
    add_column :artists, :studio_hero_image_id, :uuid

    # Create foreign key constraint
    add_foreign_key :artists, :studio_images, column: :studio_hero_image_id, on_delete: :nullify
  end
end
