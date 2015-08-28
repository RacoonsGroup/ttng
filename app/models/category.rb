class Category < ActiveRecord::Base
  include TheSortableTree::Scopes
  acts_as_nested_set

  has_many :wiki_pages
end
