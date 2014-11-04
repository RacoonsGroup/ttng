class TimeEntryPresenter < Presenter
  include ApplicationHelper

  expose_all

  def to_hash
    {
        id: id,
        description: description,
        duration: duration,
        date: ll(date)
    }
  end
end