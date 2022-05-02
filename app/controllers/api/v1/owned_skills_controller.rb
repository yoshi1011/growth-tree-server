class Api::V1::OwnedSkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owned_skill, only: [:update, :destroy]

  def create
    user = current_user.employees.find(params[:user_id])
    @owned_skill = user.owned_skills.build(create_owned_skill_params)
    @owned_skill.save!
  end

  def update
    @owned_skill.assign_attributes(update_owned_skill_params)
    @owned_skill.save!
  end

  def destroy
    @owned_skill.destroy!

    render json: {status: true, message: "owned_skill delete success"}
  end

  private

  def set_owned_skill
    user = current_user.employees.find(params[:user_id])
    @owned_skill = user.owned_skills.find_by!(skill_id: params[:id])
  end

  def create_owned_skill_params
    params.permit(:skill_id, :point)
  end

  def update_owned_skill_params
    params.permit(:point)
  end
end
