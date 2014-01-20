class ChapersController < ApplicationController
  before_action :set_chaper, only: [:show, :edit, :update, :destroy]

  # GET /chapers
  # GET /chapers.json
  def index
    @chapers = Chaper.all
  end

  # GET /chapers/1
  # GET /chapers/1.json
  def show
  end

  # GET /chapers/new
  def new
    @chaper = Chaper.new
  end

  # GET /chapers/1/edit
  def edit
  end

  # POST /chapers
  # POST /chapers.json
  def create
    @chaper = Chaper.new(chaper_params)

    respond_to do |format|
      if @chaper.save
        format.html { redirect_to @chaper, notice: 'Chaper was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chaper }
      else
        format.html { render action: 'new' }
        format.json { render json: @chaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapers/1
  # PATCH/PUT /chapers/1.json
  def update
    respond_to do |format|
      if @chaper.update(chaper_params)
        format.html { redirect_to @chaper, notice: 'Chaper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapers/1
  # DELETE /chapers/1.json
  def destroy
    @chaper.destroy
    respond_to do |format|
      format.html { redirect_to chapers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chaper
      @chaper = Chaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chaper_params
      params.require(:chaper).permit(:title, :description)
    end
end
