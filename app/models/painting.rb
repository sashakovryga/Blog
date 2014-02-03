require 'open-uri'
class Painting < ActiveRecord::Base
	 attr_accessible :gallery_id, :name, :photo, :photo_remote_url
  belongs_to :gallery
  has_attached_file :photo, :styles => { :small => "300x300#", :large => "500x500>" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h      
  after_update :reprocess_photo, :if => :cropping?
  validates :name, presence: true, uniqueness: true
 before_validation :download_remote_photo, :if => :photo_url_provided?
 validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  validates_presence_of :photo_remote_url, :if => :photo_url_provided?, :message => 'is invalid or inaccessible'

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  private
  def reprocess_photo
    photo.reprocess!
  end


  def photo_url_provided?
    !self.photo_remote_url.blank?
  end
  
  def download_remote_photo
    io = open(URI.parse(photo_remote_url))
    self.original_filename = io.base_uri.path.split('/').last
    self.photo = io
    self.photo_remote_url = photo_remote_url
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end
 
end
