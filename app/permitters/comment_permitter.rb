class CommentPermitter < Permitter
  fields [:title, :info, :password]
  namespace :comment
end