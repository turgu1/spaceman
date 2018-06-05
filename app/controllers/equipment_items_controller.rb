class EquipmentItemsController < ApplicationController
  load_and_authorize_resource except: [:create, :counts, :do_counts]

  #before_action :set_equipment_item, only: [:show, :edit, :update, :destroy]

  def counts
    authorize! :read, EquipmentItem
  end

  def do_counts
    authorize! :read, EquipmentItem
    authorize! :read, Building
    buildings = do_counts_params
    buildings[:selection].select { |i| !i.blank? }.each do |b|
      @items = {}
      building = Building.where(id: b.to_i).includes(wings: { floors: { spaces: [{space_type: :equipment_items}, {allocations: :equipment_items}, :equipment_items] }}).take
      building.wings.each do |w|
        w.floors.each do |f|
          f.spaces.each do |sp|
            sp.equipment_items.each do |i|
              @items[i.equipment_model_id] ||= 0
              @items[i.equipment_model_id] += i.qty
            end
            unless sp.space_type.nil?
              sp.space_type.equipment_items.each do |i|
                @items[i.equipment_model_id] ||= 0
                @items[i.equipment_model_id] += i.qty
              end
            end
            sp.allocations.each do |a|
              a.equipment_items.each do |i|
                @items[i.equipment_model_id] ||= 0
                @items[i.equipment_model_id] += i.qty
              end
            end
          end
        end
      end
    end
  end

  # GET /equipment_items
  # GET /equipment_items.json
  def index
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_items/1
  # GET /equipment_items/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_items/new
  def new
    unless params[:itemable_type].blank? or params[:itemable_id].blank?
      if eval(params[:itemable_type]).class == Class
        @equipment_item.itemable = eval(params[:itemable_type]).where(id: params[:itemable_id]).take
      end
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /equipment_items/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /equipment_items
  # POST /equipment_items.json
  def create
    @equipment_item = EquipmentItem.new(equipment_item_params)
    authorize! :create, @equipment_item

    respond_to do |format|
      if @equipment_item.save
        format.html { redirect_to @equipment_item, notice: t('.create_ok', item: @equipment_item.name) }
        format.json { render action: 'show', status: :created, location: @equipment_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @equipment_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_items/1
  # PATCH/PUT /equipment_items/1.json
  def update
    respond_to do |format|
      if @equipment_item.update(equipment_item_params)
        format.html { redirect_to @equipment_item, notice: t('.update_ok', @equipment_item.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @equipment_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_items/1
  # DELETE /equipment_items/1.json
  def destroy
    the_name = @equipment_item.name
    @equipment_item.destroy
    respond_to do |format|
      format.html { redirect_to equipment_items_url, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_item
      @equipment_item = EquipmentItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_item_params
      params.require(:equipment_item).permit(:qty, :itemable_id, :itemable_type, :equipment_model_id)
    end

    def do_counts_params
      params.require(:buildings).permit({selection: []})
    end
end
