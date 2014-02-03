class StoreController < ApplicationController
  def index
  	@chapers = Chaper.order(:title)
  end

  def search
  	@search_chaper = Chaper.search do
    	fulltext params[:search]
  	end
  	@chapers = @search_chaper.results
  	@search_part = Part.search do
    	fulltext params[:search]
  	end
  	@parts = @search_part.results
  end

  def about
    
  end

end
