class Category < ActiveRecord::Base
  acts_as_nested_set

  has_many :wiki_pages
end
