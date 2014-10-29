class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  inject :user_manager

  def index
    @users = @users.paginate(page: params[:page])
  end

  def edit

  end

  def update
    user_manager.update(@user, user_params) do |user, saved|
      if saved
        redirect_to admin_users_path
      else
        @user = user
        render :edit
      end
    end
  end

  def destroy
    user_manager.destroy(@user)
    redirect_to admin_users_path
  end

  private

  def user_params
    if params[:user][:password].present?
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:email, :admin)
    end
  end
end
