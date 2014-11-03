class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, null: false
      t.references :project, index: true, null: false
      t.string :name, null: false
      t.text :description
      t.string :url
      t.boolean :payable, null: false, default: false
      t.integer :status, null: false
      t.integer :type, null: false

      t.timestamps
    end
  end
end
