class CustomerPermitter < Permitter
  fields [:name, :describe, :url, :type, :subject, :source]
  namespace :customer
end