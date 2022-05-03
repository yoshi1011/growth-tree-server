class Api::V1::SkillPointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill_point, only: [:update, :destroy]

  def create
    mission = current_user.company.missions.find(params[:mission_id])
    @skill_point = mission.skill_points.build(create_skill_point_params)
    @skill_point.save!
  end

  def update
    @skill_point.assign_attributes(update_skill_point_params)
    @skill_point.save!
  end

  def destroy
    @skill_point.destroy!

    render json: {message: "skill_point delete success"}
  end

  private

  def set_skill_point
    mission = current_user.company.missions.find(params[:mission_id])
    @skill_point = mission.skill_points.find_by!(skill_id: params[:id])
  end

  def create_skill_point_params
    params.require(:body).permit(:skill_id, :point)
  end

  def update_skill_point_params
    params.require(:body).permit(:point)
  end
end
