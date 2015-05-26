class AddDeliveredTimeToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :delivered_time, :float
  end
end
