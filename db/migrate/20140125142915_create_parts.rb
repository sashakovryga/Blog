class CreateParts < ActiveRecord::Migration
  
  def change
    create_table :parts do |t|
      t.string :name
      t.text :body
      t.references :chaper, index: true

      t.timestamps
    end
  end
end
