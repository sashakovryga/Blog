class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
before_action :find_user, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  # GET /galleries
  # GET /galleries.json
  def index
    if current_user.role_ids == [1]
      @galleries =  Gallery.all  
    else  
      gallery_ids = Chaper.find_all_by_user_id(current_user.id).map{|x| x.gallery_id}
      @galleries = Gallery.find_all_by_id(gallery_ids)
    end  
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
 

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
 

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    if @gallery.update_attributes(params[:gallery])
      flash[:notice] = "Successfully updated gallery."
      redirect_to gallery_url
    else
      render :action => 'edit'
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
     @gallery.destroy
    flash[:notice] = "Successfully destroyed gallery."
    redirect_to galleries_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

def find_user
      
      if !user_signed_in? || ((current_user.role_ids != [1] ) && (current_user.id != @chaper.user_id))
        respond_to do |format|
        format.html { redirect_to @chaper, notice: 'ВЫ не имеее прав для выполнения этого действия' }
        format.json { render action: 'show', status: :created, location: @chaper }
      end
    end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :chaper_id)
    end
end
