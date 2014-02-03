class Chaper < ActiveRecord::Base
	belongs_to :user
	has_one :gallery, dependent: :destroy
	 attr_accessible :user_id, :title, :description
	 has_many :parts, dependent: :destroy
  validates :title, presence: true
  after_create :create_gallery
  has_many :comments, dependent: :destroy
  searchable do
  text :title, :boost => 5
  text :description
  end

  protected
  def create_gallery
  	gallery = Gallery.create(chaper_id:id,name:title)  	
  	self.gallery_id = gallery.id
  	self.save!
  end
end
