class CommentsController < ApplicationController
	before_action :set_chaper
	before_action :set_comment, only: [ :destroy]
	  load_and_authorize_resource
	 def create
    @comment = @chaper.comments.create(params[:comment])
    @comment.commenter = @user.user_name
    redirect_to chaper_path(@chaper) if @comment.save
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to chaper_path(@chaper) }
      format.json { head :no_content }
    end
  end

  private
  	def set_chaper
       @chaper = Chaper.find(params[:chaper_id])
       @user = User.find(@chaper.user_id)
    end

    def set_comment
       @comment = @chaper.comments.find(params[:id])
    end
    
end
