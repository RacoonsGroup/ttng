Pinball::Container.configure do
  define_singleton :user_manager, ManagerMock
  define_singleton :customer_manager, ManagerMock
  define_singleton :project_manager, ManagerMock
end