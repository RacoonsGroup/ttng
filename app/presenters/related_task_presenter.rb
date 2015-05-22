class RelatedTaskPresenter < Presenter
  expose_all

  def to_hash
    {
      id: id,
      name: subject,
      date: date,
      project: project,
      status: {id: status, name: status_i18n},
      task_type: {id: task_type, name: task_type_i18n},
      url: url,
      description: description,
      time_entries: TimeEntryPresenter.map(time_entries),
      duration: real_time
    }
  end

  def to_xlsx_row
    [ name, real_time, l(date), "#{user.first_name} #{user.last_name}", url, description ]
  end

  private

  def project
    subject.project.present? ? ProjectPresenter.new(subject.project).to_hash : {}
  end
end