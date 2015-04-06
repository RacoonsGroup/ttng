class ProjectsController < AuthenticatedController
  load_and_authorize_resource through: :current_user

  def index
    @projects = ProjectPresenter.map(@projects).paginate(page: params[:page], per_page: 20)
  end

  def show

  end
end