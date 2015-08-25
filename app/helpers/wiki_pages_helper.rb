module WikiPagesHelper
  acts_as_wiki_pages_helper

  def categories
    Category.nested_set.select('id, name, parent_id').all
  end
end
