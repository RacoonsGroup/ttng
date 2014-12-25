class ProjectsController < AuthenticatedController
  load_and_authorize_resource through: :current_user

  def index
    @projects = ProjectPresenter.map(@projects)
  end

  def show

  end
end