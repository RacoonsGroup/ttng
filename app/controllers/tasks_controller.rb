class TasksController < ApplicationController
  inject :task_manager

  load_and_authorize_resource except: [:create, :update]

  def index
    @tasks = @tasks.includes(:project, :time_entries).order('date DESC, created_at').paginate(page: params[:page])
  end
end
