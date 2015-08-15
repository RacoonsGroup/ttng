class CommonCommentPermitter < Permitter
  fields [:title, :comment, :user_id, :commentable_id, :commentable_type, :role,
           attaches_attributes: [:id, :title, :attachment, :_destroy]]
  namespace :common_comment
end
