class Chaper < ActiveRecord::Base
	belongs_to :user
	has_one :gallery, dependent: :destroy
	 attr_accessible :user_id, :title, :description
	 has_many :parts, dependent: :destroy
  validates :title, presence: true
end
