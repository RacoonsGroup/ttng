ActiveAdmin.register Article do
  permit_params :user_id, :title, :description, :url, :content, :importance
end
