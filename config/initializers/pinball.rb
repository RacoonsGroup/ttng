Pinball::Container.configure do
  define_singleton :project_manager, ProjectManager
  define_singleton :related_task_manager, RelatedTaskManager
  define_singleton :customer_manager, CustomerManager
  define_singleton :contact_manager, ContactManager
  define_singleton :time_entry_manager, TimeEntryManager
  define_singleton :article_manager, ArticleManager
  define_singleton :user_manager, UserManager
  define_singleton :google_exporter, GoogleExporter
  define :google_drive do
    GoogleDrive
  end



  define :comment_manager do
    CommentManager.new(@project)
  end

  define :pivotal_api do
    PivotalApi.new(@project)
  end

  define :current_user do
    Thread.current[:current_user]
  end

  define :related_task_searcher do
    if current_user.developer?
      DeveloperTaskSearcher.new
    elsif current_user.manager?
      ManagerTaskSearcher.new
    else
      RelatedTaskSearcher.new
    end
  end

  define :time_entry_searcher do
    if current_user.chief?
      TimeEntrySearcher.new
    elsif current_user.manager? || current_user.teamleader?
      ManagerTESearcher.new
    else
      DeveloperTESearcher.new
    end
  end
end
