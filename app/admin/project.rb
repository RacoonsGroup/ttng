ActiveAdmin.register Project do
  permit_params :customer_id, :name, :rate, :description, :pivotal_id
end
