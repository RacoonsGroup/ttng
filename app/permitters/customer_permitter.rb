class CustomerPermitter < Permitter
  fields [:name, :describe, :url, :profile, :subject, :source]
  namespace :customer
end