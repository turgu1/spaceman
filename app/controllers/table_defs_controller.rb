class TableDefsController < ApplicationController
  load_and_authorize_resource except: [:create]

  # GET /table_defs
  # GET /table_defs.json
  def index
    @table_defs = TableDef.all
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /table_defs/1
  # GET /table_defs/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /table_defs/new
  def new
    @table_def = TableDef.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /table_defs/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /table_defs
  # POST /table_defs.json
  def create
    @table_def = TableDef.new(table_def_params)
    authorize! :create, @table_def

    respond_to do |format|
      if @table_def.save
        format.html { redirect_to @table_def, notice: t('.create_ok') }
        format.json { render action: 'show', status: :created, location: @table_def }
      else
        format.html { render action: 'new' }
        format.json { render json: @table_def.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /table_defs/1
  # PATCH/PUT /table_defs/1.json
  def update
    respond_to do |format|
      if @table_def.update(table_def_params)
        format.html { redirect_to @table_def, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @table_def.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_defs/1
  # DELETE /table_defs/1.json
  def destroy
    @table_def.destroy
    respond_to do |format|
      format.html { redirect_to table_defs_url, status: 303 }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_def
      @table_def = TableDef.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_def_params
      params.require(:table_def).permit(:name, fields_attributes: [:id, :name, :field_type, :required, :order, :_destroy])
    end
end
