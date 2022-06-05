class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [
    :show,
    :update,
    :update_role,
    :destroy
  ]

  # NOTE: UsersControllerでは利用ユーザーからのリクエストに応える処理を定義するものとするため、
  # deviseが定義するユーザー作成などとは権限、できる範囲を変える
  # Admin機能の実装などで自由なユーザー作成権限が必要になった場合は、
  # controllers/devise_overrides/にて別途ユーザーに関する処理を定義する

  def index
    @users = current_user.company.users
  end

  def show; end

  def create
    # TODO: devise_invitableを導入する
    @user = current_user.company.users.build(new_user_params)
    @user.save!
  end

  def update
    @user.assign_attributes(update_user_params)
    @user.save!
  end

  def update_image
    # NOTE: フロントエンド側からBASE64エンコードした画像データを取得するためのコード。
    # carrierwave-base64のgemを導入し実現している。「data:image/...」をハードコーディングしなくても済む方法があるかも
    @resource.assign_attributes(image_url: "data:image/png;base64," + params[:image_url])
    @resource.save!
  end

  def update_role
    @user.assign_attributes(update_role_params)
    @user.save!
  end

  def update_login_setting
    @resource.update_with_password(login_setting_params)
  end

  def update_profile_setting
    @resource.assign_attributes(profile_setting_params)
    @resource.save!
  end

  def destroy
    @user.destroy!

    render json: {message: "user delete success"}
  end

  private

  def set_user
    @user = current_user.company.users.find(params[:id])
  end

  def new_user_params
    params.require(:body).permit(
      :email, :password, :first_name, :last_name, :birthday, :role, :joined_date
    )
  end

  def update_user_params
    params.require(:body).permit(
      :email, :password, :first_name, :last_name
    )
  end

  def update_role_params
    params.require(:body).permit(:role)
  end

  def login_setting_params
    params.require(:profile).permit(
      :email,
      :current_password,
      :password,
      :password_confirmation
    )
  end

  def profile_setting_params
    params.required(:profile).permit(
      :first_name,
      :last_name,
      :birthday,
      :joined_date
    )
  end
end
