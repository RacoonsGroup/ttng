class DeveloperTaskSearcher < RelatedTaskSearcher
  inject :current_user

  protected

  def scope
    current_user.related_tasks
  end
end