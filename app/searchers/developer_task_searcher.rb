class DeveloperTaskSearcher < TaskSearcher
  inject :current_user

  protected

  def scope
    current_user.tasks
  end
end