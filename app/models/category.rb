class Category < ActiveRecord::Base
  include TheSortableTree::Scopes
  acts_as_nested_set

  has_many :wiki_pages

  def find_nested_categories
    parents = [self]
    nested = []

    until parents.empty?
      next unless (children = Category.where(parent_id: parents))

      nested << children.flatten
      parents = children.to_a
    end

    nested
  end

  def nested_categories
    find_nested_categories
  end

  def nested_articles_count
    self.find_nested_categories.inject(0) do |sum, category|
      sum + WikiPage.where(category_id: category).count
    end
  end
end
