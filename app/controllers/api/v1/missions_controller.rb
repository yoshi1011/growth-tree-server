class Api::V1::MissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mission, only: [:show, :update, :destroy]

  def index
    @missions = current_user.company.missions
  end

  def show; end

  def create
    @mission = current_user.company.missions.build(mission_params)
    @mission.save!
  end

  def update
    @mission.assign_attributes(mission_params)
    @mission.save!
  end

  def destroy
    @mission.destroy!

    render json: {message: "mission delete success"}
  end

  private

  def set_mission
    @mission = current_user.company.missions.find(params[:id])
  end

  def mission_params
    params.require(:body).permit(:name, :description)
  end
end
