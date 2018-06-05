class MovingTasksController < ApplicationController
  before_action :set_moving_task, only: [:show, :edit, :update, :destroy]

  # GET /moving_tasks
  # GET /moving_tasks.json
  def index
    @moving_tasks = MovingTask.all
  end

  # GET /moving_tasks/1
  # GET /moving_tasks/1.json
  def show
  end

  # GET /moving_tasks/new
  def new
    @moving_task = MovingTask.new
  end

  # GET /moving_tasks/1/edit
  def edit
  end

  # POST /moving_tasks
  # POST /moving_tasks.json
  def create
    @moving_task = MovingTask.new(moving_task_params)

    respond_to do |format|
      if @moving_task.save
        format.html { redirect_to @moving_task, notice: t('.create_ok') }
        format.json { render action: 'show', status: :created, location: @moving_task }
      else
        format.html { render action: 'new' }
        format.json { render json: @moving_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moving_tasks/1
  # PATCH/PUT /moving_tasks/1.json
  def update
    respond_to do |format|
      if @moving_task.update(moving_task_params)
        format.html { redirect_to @moving_task, notice: t('.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @moving_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moving_tasks/1
  # DELETE /moving_tasks/1.json
  def destroy
    @moving_task.destroy
    respond_to do |format|
      format.html { redirect_to moving_tasks_url, status: 303 }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moving_task
      @moving_task = MovingTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moving_task_params
      params.require(:moving_task).permit(:name, :description, :specialty_id, :responsability, :order, :duration, :cost)
    end
end
