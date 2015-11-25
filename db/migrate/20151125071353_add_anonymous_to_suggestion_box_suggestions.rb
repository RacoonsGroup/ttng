class AddAnonymousToSuggestionBoxSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestion_box_suggestions, :anonymous, :boolean
  end
end
