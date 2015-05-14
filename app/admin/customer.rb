ActiveAdmin.register Customer do
  permit_params :name, :describe, :url, :profile, :subject, :source, :technology_list

  form do |f|
    f.inputs do
      f.input :name
      f.input :source
      f.input :url
      f.input :describe
      f.input :subject, collection: Customer.subjects.keys, as: :select
      f.input :profile, collection: Customer.profiles.keys, as: :select
    end
    f.inputs do
      f.action :submit
    end
  end
end
