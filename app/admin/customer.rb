ActiveAdmin.register Customer do
  permit_params :name, :describe, :url, :profile, :subject, :source, :technology_list
end
