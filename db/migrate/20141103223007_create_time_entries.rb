class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :task, index: true, null: false
      t.text :description
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
