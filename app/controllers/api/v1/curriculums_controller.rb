class Api::V1::CurriculumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_curriculum, only: [:show, :update, :destroy]

  def index
    @curriculums = current_user.company.curriculums
  end

  def show; end

  def create
    @curriculum = current_user.company.curriculums.build(curriculum_params)
    @curriculum.save!
  end

  def update
    @curriculum.assign_attributes(curriculum_params)
    @curriculum.save!
  end

  def destroy
    @curriculum.destroy!

    render json: {status: true, message: "Curriculum delete success"}
  end

  private

  def set_curriculum
    @curriculum = current_user.company.curriculums.find(params[:id])
  end

  def curriculum_params
    params.permit(:name, :description)
  end
end
