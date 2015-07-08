class RelatedTasksController < ApplicationController
  inject :related_task_manager
  inject :related_task_searcher
  inject :time_entry_searcher

  respond_to :html, :json

  load_and_authorize_resource except: [:create, :update]

  before_filter :prepare_gon, only: [:new, :edit]

  def index
    session[:search_rt] = (session[:search_rt] || {}).merge(params[:search] || {})
    @search = RelatedTaskSearchForm.new(session[:search_rt])
    @projects = current_user.projects.map{ |p| [p.name, p.id] }
    @time_entries = time_entry_searcher.find_by_form(@search).includes(:related_task).order(date: :DESC)
    @sum = @time_entries.to_a.inject(0) { |sum, task| sum + task.duration }
    @time_entries = @time_entries.paginate(page: params[:page], per_page: 20)
  end

  def new
    authorize! :create, RelatedTask
    gon.last_project = current_user.time_entries.last.related_task.project if current_user.time_entries.last
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
    if params[:related_task][:payable].nil?
      related_task_manager.update(related_task, related_task_params) do |task, saved|
        if saved
          render json: task
        else
          render json: task.errors.messages, status: 422
        end
      end
    else
      related_task.update_attribute(:payable, params[:related_task][:payable])
      respond_with related_task
    end
  end

  def destroy
    related_task_manager.destroy(@related_task)
    redirect_to related_tasks_path
  end

  def find
    related_tasks = DeveloperTaskSearcher.new.find(params)
    render json: related_tasks
  end

  protected

  def related_task_params
    RelatedTaskPermitter.permit(params)
  end

  def prepare_gon
    gon.related_task = @related_task.present? ? RelatedTaskPresenter.new(@related_task).to_hash : nil
    gon.projects = current_user.chief? ? Project.all : current_user.projects
    gon.statuses = RelatedTask.statuses_i18n.map{ |k,v| { id: k, name: v } }
    gon.task_types = RelatedTask.task_types_i18n.map{ |k,v| { id: k, name: v } }
  end
end
