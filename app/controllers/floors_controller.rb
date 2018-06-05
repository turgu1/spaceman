class FloorsController < ApplicationController
  load_and_authorize_resource only: [ :index, :edit, :update, :destroy, :export ]

  before_action :set_back_url, only: [ :show ]

  def bulk_space_type_modal
    @floor = Floor.find(params[:id])
    authorize! :read, @floor

    respond_to do |format|
      format.js
    end
  end

  def bulk_coor_adjust
    @floor = Floor.with_allocations(params[:id]).take
    authorize! :update, @floor

    pars = bulk_coor_adjust_params

    @floor.adjust_coord_bulk(pars[:spaces], pars[:type].to_sym)

    respond_to do |format|
      format.js {
        flash.now[:notice] = t('.coor_ok')
        redirect_to action: "edit_spaces"
      }
    end
  end

  # POST /floors/1/bulk_space_type
  def bulk_space_type
    @floor = Floor.with_allocations(params[:id]).take
    authorize! :update, @floor

    pars = bulk_space_type_params

    @floor.set_space_type_bulk(pars[:spaces], pars[:space_type_id])

    respond_to do |format|
      format.html {
        flash.now[:notice] = t('.space_type_ok')
        render action: "edit_spaces"
      }
    end
  end

  # GET /floors/1/edit
  def edit_spaces
    @floor = Floor.with_allocations(params[:id]).take
    authorize! :read, @floor
    respond_to do |format|
      format.html
      format.js
    end
  end

  # Returns the plain drawing related to the floor
  def drawing
    @floor = Floor.find(params[:id])
    authorize! :read, @floor

    send_data(@floor.drawing_with_gage_area,
              filename: @floor.drawing.file.filename,
              disposition: "inline")
  end

  # Returns the drawing of the floor with all spaces drawn on it. The
  # spaces will be painted red if some allocation have been made,
  # green otherwise (free space). The name of the space will be
  # written in the center.
  def drawing_full
    @floor = Floor.find(params[:id])
    authorize! :read, @floor

    label = "all-allocations-drawing-#{@floor.cache_key}"

    send_data(
      Rails.cache.fetch(label) {
        @floor = Floor.with_allocations(params[:id]).take

        data = @floor.drawing_with_all_allocations

        Rails.cache.write(label, data)
        data
      },
      filename: @floor.drawing.model.attributes[:drawing].nil? ? 'unknown.png' : @floor.drawing.file.filename,
      disposition: "inline"
    )
  end

  def drawing_allocations
    @floor = Floor.find(params[:id])
    authorize! :read, @floor

    case params[:obj_class]
    when 'Org'
      @floor = Floor.where(id: params[:id]).with_allocations_to_org(params[:allocation_obj_id]).take
    when 'Person'
      @floor = Floor.where(id: params[:id]).with_allocations_to_person(params[:allocation_obj_id]).take
    when 'Requirement'
      @floor = Floor.where(id: params[:id]).with_allocations_to_requirement(params[:allocation_obj_id]).take
    end

    send_data(@floor.drawing_with_allocations,
              filename: @floor.drawing.file.filename,
              disposition: "inline")
  end

  # Returns the plain drawing related to the floor
  def drawing_locator
    @floor = Floor.find(params[:id])
    authorize! :read, @floor

    send_data(@floor.drawing_locator,
              filename: @floor.drawing.file.filename,
              disposition: "inline")
  end

  # GET /floors/1
  # GET /floors/1.json
  def show
    @floor = Floor.with_allocations(params[:id]).take
    authorize! :read, @floor
    session[:current_floor] = @floor.id

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render json: @floor }
    end
  end

  # GET /floors/1/export.xml
  def export
    @floor = Floor.with_spaces(params[:id]).take
    authorize! :read, @floor

    respond_to do |format|
      format.xml {
        send_data(
          @floor.to_xml(
            except: [:id, :building_id, :wing_id, :drawing],
            include: [ { building: {only: :name}},
                       { wing: {only: :name}},
                       { spaces: {
                           except: [:id, :space_type_id, :floor_id],
                           include: {space_type: {except: [:id, :space_count]}}}}]),
          filename: "floor #{@floor.complete_short_name.gsub(' / ', '.')}.xml",
          type: :xml
        )
      }
    end
  end

  # GET /floors/new
  # GET /floors/new.json
  def new
    @floor = Floor.new
    @floor.building = Building.find(session[:current_building])
    @floor.wing = Wing.find(params[:wing_id])
    authorize! :create, @floor

    if params[:wing_id]
      @floor.wing = Wing.find(params[:wing_id])
    else
      @floor.wing = Wing.find_or_create_by(building_id: @floor.building_id, name: 'Default', short_name: 'Default')
      unless @floor.wing.order
        @floor.wing.order = -99
        @floor.wing.save
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @floor }
    end
  end

  # GET /floors/1/edit
  def edit
  end

  # POST /floors
  # POST /floors.json
  def create
    @floor = Floor.new(floor_params)
    authorize! :create, @floor

    respond_to do |format|
      if @floor.save
        format.html { redirect_to @floor, notice: t('.create_ok', item: @floor.name) }
        format.json { render json: @floor, status: :created, location: @floor }
      else
        format.html { render action: "new" }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /floors/1
  # PUT /floors/1.json
  def update
    respond_to do |format|
      if @floor.update(floor_params)
        format.html { redirect_to @floor, notice: t('.update_ok', item: @floor.name) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @floor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floors/1
  # DELETE /floors/1.json
  def destroy
    the_name = @floor.name
    wing_id = @floor.wing_id
    @floor.destroy

    respond_to do |format|
      format.html { redirect_to wing_url(wing_id), status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def floor_params
      params.require(:floor).permit(
          :building_id, :wing_id, :corners_coor, :apply_transformation, :drawing, :gage_area,
          :gage_center_coor, :gage_coor, :locator_coor, :level, :name, :order)
    end

    def bulk_space_type_params
      params.require(:bulk_space_type).permit({spaces: []}, :space_type_id)
    end

    def bulk_coor_adjust_params
      params.permit({spaces: []}, :type)
    end
end
