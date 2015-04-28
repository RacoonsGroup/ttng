class ContactPermitter < Permitter
  fields [:first_name, :describe, :middle_name, :last_name, :mobile, :skype, :email]
  namespace :contact
end
