class CreateChapers < ActiveRecord::Migration
  def change
    create_table :chapers do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end
