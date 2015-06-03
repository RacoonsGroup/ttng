class UsersController < ApplicationController
  load_and_authorize_resource
  inject :user_manager

  def index
    @users = User.available.paginate(page: params[:page], per_page: 16)
  end

  def show

  end

  def edit

  end

  def update
    user_manager.update(@user, user_params) do |user, saved|
      if saved
        redirect_to users_path
      else
        @user = user
        render :edit
      end
    end
  end

  private

  def user_params
    UserPermitter.permit(params)
  end
end
