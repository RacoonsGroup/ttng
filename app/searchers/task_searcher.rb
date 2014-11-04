class TaskSearcher
  inject :current_user

  def find(params)
    tasks = current_user.tasks
    tasks = filter_by_name(tasks, params[:name]) if params[:name].present?
    tasks = filter_by_project(tasks, params[:project_id]) if params[:project_id].present?
    tasks
  end

  private

  def filter_by_name(tasks, name)
    tasks.where('name ILIKE ?', "%#{name}%")
  end

  def filter_by_project(tasks, project_id)
    tasks.where(project_id: project_id)
  end
end