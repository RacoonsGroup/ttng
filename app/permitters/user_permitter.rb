class UserPermitter < Permitter
  fields [ :first_name, :last_name, :birth_date, :hire_date, :fire_date, :inn, :snils, :mobile, attaches_attributes: [:id, :title, :attachment, :_destroy]]
  namespace :user
end