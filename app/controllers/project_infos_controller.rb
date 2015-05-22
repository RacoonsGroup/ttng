class ProjectInfosController < AuthenticatedController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  inject :project_info_manager

  def show
    @info = @project_info.decrypted_info(params[:password])
  end

  def new

  end

  def create
    project_info_manager.create(project_info_params) do |project_info, saved|
      if saved
        redirect_to admin_project_path(@project)
      else
        @project_info = project_info
        render :new
      end
    end
  end

  def edit

  end

  def update
    project_info_manager.update(@project_info, project_info_params) do |project_info, saved|
      if saved
        redirect_to admin_project_path(@project)
      else
        @project_info = project_info
        render :edit
      end
    end
  end

  def destroy
    project_info_manager.destroy(@project_info)
    redirect_to admin_project_path(@project)
  end

  private

  def project_info_params
    ProjectInfoPermitter.permit(params)
  end
end