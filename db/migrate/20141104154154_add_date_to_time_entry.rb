class AddDateToTimeEntry < ActiveRecord::Migration
  def change
    add_column :time_entries, :date, :date, null: false
  end
end
