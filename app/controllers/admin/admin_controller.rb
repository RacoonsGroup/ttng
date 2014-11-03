class Admin::AdminController < AuthenticatedController
  before_filter :authenticate_admin!
  layout 'admin'

  def authenticate_admin!
    raise CanCan::AccessDenied.new unless current_user.admin_or_manager?
  end
end
