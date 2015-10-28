# This migration comes from suggestion_box (originally 20151028085923)
class AddAuthorIdToSuggestionBoxSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestion_box_suggestions, :author_id, :integer
  end
end
