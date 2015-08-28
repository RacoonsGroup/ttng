class AddCategoryIdToWikiPages < ActiveRecord::Migration
  def change
    add_column :wiki_pages, :category_id, :integer
  end
end
