class AddGalleryIdToChapers < ActiveRecord::Migration
  def change
    add_column :chapers, :gallery_id, :integer
  end
end
