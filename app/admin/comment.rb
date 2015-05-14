ActiveAdmin.register Comment, as: "ProjectComment" do
  permit_params :title, :form, :info, :password
end
