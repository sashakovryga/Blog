class AddBlockToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block, :boolean
  end
end
