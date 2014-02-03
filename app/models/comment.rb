class Comment < ActiveRecord::Base
  belongs_to :chaper
  attr_accessible :body,:commenter
end
