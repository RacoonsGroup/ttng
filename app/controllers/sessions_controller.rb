class SessionsController < ApplicationController
  layout false

  def new
  end

  def create
    @auth = request.env['omniauth.auth']['credentials']
    current_user.update_attributes(google_token: @auth['token'])
    redirect_to to_google_drive_admin_project_path(session[:export_project_id])
  end

end