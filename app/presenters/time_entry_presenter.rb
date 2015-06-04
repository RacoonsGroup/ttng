class TimeEntryPresenter < Presenter
  include ApplicationHelper

  expose_all

  def to_xlsx_row
    [ related_task.name, duration, l(date), "#{user.first_name} #{user.last_name}", related_task.url, description ]
  end

  def to_hash
    {
        id: id,
        description: description,
        duration: duration,
        date: ll(date)
    }
  end
end