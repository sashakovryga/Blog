class StoreController < ApplicationController
  def index
  	@search = Chaper.search do
    	fulltext params[:search]
  	end
  	@chapers = @search.results
  end
end
