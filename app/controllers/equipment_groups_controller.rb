class EquipmentGroupsController < ApplicationController
  load_and_authorize_resource except: [:create]

  before_action :set_back_url, only: [ :show, :index ]

  #before_action :set_equipment_group, only: [:show, :edit, :update, :destroy]

  # GET /equipment_groups
  # GET /equipment_groups.json
  def index
    @equipment_groups = @equipment_groups.order(:order, :name)
    session[:sidebar] = 'equipment'
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_groups/1
  # GET /equipment_groups/1.json
  def show
    session[:current_equipment_group] = @equipment_group.id
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_groups/new
  def new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_groups/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /equipment_groups
  # POST /equipment_groups.json
  def create
    @equipment_group = EquipmentGroup.new(equipment_group_params)
    authorize! :create, @equipment_group

    respond_to do |format|
      if @equipment_group.save
        format.html { redirect_to @equipment_group, notice: t('.create_ok', item: @equipment_group.name) }
        format.json { render action: 'show', status: :created, location: @equipment_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @equipment_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_groups/1
  # PATCH/PUT /equipment_groups/1.json
  def update
    respond_to do |format|
      if @equipment_group.update(equipment_group_params)
        format.html { redirect_to @equipment_group, notice: t('.update_ok', @equipment_group.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @equipment_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_groups/1
  # DELETE /equipment_groups/1.json
  def destroy
    the_name = @equipment_group.name
    @equipment_group.destroy
    respond_to do |format|
      format.html { redirect_to equipment_groups_url, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_group
      @equipment_group = EquipmentGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_group_params
      params.require(:equipment_group).permit(:name, :order, :parent_id)
    end
end
