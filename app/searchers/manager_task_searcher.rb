class ManagerTaskSearcher < RelatedTaskSearcher
  inject :current_user

  protected

  def scope
    RelatedTask.where(project: current_user.projects)
  end
end
