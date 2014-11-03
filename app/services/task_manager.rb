class TaskManager < ResourceManager::Base
  inject :current_user

  model ->{ current_user.tasks }
end