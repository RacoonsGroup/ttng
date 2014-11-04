class TaskPermitter < Permitter
  fields [:name, :date, :url, :description, :status, :type, :duration, :project_id, time_entries: [:id, :date, :description, :duration]]
  namespace :task
end