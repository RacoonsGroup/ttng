class AddTitleToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string, null: false
  end
end
