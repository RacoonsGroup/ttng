Pinball::Container.clear

Pinball::Container.configure do
  define_singleton :user_manager, ManagerMock
  define_singleton :customer_manager, ManagerMock
  define_singleton :project_manager, ManagerMock
  define_singleton :related_task_manager, ManagerMock
  define_singleton :time_entry_manager, ManagerMock

  define_singleton :article_manager, ManagerMock
  define_singleton :day_manager, ManagerMock

  define_singleton :related_task_searcher, RelatedTaskSearcherMock
  define_singleton :project_info_manager, ManagerMock
  define_singleton :google_exporter, Mock
  define_singleton :pivotal_api, PivotalApiMock


  define :google_drive do
    GoogleDriveMock
  end

  define :current_user do
    Thread.current[:current_user]
  end
end