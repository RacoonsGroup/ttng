class RenameTasksToRelatedTasks < ActiveRecord::Migration
  def change
    rename_table :tasks, :related_tasks
    rename_column :time_entries, :task_id, :related_task_id
  end
end
