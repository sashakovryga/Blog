class Painting < ActiveRecord::Base
	 attr_accessible :gallery_id, :name, :image, :remote_image_url
  belongs_to :gallery
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :image, ImageUploader
  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
end
