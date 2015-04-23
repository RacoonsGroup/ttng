class Admin::AdminController < AuthenticatedController
  before_filter :authenticate_admin!
  layout 'admin'

  def authenticate_admin!
    raise CanCan::AccessDenied.new unless current_user.admin?
  end
end
