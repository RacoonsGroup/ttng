class CommentPermitter < Permitter
  fields [:title, :form, :info, :password, attaches_attributes: [:id, :title, :attachment, :_destroy]]
  namespace :comment
end