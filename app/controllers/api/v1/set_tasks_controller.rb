class Api::V1::SetTasksController < ApplicationController
  before_action :authenticate_user!

  def create
    mission.set_task(task)

    render json: { message: "set_task create success" }
  end

  def destroy
    mission.remove_task(task)

    render json: { message: "set_task delete success" }
  end

  private

  # NOTE: mission, taskメソッドを利用することになった場合にバグになる可能性あり
  def mission
    current_user.company.missions.find(params[:mission_id])
  end

  def task
    current_user.company.tasks.find(params[:task_id])
  end
end
