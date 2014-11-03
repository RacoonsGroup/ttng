class AddDefaultsToTaskEnums < ActiveRecord::Migration
  def change
    change_column :tasks, :task_type, :integer, null: false, default: 0
    change_column :tasks, :status, :integer, null: false, default: 0
  end
end
