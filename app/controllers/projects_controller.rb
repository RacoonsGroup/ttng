class ProjectsController < AuthenticatedController
  load_and_authorize_resource through: :current_user, except: [:create, :update]
  inject :project_manager
  inject :google_exporter

  before_filter :prepare_gon, only: [:new, :edit]
  before_filter :find_tasks, only: [:show, :to_google_drive]

  def index
    @projects = ProjectPresenter.map(@projects.search(params[:search]).order('projects.created_at DESC')).paginate(page: params[:page], per_page: 10)
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
    @filter = RelatedTaskSearchForm.new(params[:filter])
    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: 'show', filename: @project.name
      end
    end
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

  def export
    session[:export_project_id] = @project.id
    session[:export_project_from] = params[:from]
    session[:export_project_to] = params[:to]

    redirect_to '/auth/google_oauth2'
  end

  def to_google_drive

    string = render_to_string(template: 'projects/show.xlsx.axlsx')
    google_exporter.upload_file(project: @project, content: string)
    redirect_to admin_project_path(@project.id)
  end

  private

  def project_params
    ProjectPermitter.permit(params)
  end

  def prepare_gon
    gon.project = @project.present? ? ProjectPresenter.new(@project).to_hash : nil
    gon.customers = Customer.all
    gon.users = UserPresenter.map(User.available)
  end

  def find_tasks
    @related_tasks = @project.related_tasks.order(date: :DESC).includes(:user, :time_entries)
    @from = session[:export_project_from].presence || params[:from]
    @to = session[:export_project_to].presence || params[:to]

    session.delete :export_project_from
    session.delete :export_project_to

    @related_tasks = between_date(@related_tasks, @from, '>=')
    @related_tasks = between_date(@related_tasks, @to, '<=')
  end

  def between_date(tasks, var, eq)
    if var.present?
      var = Date.strptime(var, '%d.%m.%Y')
      tasks = tasks.where("date #{eq} ?", var)
    end
    tasks
  end
end
