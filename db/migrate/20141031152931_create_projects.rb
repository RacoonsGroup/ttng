class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :customer, index: true, null: false
      t.text :description
      t.integer :rate_kopeks, null: false

      t.timestamps
    end
  end
end
