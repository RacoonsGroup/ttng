Pinball::Container.configure do
  define_singleton :user_manager, Admin::UserManager
  define_singleton :customer_manager, Admin::CustomerManager
  define_singleton :project_manager, Admin::ProjectManager
end