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

  def to_google_drive
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order('date DESC').limit(10).includes(:user, :time_entries)
    stringed = render_to_string(template: 'admin/projects/show.xlsx.axlsx')
    File.open("#{Rails.root}/tmp/report.xlsx", 'w') { |file| file.write(stringed) }
    GoogleExporter.upload_file("#{Rails.root}/tmp/report.xlsx", token)
    render 'show'
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
