class RelatedTaskManager < ResourceManager::Base
  inject :current_user
  inject :time_entry_manager

  model ->{ current_user.related_tasks }

  before_create do |params|
    @duration = params.delete(:duration)
  end

  after_create do |related_task|
    time_entry_manager.create(related_task, duration: @duration, date: related_task.date)
  end

  before_update do |_, params|
    @time_entries = params.delete(:time_entries) || []
  end

  after_update do |item|
    ids = @time_entries.map{ |te| te[:id] }
    if ids.any?
      item.time_entries.where('id NOT IN (?)', ids).destroy_all
    else
      item.time_entries.destroy_all
    end

    @time_entries.each do |te|
      item.time_entries.find(te[:id]).update_attributes(te)
    end
  end
end