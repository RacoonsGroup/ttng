class Admin::ProjectsController < Admin::AdminController
  load_and_authorize_resource except: [:create, :update]
  inject :project_manager

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    @projects = ProjectPresenter.map(@projects.includes(:customer, :users, :tasks, :features, :bugs, :chores).paginate(page: params[:page]))
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
    @filter = TaskSearchForm.new(params[:filter])
    @tasks = @project.tasks.order('date DESC').limit(10).includes(:user, :time_entries)
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: 'show', filename: @project.name}
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
    redirect_to admin_projects_path
  end

  def export
    session[:export_project_id] = @project.id
    redirect_to '/auth/google_oauth2'
  end

  def to_google_drive
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order('date DESC').limit(10).includes(:user, :time_entries)

    stringed = render_to_string(template: 'admin/projects/show.xlsx.axlsx')
    file_path = "#{Rails.root}/tmp/report.xlsx"
    File.open(file_path, 'w') { |file| file.write(stringed) }
    GoogleExporter.upload_file(file_path)
    redirect_to admin_project_path(@project.id)

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
