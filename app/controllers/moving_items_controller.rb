class MovingItemsController < ApplicationController
  before_action :set_moving_item, only: [:show, :edit, :update, :destroy]

  # GET /moving_items
  # GET /moving_items.json
  def index
    @moving_items = MovingItem.all
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /moving_items/1
  # GET /moving_items/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /moving_items/new
  def new
    @moving_item = MovingItem.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /moving_items/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /moving_items
  # POST /moving_items.json
  def create
    @moving_item = MovingItem.new(moving_item_params)

    respond_to do |format|
      if @moving_item.save
        format.html { redirect_to @moving_item, notice: t('.create_ok') }
        format.json { render action: 'show', status: :created, location: @moving_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @moving_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moving_items/1
  # PATCH/PUT /moving_items/1.json
  def update
    respond_to do |format|
      if @moving_item.update(moving_item_params)
        format.html { redirect_to @moving_item, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @moving_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moving_items/1
  # DELETE /moving_items/1.json
  def destroy
    @moving_item.destroy
    respond_to do |format|
      format.html { redirect_to moving_items_url, status: 303 }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moving_item
      @moving_item = MovingItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moving_item_params
      params.require(:moving_item).permit(:allocation_id, :weight, :volume, :notes, :destination_id, :replace_id, :description, :qty)
    end
end
