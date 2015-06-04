class RelatedTaskPermitter < Permitter
  fields [:name, :date, :url, :description, :status, :task_type, :duration, :project_id, :payable, time_entries: [:id, :date, :description, :duration]]
  namespace :related_task
end