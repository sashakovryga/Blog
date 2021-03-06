class PaintingsController < ApplicationController
  before_action :set_painting, only: [:show, :edit,:crop, :update, :destroy]
before_action :set_chaper
  before_action :find_user

  load_and_authorize_resource
  # GET /paintings/new
  def new
    @painting = Painting.new(:gallery_id => params[:gallery_id])
  end

  # GET /paintings/1/edit
  def edit
  end

  def crop
  end

  def crop_update
  end


  # POST /paintings
  # POST /paintings.json
  def create
 @painting = @gallery.paintings.create(painting_params)
    @painting.gallery_id = @gallery.id 
   
       if @painting.save
      
      flash[:notice] = "Successfully created painting."
      redirect_to gallery_path(@gallery)
     
   
    else
      render :action => 'new'
    end
    
  end

  # PATCH/PUT /paintings/1
  # PATCH/PUT /paintings/1.json
  def update
    if @painting.update_attributes(painting_params)
      
      flash[:notice] = "Successfully created painting."
       if params[:painting][:photo].blank?
      redirect_to gallery_path(@gallery)
 else
      render :action => 'crop'
    end

   
    else
      render :action => 'edit'
    end
  end

  # DELETE /paintings/1
  # DELETE /paintings/1.json
  def destroy
    @painting.destroy
    flash[:notice] = "Successfully destroyed painting."
    redirect_to gallery_path(@gallery)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_painting
      @painting = Painting.find(params[:id])
    end

    def set_chaper
       @gallery = Gallery.find(params[:gallery_id])
  
    end

    def find_user
      
      if !user_signed_in? || ((current_user.role_ids != [1] ) && (current_user.id != @gallery.chaper.user_id))
        respond_to do |format|
        format.html { redirect_to gallery_path(@gallery), notice: 'ВЫ не имеее прав для выполнения этого действия' }
        format.json { render action: 'show', status: :created, location: @part }
      end
    end
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def painting_params
      params.require(:painting).permit(:name, :gallery_id, :photo, :photo_remote_url )
    end
end
