class CommentPermitter < Permitter
  fields [:title, :form, :info, :password, :user_id, attaches_attributes: [:id, :title, :attachment, :_destroy]]
  namespace :comment
end
