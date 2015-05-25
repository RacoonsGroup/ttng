class DeveloperTESearcher < TimeEntrySearcher
  inject :current_user

  protected

  def scope
    TimeEntry.joins(:related_task).where(related_tasks: { user_id: current_user } )
  end
end
