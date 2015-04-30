class ProjectsController < AuthenticatedController
  load_and_authorize_resource through: :current_user, except: [:create, :update]
  inject :project_manager

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    @projects = ProjectPresenter.map(@projects).paginate(page: params[:page], per_page: 5)
  end

  def new

  end

  def create
    authorize! :create, Project
    project_manager.create(project_params) do |project, saved|
      if saved
        render json: project
      else
        render json: project.errors.messages, status: 422
      end
    end
  end

  def show

  end

  def edit

  end

  def update
    @project = Project.find(params[:id])
    authorize! :update, @project
    project_manager.update(@project, project_params) do |project, saved|
      if saved
        render json: project
      else
        render json: project.errors.messages, status: 422
      end
    end
  end

  def destroy
    project_manager.destroy(@project)
    redirect_to projects_path
  end

  private

  def project_params
    ProjectPermitter.permit(params)
  end

  def prepare_gon
    gon.project = @project.present? ? ProjectPresenter.new(@project).to_hash : nil
    gon.customers = Customer.all
    gon.users = UserPresenter.map(User.all)
    gon.role = current_user.position
  end


end