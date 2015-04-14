class TasksController < ApplicationController
  inject :task_manager
  inject :task_searcher

  load_and_authorize_resource except: [:create, :update]

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    @search = TaskSearchForm.new(params[:search])
    @projects = current_user.projects.map{ |p| [p.name, p.id] }
    @tasks = task_searcher.find_by_form(@search).includes(:project, :time_entries).order('date DESC, created_at').paginate(page: params[:page], per_page: 20)
  end

  def new
    authorize! :create, Task
  end

  def create
    authorize! :create, Task
    task_manager.create(task_params) do |task, saved|
      if saved
        render json: task
      else
        render json: task.errors.messages, status: 422
      end
    end
  end

  def edit

  end

  def update
    task = current_user.tasks.find(params[:id])
    authorize! :update, task
    task_manager.update(task, task_params) do |task, saved|
      if saved
        render json: task
      else
        render json: task.errors.messages, status: 422
      end
    end
  end

  def destroy
    task_manager.destroy(@task)
    redirect_to tasks_path
  end

  def find
    tasks = task_searcher.find(params)
    render json: tasks
  end

  protected

  def task_params
    TaskPermitter.permit(params)
  end

  def prepare_gon
    gon.task = @task.present? ? TaskPresenter.new(@task).to_hash : nil
    gon.projects = current_user.projects
    gon.statuses = Task.statuses_i18n.map{ |k,v| { id: k, name: v } }
    gon.task_types = Task.task_types_i18n.map{ |k,v| { id: k, name: v } }
  end
end
