class ContactPermitter < Permitter
  fields [:first_name, :describe, :middle_name, :last_name, :mobile, :skype, :email, :customer_id]
  namespace :contact
end
