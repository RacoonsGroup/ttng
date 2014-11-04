class TaskManager < ResourceManager::Base
  inject :current_user
  inject :time_entry_manager

  model ->{ current_user.tasks }

  before_create do |params|
    @duration = params.delete(:duration)
  end

  after_create do |task|
    time_entry_manager.create(duration: @duration)
  end
end