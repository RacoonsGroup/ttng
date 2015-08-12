class CommonCommentPermitter < Permitter
  fields [:title, :comment, :user_id, :commentable_id, :commentable_type, :role]
  namespace :common_comment
end
