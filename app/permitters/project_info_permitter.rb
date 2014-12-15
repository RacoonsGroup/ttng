class ProjectInfoPermitter < Permitter
  fields [:title, :info, :password]
  namespace :project_info
end