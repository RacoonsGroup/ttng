class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user, index: true
      t.string :url
      t.string :description, null: false
      t.text :content
      t.integer :importance, null: false, default: 5

      t.timestamps
    end
  end
end
