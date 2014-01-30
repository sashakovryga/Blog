class Gallery < ActiveRecord::Base
	belongs_to :chaper
	attr_accessible :name, :chaper_id
  has_many :paintings, dependent: :destroy
end
