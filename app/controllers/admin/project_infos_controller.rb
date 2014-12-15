class Admin::ProjectInfosController < Admin::AdminController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  inject :project_info_manager

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

  def show

  end

  private

  def project_info_params
    ProjectInfoPermitter.permit(params)
  end
end