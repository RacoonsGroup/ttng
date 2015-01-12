class TaskSearcher

  def find(params)
    tasks = scope
    tasks = filter_by_name(tasks, params[:name]) if params[:name].present?
    tasks = filter_by_projects(tasks, [params[:project_id]]) if params[:project_id].present?
    tasks
  end

  def find_by_form(search_form)
    tasks = scope
    search_form.fields.map(&:name).each do |field|
      tasks = send("filter_by_#{field}", tasks, search_form.attributes[field]) if search_form.attributes[field].present?
    end
    tasks
  end

  def between(from, to)
    tasks = scope
    tasks = filter_by_from(tasks, from)
    filter_by_to(tasks, to)
  end

  private

  def filter_by_name(tasks, name)
    tasks.where('name ILIKE ?', "%#{name}%")
  end

  def filter_by_projects(tasks, projects)
    project_ids = projects.reject(&:empty?).map(&:to_i)
    if project_ids.any?
      tasks.where('project_id iN (?)', project_ids)
    else
      tasks
    end
  end

  def filter_by_developers(tasks, developers)
    developer_ids = developers.reject(&:empty?).map(&:to_i)
    if developer_ids.any?
      tasks.where('user_id iN (?)', developer_ids)
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

  protected

  def scope
    Task.all
  end
end