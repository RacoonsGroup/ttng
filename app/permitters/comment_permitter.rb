class CommentPermitter < Permitter
  fields [:title, :form, :info, :password]
  namespace :comment
end