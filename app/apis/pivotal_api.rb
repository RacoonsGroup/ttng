class PivotalApi
  inject :current_user

  attr_reader :project

  def initialize(project)
    @project = project
  end

  def project_scope
    @project_scope ||=  client.project(@project.pivotal_id)
  end

  def story(id)
    project_scope.story(id)
  end

  def stories(filter = nil)
    project_scope.stories(filter: "((state:started or state:finished) or (story_type:chore and state:accepted)) #{filter.present? ? "and #{filter}" : ''}")
  end

  def client
    @client ||= TrackerApi::Client.new(token: current_user.pivotal_token)
  end
end