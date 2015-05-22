class CustomerPermitter < Permitter
  fields [:name, :describe, :url, :profile, :subject, :source, :technology_list, :contact_ids => []]
  namespace :customer
end