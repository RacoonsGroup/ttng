class CreateAttaches < ActiveRecord::Migration
  def change
    create_table :attaches do |t|
      t.string :title
      t.string :attachment
      t.references :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :attaches, :comments
  end
end
