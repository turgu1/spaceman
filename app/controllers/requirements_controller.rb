class RequirementsController < ApplicationController
  load_and_authorize_resource except: [:create, :show_modal, :show_allocated_floors]

  before_action :set_back_url, only: [ :show_allocated_floors ]

  def show_modal
    @requirement = Requirement.find(params[:id])
    authorize! :read, @requirement

    respond_to do |format|
      format.js # show_modal.js.erb
    end
  end

  def show_allocated_floors
    @requirement = Requirement.with_allocations(params[:id]).take
    authorize! :read, @requirement
    @floors = @requirement.allocation_floors
    respond_to do |format|
      format.html
      format.js # show_allocated_floors.js.erb
    end
  end

  # GET /requirements
  # GET /requirements.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requirements }
    end
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @requirement }
    end
  end

  # GET /requirements/new
  # GET /requirements/new.json
  def new
    @requirement.org = Org.find(params[:org]) if params[:org]
    #@requirement.org_id = params[:org_id]

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @requirement }
    end
  end

  # GET /requirements/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)
    authorize! :create, @requirement

    respond_to do |format|
      if @requirement.save
        format.html { redirect_to @requirement, notice: t('.create_ok') }
        format.json { render json: @requirement, status: :created, location: @requirement }
      else
        format.html { render action: "new" }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requirements/1
  # PUT /requirements/1.json
  def update
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html { redirect_to @requirement, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    the_org = @requirement.org_id
    the_name = @requirement.project_name
    @requirement.destroy

    respond_to do |format|
      format.html { redirect_to org_path(the_org), status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def requirement_params
      params.require(:requirement).permit(
          :org_id, :allocation_completed, :authorized_for_allocation,
          :created_by, :facility_criteria, :facility_justification,
          :from_date, :manager_id, :manager_ok, :notes, :pm_id, :pm_ok,
          :project_name, :requirement_date, :requirement_type,
          :requester_id, :scientific_criteria, :scientific_justification,
          :security_justification, :to_date)
    end
end
