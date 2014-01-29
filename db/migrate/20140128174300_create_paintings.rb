class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :name
      t.integer :gallery_id
      t.string :image

      t.timestamps
    end
  end
end
