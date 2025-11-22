class AddCategoryToStudioImages < ActiveRecord::Migration[7.2]
  def change
    # Add category field for organizing images (studio/process/other)
    add_column :studio_images, :category, :string, default: 'other', null: false

    # Add index for efficient querying by artist and category
    add_index :studio_images, [:artist_id, :category]
  end
end
