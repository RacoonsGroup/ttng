ActiveAdmin.register Comment, as: "ProjectComment" do
  permit_params :project_id, :title, :form, :info, :password

  form do |f|
    f.inputs do
      f.input :project
      f.input :title
      f.input :info
      f.input :form, collection: Comment.forms.keys, as: :select
    end
    f.inputs do
      f.action :submit
    end
  end
end
