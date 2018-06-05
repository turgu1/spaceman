class BuildingsController < ApplicationController
  load_and_authorize_resource except: [:create, :export]

  before_action :set_back_url, only: [ :show ]

  def photo
    send_data(@building.photo,
              filename: @building.photo_filename,
              type: @building.photo_type,
              disposition: 'inline')
  end

  # GET /buildings
  # GET /buildings.json
  def index
    @buildings = @buildings.order(:name)
    session[:sidebar] = 'building'

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @buildings }
    end
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
    session[:current_building] = @building.id
    session[:current_floor] = nil
    session[:sidebar] = 'building'

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @building }
    end
  end

  # GET /buildings/1/export.xml
  def export
    @building = Building.with_spaces(params[:id]).take
    authorize! :read, @building

    respond_to do |format|
      format.xml {
        send_data(
          @building.to_xml(
            except: [:id, :photo],
            include: [
              { wings: {
                except: [:id, :building_id],
                include: {
                  floors: {
                    except: [:id, :building_id, :wing_id, :drawing],
                    include: {
                      spaces: {
                        except: [:id, :space_type_id, :floor_id],
                        include: {space_type: {except: [:id, :space_count]}}}}}}}}]),
          filename: "building #{@building.short_name}.xml",
          type: :xml)
      }
    end
  end


  # GET /buildings/new
  # GET /buildings/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @building }
    end
  end

  # GET /buildings/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /buildings
  # POST /buildings.json
  def create
    @building = Building.new(building_params)
    authorize! :create, @building

    respond_to do |format|
      if @building.save
        format.html { redirect_to @building, notice: t('.create_ok', item: @building.name) }
        format.json { render json: @building, status: :created, location: @building }
      else
        format.html { render action: 'new' }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buildings/1
  # PUT /buildings/1.json
  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to @building, notice: t('.update_ok', item: @building.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    the_name = @building.name
    unless session[:current_building].nil?
      session[:current_building] = nil if session[:current_building].to_i == @building.id.to_i
    end
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def building_params
      params.require(:building).permit(
        :name, :short_name, :photo, :min_level, :max_level, :allocate_equipment,
        :moving_items, floor_images_attributes: [:id, :name, :level, :file, :_destroy])
    end
end

