class Api::V1::SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:show, :update, :destroy]

  def index
    @skills = current_user.company.skills
  end

  def show; end

  def create
    @skill = current_user.company.skills.build(skill_params)
    @skill.save!
  end

  def update
    @skill.assign_attributes(skill_params)
    @skill.save!
  end

  def destroy
    @skill.destroy!

    render json: {message: "skill delete success"}
  end

  private

  def set_skill
    @skill = current_user.company.skills.find(params[:id])
  end

  def skill_params
    params.permit(:name, :description)
  end
end
