class TaskSearcher
  inject :current_user

  def find(params)
    tasks = current_user.tasks
    tasks = filter_by_name(tasks, params[:name]) if params[:name].present?
    tasks = filter_by_projects(tasks, [params[:project_id]]) if params[:project_id].present?
    tasks
  end

  def find_by_form(search_form)
    tasks = current_user.tasks
    tasks = filter_by_projects(tasks, search_form.projects.reject(&:empty?).map(&:to_i)) if search_form.projects.present?
    tasks = filter_by_from(tasks, search_form.from) if search_form.from.present?
    tasks = filter_by_to(tasks, search_form.to) if search_form.to.present?
    tasks = filter_by_payable(tasks, search_form.payable) if search_form.payable.present?
    tasks
  end

  def between(from, to)
    tasks = current_user.tasks
    tasks = filter_by_from(tasks, from)
    filter_by_to(tasks, to)
  end

  private

  def filter_by_name(tasks, name)
    tasks.where('name ILIKE ?', "%#{name}%")
  end

  def filter_by_projects(tasks, project_ids)
    if project_ids.any?
      tasks.where('project_id iN (?)', project_ids)
    else
      tasks
    end
  end

  def filter_by_from(tasks, from)
    tasks.where('date >= ?', from)
  end

  def filter_by_to(tasks, to)
    tasks.where('date <= ?', to)
  end

  def filter_by_payable(tasks, payable)
    return tasks if payable == 'all'
    tasks = payable == 'nil' ?  tasks.where(payable: nil) : tasks.where(payable: payable)
  end
end