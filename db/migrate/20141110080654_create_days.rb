class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :date, index: true
      t.boolean :holiday, null: false, default: true, index: true
      t.string :reason
      t.timestamps
    end
  end
end
