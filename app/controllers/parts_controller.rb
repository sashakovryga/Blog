class PartsController < ApplicationController
	   before_action :set_chaper
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  before_action :find_user, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  # GET /parts
  # GET /parts.json
  def index
    @parts = @chaper.parts
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = @chaper.parts.new
  end

  # GET /parts/1/edit
  def edit
  end

  # POST /parts
  # POST /parts.json
  def create
  	   
    @part = @chaper.parts.create(part_params)
    @part.user_id = current_user.id 
    respond_to do |format|
      if @part.save
        format.html { redirect_to chaper_path(@chaper), notice: 'Part was successfully created.' }
        format.json { render action: 'show', status: :created, location: @part }
      else
        format.html { render action: 'new' }
        format.json { render json: chaper_path(@chaper).errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to chaper_path(@chaper), notice: 'Part was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: chaper_path(@chaper).errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
      format.html { redirect_to chaper_path(@chaper) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
     def set_chaper
       @chaper = Chaper.find(params[:chaper_id])
  
    end

    def set_part
       @part = @chaper.parts.find(params[:id])
  
    end


     def find_user
      
      if !user_signed_in? || ((current_user.role_ids != [1] ) && (current_user.id != @part.user_id))
        respond_to do |format|
        format.html { redirect_to chaper_part_path, notice: 'ВЫ не имеее прав для выполнения этого действия' }
        format.json { render action: 'show', status: :created, location: @part }
      end
    end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:name, :body, :user_id)
    end

end
