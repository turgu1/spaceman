class SpacesController < ApplicationController
  load_and_authorize_resource except: [:create, :new, :show_modal]

  def show_modal
    @space = Space.where(id: params[:id]).with_allocs.take
    authorize! :read, @space

    respond_to do |format|
      format.js # show_modal.js.erb
    end
  end


  # GET /spaces
  # GET /spaces.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spaces }
    end
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    session[:current_space] = @space.id

    respond_to do |format|
      format.js
    end
  end

  # GET /spaces/new
  # GET /spaces/new.json
  def new
    @space = Space.new
    @space.floor_id = params[:floor_id]
    @space.figure = 'R'
    authorize! :create, @space

    respond_to do |format|
      format.js
    end
  end

  # GET /spaces/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)
    authorize! :create, @space

    respond_to do |format|
      if @space.save
        format.js {
          if params[:next]
            the_type = @space.space_type
            the_floor = @space.floor
            @space = Space.new(space_type: the_type, floor: the_floor, figure: 'R')
            render action: 'new'
          else
            redirect_to @space
          end
        }
        format.html { redirect_to @space, notice: t('.create_ok') }
        format.json { render json: @space, status: :created, location: @space }
      else
        format.js { render action: 'new' }
        format.html { render action: 'new' }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spaces/1
  # PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    session[:current_space] = nil if session[:current_space].to_i == @space.id.to_i
    @floor = @space.floor
    @space.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to spaces_url, status: 303 }
      format.json { head :no_content }
    end
  end

  private

    def space_params
      params.require(:space).permit(
          :floor_id, :space_type_id, :area, :center_coor, :coor, :figure,
          :function, :name, :order,
          {equipment_items_attributes: [:id, :qty, :notes, :equipment_model_id, :_destroy]},
          :properties)
    end
end
