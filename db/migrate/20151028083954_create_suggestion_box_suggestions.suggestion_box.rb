# This migration comes from suggestion_box (originally 20150828061911)
class CreateSuggestionBoxSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestion_box_suggestions do |t|
      t.string :title
      t.text :text
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
