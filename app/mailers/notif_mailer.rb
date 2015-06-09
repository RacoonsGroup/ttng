class NotifMailer < ApplicationMailer
  def project_edit(users, project)
    @project = project
    @notif_users = []
    users.each { |user| @notif_users << User.find(user[:user][:id]) unless @project.users.include?(User.find(user[:user][:id])) }
    emails = @notif_users.collect(&:email).join(",")
    mail(to: emails, subject: "You were added in project #{@project.name}") unless emails.empty?
  end

  def comment_create(comment)
    @comment = comment
    mail(to: comment.project.users.collect(&:email).join(","),
         subject: "In project #{comment.project.name} added/edited comment - #{comment.title}")
  end
end
