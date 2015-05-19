class ChangeDurationTypeInTimeEntries < ActiveRecord::Migration
  def change
    change_column :time_entries, :duration,  :float
  end
end
