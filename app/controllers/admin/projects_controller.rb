class Admin::ProjectsController < Admin::AdminController
  load_and_authorize_resource except: [:create, :update]
  inject :project_manager

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    @projects = @projects.includes(:customer, :users).paginate(page: params[:page])
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
    @tasks = @project.tasks.order('date DESC').limit(10)
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
    redirect_to admin_projects_path
  end

  private

  def project_params
    ProjectPermitter.permit(params)
  end

  def prepare_gon
    gon.project = @project.present? ? ProjectPresenter.new(@project).to_hash : nil
    gon.customers = Customer.all
    gon.users = UserPresenter.map(User.all)
  end
end
