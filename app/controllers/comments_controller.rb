class CommentsController < ApplicationController
	before_action :set_chaper
	before_action :set_comment, only: [ :destroy]
	  load_and_authorize_resource
	 def create
    @comment = @chaper.comments.create(params[:comment])
    @comment.commenter = current_user.email
    @comment.user_id = current_user.id
    redirect_to chaper_path(@chaper) if @comment.save
  end

  def destroy
  	if @comment.user_id == current_user.id
	    @comment.destroy
	    respond_to do |format|
	      format.html { redirect_to chaper_path(@chaper) }
	      format.json { head :no_content }
	    end
	  else
	  	 redirect_to chaper_path(@chaper)
	  end
  end

  private
  	def set_chaper
       @chaper = Chaper.find(params[:chaper_id])

    end

    def set_comment
       @comment = @chaper.comments.find(params[:id])
    end
    
end
