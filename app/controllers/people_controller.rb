class PeopleController < ApplicationController
  load_and_authorize_resource except: [:create, :new, :show_modal, :show_allocated_floors]

  before_action :set_back_url, only: [ :show_allocated_floors ]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show_modal
    @person = Person.find(params[:id])
    authorize! :read, @person

    respond_to do |format|
      format.js # show_modal.js.erb
    end
  end

  def show_allocated_floors
    @person = Person.with_allocations(params[:id]).take
    authorize! :read, @person
    @floors = @person.allocation_floors
    respond_to do |format|
      format.html
      format.js # show_allocated_floors.js.erb
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @person.org = Org.find(params[:org]) if params[:org]
    @person.needs_office_space = true
    @person.from_date = Date.today
    @person.to_date = nil
    authorize! :create, @person

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    authorize! :create, @person

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: t('.create_ok') }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    the_org = @person.org_id
    the_name = @person.name
    @person.destroy

    respond_to do |format|
      format.html { redirect_to org_path(the_org), status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private

    def person_params
      params.require(:person).permit(
          :org_id, :first_name, :from_date, :last_name, :needs_office_space,
          :phone_number, :title, :to_date)
    end
end
