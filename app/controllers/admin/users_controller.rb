class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  inject :user_manager
  helper_method :sort_column, :sort_direction

  def index
    @users = @users.order(sort_column + " " + sort_direction).paginate(page: params[:page])
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
    fields = [:email, :admin, :first_name, :last_name, :birth_date, :position,
              :salary, :official_salary, :hire_date, :fire_date, :inn, :snils]
    if params[:user][:password].present?
      fields.push(:password, :password_confirmation)
    end
    params.require(:user).permit(fields)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
