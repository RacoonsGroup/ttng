class TimeEntryManager < ResourceManager::Base
  model TimeEntry
  def create(task, params)
    status = params.delete(:status)
    item = task.time_entries.new(params)
    saved = item.save

    if saved
      task.update_attributes(status: status)
    end

    yield(item, saved) if block_given?
  end
end