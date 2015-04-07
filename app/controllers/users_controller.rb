class UsersController < ApplicationController

  def index
    @users = User.available.paginate(page: params[:page], per_page: 16)
  end
end
