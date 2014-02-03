class Part < ActiveRecord::Base
  belongs_to :chaper
  attr_accessible :user_id, :name, :body, :chaper_id
    validates :name, presence: true

   searchable do
  text :name, :boost => 5
  text :body
  end


end
