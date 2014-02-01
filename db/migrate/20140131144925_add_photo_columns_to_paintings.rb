class AddPhotoColumnsToPaintings < ActiveRecord::Migration
  def self.up     
    change_table :paintings do |t|  
      t.has_attached_file :photo     
    end 
  end 
   
  def self.down   
    drop_attached_file :paintings, :photo   
  end 
end
