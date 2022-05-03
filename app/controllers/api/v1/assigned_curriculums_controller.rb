class Api::V1::AssignedCurriculumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assigned_curriculum, only: [:update_schedule, :update_completed, :destroy]

  def index
    @assigned_curriculums = employee.assigned_curriculums
  end

  def create
    # TODO: 同時にAssignedMission, AssignedTaskを作成する処理は別に記述する
    @assigned_curriculum = employee.assigned_curriculums.new(assigned_curriculum_params)
    @assigned_curriculum.save!

    missions = @assigned_curriculum.curriculum.missions
    new_assigned_missions = missions.map do |mission|
      {assigned_curriculum_id: @assigned_curriculum.id, mission_id: mission.id}
    end

    assigned_missions = employee.assigned_missions.new(new_assigned_missions)
    assigned_missions.map(&:save!)

    assigned_missions.each do |assigned_mission|
      tasks = assigned_mission.mission.tasks

      new_assigned_tasks = tasks.map do |task|
        {assigned_mission_id: assigned_mission.id, task_id: task.id}
      end

      assigned_tasks = employee.assigned_tasks.new(new_assigned_tasks)
      assigned_tasks.map(&:save!)
    end

    @assigned_curriculum.reload
  end

  # NOTE: updateメソッドを残すかどうかは検討中
  # def update
  #   @assigned_curriculum.assign_attributes(assigned_curriculum_params)
  #   @assigned_curriculum.save!
  # end

  def update_schedule
    @assigned_curriculum.assign_attributes(schedule_update_params)
    @assigned_curriculum.save!
  end

  def update_completed
    @assigned_curriculum.completed = !@assigned_curriculum.completed
    @assigned_curriculum.save!
  end

  def destroy
    @assigned_curriculum.destroy!

    render json: { message: "assigned_curriculum delete success" }
  end

  private

  def employee
    current_user.employees.find(params[:user_id])
  end

  def set_assigned_curriculum
    # APIのわかりやすさを考慮してパス名にはassigned_curriculumを使わず
    # user_idとcurriculum_idとで指定する方式にした
    @assigned_curriculum = employee.assigned_curriculums.find_by!(curriculum_id: params[:curriculum_id])
  end

  def assigned_curriculum_params
    params.require(:body).permit(:curriculum_id, :start_datetime, :end_datetime)
  end

  def schedule_update_params
    params.require(:body).permit(:start_datetime, :end_datetime)
  end
end
