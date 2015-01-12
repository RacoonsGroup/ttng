class Api::RemoteTasksController < AuthenticatedController
  inject :pivotal_api

  before_filter :find_project

  def index
    render json: RemoteTaskPresenter.map(pivotal_api.stories(params[:query])).map(&:to_hash)
  end

  def show
    render json: RemoteTaskPresenter.new(pivotal_api.story(params[:id])).to_hash
  end

  private

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end
end