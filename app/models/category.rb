class Category < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes

  has_many :wiki_pages
end
