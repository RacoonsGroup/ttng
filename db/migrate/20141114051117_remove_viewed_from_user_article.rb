class RemoveViewedFromUserArticle < ActiveRecord::Migration
  def change
    remove_column :user_articles, :viewed
  end
end
