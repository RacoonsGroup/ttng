class TasksController < ApplicationController
  inject :task_manager
  inject :task_searcher

  load_and_authorize_resource except: [:create, :update]

  def index
    @tasks = @tasks.includes(:project, :time_entries).order('date DESC, created_at').paginate(page: params[:page])
  end

  def new
    authorize! :create, Task
    gon.task = nil
    gon.projects = current_user.projects
    gon.statuses = Task.statuses_i18n.map{ |k,v| { id: k, name: v } }
    gon.task_types = Task.task_types_i18n.map{ |k,v| { id: k, name: v } }
  end

  def create
    authorize! :create, Task
    task_manager.create(create_task_params) do |task, saved|
      if saved
        render json: task
      else
        render json: task.errors.messages, status: 422
      end
    end
  end

  def edit

  end

  def find
    tasks = task_searcher.find(params)
    render json: tasks
  end

  protected

  def create_task_params
    TaskPermitter.permit(params)
  end
end
