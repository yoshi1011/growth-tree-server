class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = current_user.company.tasks
  end

  def show; end

  def create
    @task = current_user.company.tasks.build(task_params)
    @task.save!
  end

  def update
    @task.assign_attributes(task_params)
    @task.save!
  end

  def destroy
    @task.destroy!

    render json: {status: true, message: "task delete success"}
  end

  private

  def set_task
    @task = current_user.company.tasks.find(params[:id])
  end

  def task_params
    params.permit(:name, :description, :must_be_submitted)
  end
end
