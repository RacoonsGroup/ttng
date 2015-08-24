class CategoryPermitter < Permitter
  fields [:name, :parent_id, :lft, :rgt, :depth, :children_count]
  namespace :category
end
