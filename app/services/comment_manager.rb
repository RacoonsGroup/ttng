class CommentManager < ResourceManager::Base
  model ->{ @project.comments }

  before_create do |params|
    encrypt_info(params)
  end

  before_update do |info, params|
    encrypt_info(params)
  end

  def initialize(project)
    @project = project
  end

  private

  def encrypt_info(params)
    params[:encrypted] = params[:password].present?
    if params[:encrypted]
      params[:info] = params[:info].encrypt(:symmetric, :password => params[:password])
    end
  end
end