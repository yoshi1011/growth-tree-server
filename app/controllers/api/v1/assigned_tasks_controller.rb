class Api::V1::AssignedTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assigned_task, only: [:update_schedule, :update_completed, :destroy]

  def index
    @assigned_tasks = employee.assigned_tasks
  end

  def create
    @assigned_task = employee.assigned_tasks.new(assigned_task_params)
    @assigned_task.save!
  end

  def update_schedule
    @assigned_task.assign_attributes(schedule_update_params)
    @assigned_task.save!
  end

  def update_completed
    @assigned_task.completed = !@assigned_task.completed
    @assigned_task.save!
  end

  def destroy
    @assigned_task.destroy!

    render json: { message: "assigned_task delete success" }
  end

  private

  def employee
    current_user.employees.find(params[:user_id])
  end

  def set_assigned_task
    @assigned_task = employee.assigned_tasks.find(params[:curriculum_id])
  end

  def assigned_task_params
    params.require(:body).permit(:task_id, :start_datetime, :end_datetime)
  end

  def schedule_update_params
    params.require(:body).permit(:start_datetime, :end_datetime)
  end
end
