class Admin::ProjectInfoManager < ResourceManager::Base
  model ->{ @project.project_infos }

  def initialize(project)
    @project = project
  end
end