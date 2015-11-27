class AddStatusToSuggestionBoxSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestion_box_suggestions, :status, :integer, default: 0
  end
end
