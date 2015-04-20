class ManagerTaskSearcher < TaskSearcher
  inject :current_user

  protected

  def scope
    Task.where(project: current_user.projects)
  end
end
