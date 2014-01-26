class StoreController < ApplicationController
  def index
  	@chapers = Chaper.order(:title)
  end
end
