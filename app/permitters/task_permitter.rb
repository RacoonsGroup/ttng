class TaskPermitter < Permitter
  fields [:name, :date, :url, :description, :status, :type, :duration, :project_id]
  namespace :task
end