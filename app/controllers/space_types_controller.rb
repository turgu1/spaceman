class SpaceTypesController < ApplicationController
  load_and_authorize_resource except: [:create]

  #before_action :set_space_type, only: [:show, :edit, :update, :destroy]

  # GET /space_types
  # GET /space_types.json
  def index
    @space_types = @space_types.order(:name)
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /space_types/1
  # GET /space_types/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /space_types/new
  def new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /space_types/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /space_types
  # POST /space_types.json
  def create
    @space_type = SpaceType.new(space_type_params)
    authorize! :create, @space_type

    respond_to do |format|
      if @space_type.save
        format.html { redirect_to @space_type, notice: t('.create_ok') }
        format.json { render action: 'show', status: :created, location: @space_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @space_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /space_types/1
  # PATCH/PUT /space_types/1.json
  def update
    respond_to do |format|
      old_name = @space_type.name
      if @space_type.update(space_type_params)
        @space_type.spaces.each { |s| s.touch }
        format.html { redirect_to @space_type, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @space_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /space_types/1
  # DELETE /space_types/1.json
  def destroy
    @space_type.destroy
    respond_to do |format|
      format.html { redirect_to space_types_url, status: 303 }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space_type
      @space_type = SpaceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_type_params
      params.require(:space_type).permit(
          :name, :short_name, :spaces_count, :notes,
          equipment_items_attributes: [:id, :qty, :notes, :equipment_model_id, :_destroy] )
    end
end
