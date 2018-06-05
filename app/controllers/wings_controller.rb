class WingsController < ApplicationController
  load_and_authorize_resource except: [:create, :new]

  #before_action :set_wing, only: [:show, :edit, :update, :destroy]

  # GET /wings
  # GET /wings.json
  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /wings/1
  # GET /wings/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /wings/new
  def new
    @wing = Wing.new
    @wing.building = Building.find(session[:current_building])
    authorize! :create, @wing
  end

  # GET /wings/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /wings
  # POST /wings.json
  def create
    @wing = Wing.new(wing_params)
    authorize! :create, @wing

    respond_to do |format|
      if @wing.save
        format.html { redirect_to @wing, notice: t('.create_ok', item: @wing.name) }
        format.json { render action: 'show', status: :created, location: @wing }
      else
        format.html { render action: 'new' }
        format.json { render json: @wing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wings/1
  # PATCH/PUT /wings/1.json
  def update
    respond_to do |format|
      if @wing.update(wing_params)
        @wing.floors.each { |f| f.touch }
        format.html { redirect_to @wing, notice: t('.update_ok', item: @wing.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wings/1
  # DELETE /wings/1.json
  def destroy
    building_id = @wing.building_id
    wing_name = @wing.name
    @wing.destroy
    respond_to do |format|
      format.html { redirect_to building_url(building_id), status: 303, notice: t('.delete_ok', item: wing_name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wing
      @wing = Wing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wing_params
      params.require(:wing).permit(:name, :short_name, :floors_count, :visible, :order, :building_id)
    end
end
