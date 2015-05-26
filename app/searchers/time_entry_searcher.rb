class TimeEntrySearcher

  def find(params)
    time_entries = scope
  end

  def find_by_form(search_form)
    time_entries = scope
    search_form.fields.map(&:name).each do |field|
      time_entries = send("filter_by_#{field}", time_entries, search_form.attributes[field]) if search_form.attributes[field].present?
    end
    time_entries
  end

  def between(from, to)
    time_entries = scope
    time_entries = filter_by_from(time_entries, from)
    filter_by_to(time_entries, to)
  end

  private

  def filter_by_name(time_entries, name)
    time_entries.where('name ILIKE ?', "%#{name}%")
  end

  def filter_by_projects(time_entries, projects)
    project_ids = projects.select(&:present?).map(&:to_i)
    if project_ids.any?
      time_entries.joins(:related_task).where(related_tasks: { project_id: project_ids } )
    else
      time_entries
    end
  end

  def filter_by_developers(time_entries, developers)
    developer_ids = developers.select(&:present?).map(&:to_i)
    if developer_ids.any?
      time_entries.joins(:related_task).where(related_tasks: { user_id: developer_ids } )
    else
      time_entries
    end
  end

  #date вызывает ошибку PG::AmbiguousColumn column reference "date" is ambiguous
  #TODO подумать как отрефакторить
  def filter_by_from(time_entries, from)
    time_entries.where('time_entries.date >= ?', from)
  end

  def filter_by_to(time_entries, to)
    time_entries.where('time_entries.date <= ?', to)
  end

  def filter_by_payable(time_entries, payable)
    return time_entries if payable == 'all'
    time_entries = if payable == 'nil' 
      time_entries.joins(:related_task).where(related_tasks: { payable: nil } )
    else
      time_entries.joins(:related_task).where(related_tasks: { payable: payable } )
    end
  end

  protected

  def scope
    TimeEntry.all
  end
end