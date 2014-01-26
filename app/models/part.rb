class Part < ActiveRecord::Base
  belongs_to :chaper
  attr_accessible :user_id, :name, :body, :chaper_id
end
