class CreateUserArticles < ActiveRecord::Migration
  def change
    create_table :user_articles do |t|
      t.references :user
      t.references :article
      t.boolean :viewed, null: false, default: true
      t.timestamps
    end
  end
end
