class RelatedTasksController < ApplicationController
  inject :related_task_manager
  inject :related_task_searcher
  inject :time_entry_searcher

  load_and_authorize_resource except: [:create, :update]

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    @search = RelatedTaskSearchForm.new(params[:search])
    @projects = current_user.projects.map{ |p| [p.name, p.id] }
    @time_entries = time_entry_searcher.find_by_form(@search).includes(:related_task).order(date: :DESC)
    @sum = @time_entries.to_a.inject(0) { |sum, task| sum + task.duration }
    @time_entries = @time_entries.paginate(page: params[:page], per_page: 20)
  end

  def new
    authorize! :create, RelatedTask
    gon.last_project = current_user.time_entries.last.related_task.project
  end

  def create
    authorize! :create, RelatedTask
    related_task_manager.create(related_task_params) do |task, saved|
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
    related_task = RelatedTask.find(params[:id])
    authorize! :update, related_task
    related_task_manager.update(related_task, related_task_params) do |task, saved|
      if saved
        render json: task
      else
        render json: task.errors.messages, status: 422
      end
    end
  end

  def destroy
    related_task_manager.destroy(@related_task)
    redirect_to related_tasks_path
  end

  def find
    related_tasks = related_task_searcher.find(params)
    render json: related_tasks
  end

  protected

  def related_task_params
    RelatedTaskPermitter.permit(params)
  end

  def prepare_gon
    gon.related_task = @related_task.present? ? RelatedTaskPresenter.new(@related_task).to_hash : nil
    gon.projects = if current_user.chief?
                      Project.all
                    else
                      current_user.projects
                    end
    gon.statuses = RelatedTask.statuses_i18n.map{ |k,v| { id: k, name: v } }
    gon.task_types = RelatedTask.task_types_i18n.map{ |k,v| { id: k, name: v } }
  end
end
