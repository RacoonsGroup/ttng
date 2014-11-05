class TaskPermitter < Permitter
  fields [:name, :date, :url, :description, :status, :task_type, :duration, :project_id, time_entries: [:id, :date, :description, :duration]]
  namespace :task
end