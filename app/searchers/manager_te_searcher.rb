class ManagerTESearcher < TimeEntrySearcher
  inject :current_user

  protected

  def scope
    TimeEntry.joins(:related_task).where(related_tasks: { project_id:current_user.projects })
  end
end
