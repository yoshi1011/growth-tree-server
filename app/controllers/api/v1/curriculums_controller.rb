class Api::V1::CurriculumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_curriculum, only: [:show, :update, :destroy]

  def index
    curriculums = Curriculum.all

    render json: curriculums
  end

  def show
    render json: @curriculum
  end

  def create
    curriculum = current_user.company.curriculums.build(curriculum_params)
    if curriculum.valid?
      curriculum.save
      render json: curriculum
    else
      response = {
        success: false,
        errors: curriculum.errors
      }
      render status: 400, json: response
    end
  end

  def update
    @curriculum.assign_attributes(curriculum_params)
    if @curriculum.valid?
      @curriculum.save
      render json: @curriculum
    else
      response = {
        success: false,
        errors: @curriculum.errors
      }
      render status 400, json: response
    end
  end

  def destroy
    @curriculum.destroy

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
