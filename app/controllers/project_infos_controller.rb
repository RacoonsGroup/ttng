class ProjectInfosController < AuthenticatedController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  inject :project_info_manager

  def show
    @info = @project_info.decrypted_info(params[:password])
  end

end