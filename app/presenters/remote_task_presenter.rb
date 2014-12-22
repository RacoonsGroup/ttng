class RemoteTaskPresenter < Presenter
  expose_all

  def to_hash
    {
        id: id,
        name: name,
        description: description,
        url: url,
        remote: true,
        type: story_type,
        status: map_status
    }
  end

  def map_status
    current_state == 'started' ? 'in_progress' : 'finished'
  end
end