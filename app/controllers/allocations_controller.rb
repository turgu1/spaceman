class AllocationsController < ApplicationController
  load_and_authorize_resource except: [:create, :show_modal, :auto_new, :new]

  # GET /allocations
  # GET /allocations.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @allocations }
    end
  end

  def show_modal
    @allocation = Allocation.find(params[:id])
    authorize! :read, @allocation

    respond_to do |format|
      format.js # show_modal.js.erb
    end
  end

  # GET /allocations/1
  # GET /allocations/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @allocation }
    end
  end

  # Called when a drag and drop action is issued by the user from a person 
  # or requirement in the right column to a space in the current displayed floor. 
  # A new allocation is then created.
  def auto_new
    @allocation = Allocation.new
    pars = auto_new_params
    unless pars[:space_id].blank? || (pars[:person_id].blank? && pars[:requirement_id].blank?)
      @allocation.space = Space.find(pars[:space_id])
      @allocation.consumer = Person.find(pars[:person_id]) unless pars[:person_id].blank?
      @allocation.consumer = Requirement.find(pars[:requirement_id]) unless pars[:requirement_id].blank?
      @allocation.from_date = Date.today
      @allocation.to_date = nil
      authorize! :create, @allocation

      @allocation.save!
      @floor = Floor.with_allocations(@allocation.space.floor_id).take
      @center_target = pars[:center_target]

      flash.now[:notice] = t('.create_ok', item: @allocation.consumer_name)
    end
    respond_to do |format|
      format.js 
    end
  end

  # GET /allocations/new
  # GET /allocations/new.json
  def new
    @allocation = Allocation.new
    @allocation.space = Space.find(params[:space_id]) if params[:space_id]
    @allocation.from_date = Date.today
    @allocation.to_date = nil
    authorize! :new, @allocation

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @allocation }
    end
  end

  # GET /allocations/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /allocations
  # POST /allocations.json
  def create
    pars = allocation_params
    adjust_consumer pars
    @allocation = Allocation.new(pars)
    authorize! :create, @allocation

    respond_to do |format|
      if @allocation.save
        format.html { redirect_to @allocation, notice: t('.create_ok', item: @allocation.consumer_name) }
        format.json { render json: @allocation, status: :created, location: @allocation }
      else
        format.html { render action: "new" }
        format.json { render json: @allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /allocations/1
  # PUT /allocations/1.json
  def update
    respond_to do |format|
      pars = allocation_params
      #adjust_consumer pars
      if @allocation.update(pars)
        format.html { redirect_to @allocation, notice: t('.update_ok', item: @allocation.consumer_name) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allocations/1
  # DELETE /allocations/1.json
  def destroy
    the_name = @allocation.consumer_name
    pars     = destroy_params

    @allocation.destroy
    flash.now[:notice] = t('.delete_ok', item: the_name)

    # Right column information. This is required to keep the lists in their current state (showned or not)
    @right_showned_org_id = pars[:right_showned_org_id]
    if @right_showned_org_id.nil?
      @org = nil
    else
      @org = Org.with_people_and_requirements(@right_showned_org_id).take
    end

    @center_entity_showned = pars[:center_entity_showned]
    @center_entity_id = pars[:center_entity_id]
    @center_floor_id = pars[:center_floor_id]
    @center_target = pars[:center_target]

    case @center_entity_showned
    when 'floors'
      @floor = Floor.with_allocations(@center_floor_id).take
      return render partial: '/floors/update_center_full_allocations', locals: { center_target: pars[:center_target] }
    when 'orgs'
      @floor = Floor.where(id: @center_floor_id).with_allocations_to_org(@center_entity_id).take
      return render partial: '/floors/update_center_allocations', locals: { center_target: pars[:center_target], allocation_obj: @org }
    when 'people'
      @floor = Floor.where(id: @center_floor_id).with_allocations_to_person(@center_entity_id).take
      @person = Person.with_allocations(@center_entity_id).take
      return render partial: '/floors/update_center_allocations', locals: { center_target: pars[:center_target], allocation_obj: @person }
    when 'requirements'
      @floor = Floor.where(id: @center_floor_id).with_allocations_to_requirement(@center_entity_id).take
      @person = Person.with_allocations(@center_entity_id).take
      return render partial: '/floors/update_center_allocations', locals: { center_target: pars[:center_target], allocation_obj: @requirement }
    else
      flash.now[:error] = t('.internal_error')
      return render partial: 'layouts/error'
    end

    # @entity_id = pars[:center_entity_id] || @allocation.space.floor_id

    # # Entity Showned are:
    # #
    # # floors
    # # orgs
    # # people
    # # requirements
    # @center_entity_showned      = pars[:center_entity_showned]
    # @center_entity_id           = pars[:center_entity_id]

    # # Center column information
    # @entity_name = params[:center_entity_showned]
    # if @entity_name == 'orgs'
    # elsif @entity_name == 'requirements'
    # elsif @entity_name == 'people'
    # else
    #   @entity_name = 'floors'
    #   @entify = 
    # end

    # unless @showned_org
    # @showned_org = Org.with_people_and_requirements(@showned_org_id).take

    # respond_to do |format|
    #   format.js
    #   format.html { redirect_to back_home_index_path, status: 303 }
    #   format.json { head :no_content }
    # end
  end

private

  def allocation_params
    params.require(:allocation).permit(
        :space_id, :person_id, :requirement_id, :consumer_id, :consumer_type, :date,
        :from_date, :notes, :to_date,
        equipment_items_attributes: [:id, :qty, :notes, :equipment_model_id, :_destroy],
        moving_items_attributes: [:id, :allocation_id, :weight, :volume, :notes, :destination,
                                  :replace, :destination_id, :replace_id, :description, :qty,
                                  :_destroy])
  end

  def auto_new_params
    params.
      permit(:space_id, :right_people_showned, :right_requirements_showned, :person_id, 
        :center_entity_id, :center_entity_showned, :center_target, :requirement_id)
  end

  def destroy_params
    params.
      permit(:id, :center_entity_id, :center_entity_showned, :center_target, :center_floor_id, 
        :right_showned_org_id)
  end

  def adjust_consumer(pars)
    if pars[:person_id].blank?
      pars[:consumer_id] = pars[:requirement_id]
      pars[:consumer_type] = 'Requirement'
    else
      pars[:consumer_id] = pars[:person_id]
      pars[:consumer_type] = 'Person'
    end
    pars.delete(:person_id)
    pars.delete(:requirement_id)
  end

end