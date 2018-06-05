class ReportsController < ApplicationController
  load_and_authorize_resource except: [:create, :icon_selector, :prepare, :exec]

  #before_action :set_report, only: [:prepare, :exec, :show, :edit, :update, :destroy]

  def test
    respond_to do |format|
      format.js
    end
  end

  def icon_selector
    authorize! :read, Report
    respond_to do |format|
      format.html
      format.js
    end
  end

  def prepare
    @report = Report.find(params[:id])
    authorize! :read, @report

    if @report.params_script.blank?
      redirect_to exec_report_path(@report)
    end
  end

  def exec
    @report = Report.find(params[:id])
    authorize! :read, @report

    eval(@report.exec_script) unless @report.exec_script.blank?

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /reports
  # GET /reports.json
  def index
    @reports = @reports.alpha_list
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /reports/new
  def new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /reports/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    authorize! :create, @report

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: t('.create_ok') }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: t('.update_ok', item: @report.name) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    the_name = @report.name
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, status: 303, notice: t('.delete_ok', item: the_name) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:name, :group, :order, :icon, :params_script, :exec_script, :view_script, :enabled)
    end
end
