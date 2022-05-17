class Api::V1::SetMissionsController < ApplicationController
  before_action :authenticate_user!

  def create
    curriculum.set_mission(mission)

    render json: { message: "set_mission create success" }
  end

  def destroy
    curriculum.remove_mission(mission)

    render json: { message: "set_mission delete success" }
  end

  private

  # NOTE: curriculum, missionメソッドを利用することになった場合にバグになる可能性あり
  def curriculum
    current_user.company.curriculums.find(params[:curriculum_id])
  end

  def mission
    current_user.company.missions.find(params[:mission_id])
  end
end
