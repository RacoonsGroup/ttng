class NotifMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/log'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def project_edit(users, project)
    @project = project
    @users = []
    users.each { |user| @users << User.find(user[:user][:id]) }
    @users -= @project.users
    emails = @users.collect(&:email).join(",")
    mail(to: emails, subject: "You were added in project #{@project.name}") unless emails.empty?
  end
end
