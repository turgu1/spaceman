class EquipmentModelsController < ApplicationController
  load_and_authorize_resource except: [:create, :show_modal]

  #before_action :set_equipment_model, only: [:show, :show_modal, :edit, :update, :destroy]

  # GET /equipment_models
  # GET /equipment_models.json
  def index
    @equipment_models = @equipment_models.order(:order, :name)
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_models/1
  # GET /equipment_models/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show_modal
    @equipment_model = EquipmentModel.find(params[:id])
    authorize! :read, @equipment_model

    respond_to do |format|
      format.js # show_modal.js.erb
    end
  end

  # GET /equipment_models/new
  def new
    @equipment_model.equipment_group_id = session[:current_equipment_group]
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_models/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /equipment_models
  # POST /equipment_models.json
  def create
    @equipment_model = EquipmentModel.new(equipment_model_params)
    authorize! :create, @equipment_model

    respond_to do |format|
      if @equipment_model.save
        format.html { redirect_to @equipment_model, notice: t('.create_ok', item: @equipment_model.name) }
        format.json { render action: 'show', status: :created, location: @equipment_model }
      else
        format.html { render action: 'new' }
        format.json { render json: @equipment_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_models/1
  # PATCH/PUT /equipment_models/1.json
  def update
    respond_to do |format|
      if @equipment_model.update(equipment_model_params)
        format.html { redirect_to @equipment_model, notice: t('.update_ok', item: @equipment_model.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @equipment_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_models/1
  # DELETE /equipment_models/1.json
  def destroy
    the_name = @equipment_model.name
    the_group = @equipment_model.equipment_group
    @equipment_model.destroy
    respond_to do |format|
      format.html { redirect_to equipment_group_path(the_group), status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_model
      @equipment_model = EquipmentModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_model_params
      params.require(:equipment_model).permit(
          :equipment_group_id, :name, :photo, :photo_filename, :photo_type,
          :supplier, :price, :notes, :order, :model_ident)
    end
end
