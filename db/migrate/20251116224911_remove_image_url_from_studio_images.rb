class RemoveImageUrlFromStudioImages < ActiveRecord::Migration[7.2]
  # NOTE: This migration should only be run AFTER:
  # 1. All studio_images have been migrated to Active Storage
  # 2. Verification that all images are accessible via Active Storage
  # 3. Data migration script has been run: rails migrate_studio_images:to_active_storage
  #
  # This migration is reversible for safety
  def up
    # Remove image_url column after migration to Active Storage is complete
    remove_column :studio_images, :image_url, :string
  end

  def down
    # Re-add image_url column if rollback is needed
    add_column :studio_images, :image_url, :string
    # Note: We don't restore the NOT NULL constraint in rollback
    # as existing records may not have image_url values
  end
end
