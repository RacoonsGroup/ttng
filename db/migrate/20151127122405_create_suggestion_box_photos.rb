class CreateSuggestionBoxPhotos < ActiveRecord::Migration
  def change
    create_table :suggestion_box_photos do |t|
      t.string :image, null: false
      t.integer :suggestion_id, null: false

      t.timestamps null: false
    end
  end
end
