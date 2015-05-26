ActiveAdmin.register Contact do
  permit_params :first_name, :describe, :middle_name, :last_name, :mobile, :skype, :email, :customer_id
end
