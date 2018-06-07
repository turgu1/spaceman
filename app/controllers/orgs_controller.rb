class OrgsController < ApplicationController
  load_and_authorize_resource except: [:create, :show_allocated_floors, :show_right, :export, :export_all]

  before_action :set_back_url, only: [ :show_allocated_floors, :show ]

  def show_allocated_floors
    @org = Org.with_allocations(params[:id]).take
    authorize! :read, @org
    @floors = @org.allocation_floors
    respond_to do |format|
      format.html
      format.js # show_allocated_floors.js.erb
    end
  end

  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = @orgs.order(:order, :name)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @orgs }
    end
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show
    session[:current_org] = @org.id

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @org }
    end
  end

  # GET /orgs/1/export.xml
  def export
    @org = Org.with_people_and_requirements(params[:id]).take
    authorize! :read, @org

    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"org #{@org.abbreviation}.xlsx\""
      }
      format.xml {
        send_data(
            @org.to_xml(
              except: [:id, :manager_id, :parent_id, :admin_id],
              include: [
                { people:  { except: [:id, :org_id] }},
                { manager: { only:   [:first_name, :last_name]}},
                { admin:   { only:   [:first_name, :last_name]}},
                { requirements: {
                  except: [:id, :org_id, :requester_id, :pm_id, :manager_id],
                  include: [
                    { person: { only: [:first_name, :last_name] } }
                  ]}}]),
            filename: "org #{@org.abbreviation}.xml",
            type: :xml)}
    end
  end

  # GET /orgs/export_all.xml
  def export_all
    authorize! :read, Org
    @orgs = Org.all.people_and_requirements

    respond_to do |format|
      format.xlsx { response.headers['Content-Disposition'] = "attachment; filename=\"orgs.xlsx\"" }
      format.xml {
        send_data(
            @orgs.to_xml(
                except: [:id, :manager_id, :parent_id, :admin_id],
                include: [
                    { people:  { except: [:id, :org_id] }},
                    { manager: { only:   [:first_name, :last_name]}},
                    { admin:   { only:   [:first_name, :last_name]}},
                    { requirements: {
                        except: [:id, :org_id, :requester_id, :pm_id, :manager_id],
                        include: [
                            { person: { only: [:first_name, :last_name] } }
                        ]}}]),
            filename: "orgs.xml",
            type: :xml)}
    end
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show_right
    @org = Org.with_allocations_only(params[:id]).take
    authorize! :read, @org
    session[:current_org] = @org.id

    respond_to do |format|
      format.js
    end
  end

  # GET /orgs/new
  # GET /orgs/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @org }
    end
  end

  # GET /orgs/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)
    authorize! :create, @org

    respond_to do |format|
      if @org.save
        format.html { redirect_to @org, notice: t('.create_ok', item: @org.abbreviation) }
        format.json { render json: @org, status: :created, location: @org }
      else
        format.html { render action: "new" }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orgs/1
  # PUT /orgs/1.json
  def update
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to @org, notice: t('.update_ok', item: @org.abbreviation) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    session[:current_org] = nil if session[:current_org].to_i == @org.id.to_i
    the_name = @org.name
    @org.destroy

    respond_to do |format|
      format.html { redirect_to orgs_path, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def org_params
      params.require(:org).permit(
          :abbreviation, :name, :order, :manager_id, :admin_id,
          people_attributes: [
            :first_name, :from_date, :last_name, :needs_office_space,
            :phone_number, :title, :to_date, :id, :_destroy ],
          requirements_attributes: [
            :org_id, :allocation_completed, :authorized_for_allocation,
            :created_by, :facility_criteria, :facility_justification,
            :from_date, :manager_id, :manager_ok, :notes, :pm_id, :pm_ok,
            :project_name, :requirement_date, :requirement_type,
            :requester_id, :scientific_criteria, :scientific_justification,
            :security_justification, :to_date, :id, :_destroy ]
        )
    end
end
