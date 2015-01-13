Pinball::Container.clear

Pinball::Container.configure do
  define_singleton :user_manager, ManagerMock
  define_singleton :customer_manager, ManagerMock
  define_singleton :project_manager, ManagerMock
  define_singleton :task_manager, ManagerMock
  define_singleton :time_entry_manager, ManagerMock

  define_singleton :article_manager, ManagerMock
  define_singleton :day_manager, ManagerMock

  define_singleton :task_searcher, TaskSearcherMock
  define_singleton :project_info_manager, ManagerMock
  define_singleton :google_exporter, Mock
  define :google_drive do
    GoogleDriveMock
  end

  define :current_user do
    Thread.current[:current_user]
  end
end