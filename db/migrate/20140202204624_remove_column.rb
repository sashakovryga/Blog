class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :paintings, :crop_x, :integer
    remove_column :paintings, :crop_y, :integer
    remove_column :paintings, :crop_w, :integer
    remove_column :paintings, :crop_h, :integer
  end
end
