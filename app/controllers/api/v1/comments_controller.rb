class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = task.comments
  end

  def show; end

  def create
    @comment = task.comments.build(comment_params)
    @comment.user_id = employee.id
    @comment.save!
  end

  def update
    @comment.assign_attributes(comment_params)
    @comment.save!
  end

  def destroy
    @comment.destroy!

    render json: {message: "comment delete success"}
  end

  def employee
    current_user.company.users.find(params[:user_id])
  end

  def task
    employee.assigned_tasks.find(params[:assigned_task_id])
  end

  private

  def set_comment
    @comment = task.comments.find(params[:id])
  end

  def comment_params
    # TODO: Attachmentを実装後にAttachment対応を行う
    params.require(:body).permit(:content)
  end
end
