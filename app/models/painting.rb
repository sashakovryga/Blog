class Painting < ActiveRecord::Base
	 attr_accessible :gallery_id, :name,:remote_image_url, :photo
  belongs_to :gallery
  has_attached_file :photo, :styles => { :small => "150x150#", :large => "500x500>" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h      
  after_update :reprocess_photo, :if => :cropping?
validates_attachment_presence :photo
validates_attachment_size :photo, :less_than => 5.megabytes
validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
 

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  private
  def reprocess_photo
    photo.reprocess!
  end
 
end
