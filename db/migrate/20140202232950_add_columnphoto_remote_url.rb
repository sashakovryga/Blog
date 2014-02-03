class AddColumnphotoRemoteUrl < ActiveRecord::Migration
  def change
  	add_column :paintings, :photo_remote_url, :string
  	
  end
end
