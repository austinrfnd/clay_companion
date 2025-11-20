class MakeImageUrlNullableInStudioImages < ActiveRecord::Migration[7.2]
  def change
    # Make image_url nullable to support migration to Active Storage
    # During migration period, image_url may be null while images are being migrated
    change_column_null :studio_images, :image_url, true
  end
end
