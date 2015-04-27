Pinball::Container.configure do
  define_singleton :user_manager, Admin::UserManager
  define_singleton :customer_manager, Admin::CustomerManager
  define_singleton :project_manager, Admin::ProjectManager
  define_singleton :day_manager, Admin::DayManager


  define_singleton :related_task_manager, RelatedTaskManager


  define_singleton :time_entry_manager, TimeEntryManager
  define_singleton :article_manager, ArticleManager
  define_singleton :google_exporter, GoogleExporter
  define :google_drive do
    GoogleDrive
  end



  define :project_info_manager do
    Admin::ProjectInfoManager.new(@project)
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


end