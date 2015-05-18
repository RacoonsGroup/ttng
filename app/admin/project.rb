ActiveAdmin.register Project do
  permit_params :customer_id, :name, :rate, :description, :pivotal_id, user_ids: []

  form do |f|
    f.inputs multipart: true do
      f.input :name
      f.input :customer
      f.input :description
      f.input :rate
      f.input :pivotal_id
      f.input :users, as: :check_boxes
    end
    f.actions
  end
end
