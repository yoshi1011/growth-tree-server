class Api::V1::AssignedMissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assigned_mission, only: [:show, :update_schedule, :update_completed, :destroy]

  def index
    @assigned_missions = employee.assigned_missions
  end

  def show; end

  def create
    # TODO: 同時にAssignedTaskを作成する処理は別に記述する
    @assigned_mission = employee.assigned_missions.new(assigned_mission_params)
    @assigned_mission.save!

    tasks = @assigned_mission.mission.tasks

    new_assigned_tasks = tasks.map do |task|
      {assigned_mission_id: @assigned_mission.id, task_id: task.id}
    end

    assigned_tasks = employee.assigned_tasks.new(new_assigned_tasks)
    assigned_tasks.map(&:save!)

    @assigned_mission.reload
  end

  def update_schedule
    @assigned_mission.assign_attributes(schedule_update_params)
    @assigned_mission.save!
  end

  def update_completed
    @assigned_mission.completed = !@assigned_mission.completed
    @assigned_mission.save!
  end

  def destroy
    @assigned_mission.destroy!

    render json: { message: "assigned_mission delete success" }
  end

  private

  def employee
    current_user.employees.find(params[:user_id])
  end

  def set_assigned_mission
    @assigned_mission = employee.assigned_missions.find(params[:curriculum_id])
  end

  def assigned_mission_params
    params.require(:body).permit(:mission_id, :start_datetime, :end_datetime)
  end

  def schedule_update_params
    params.require(:body).permit(:start_datetime, :end_datetime)
  end
end
