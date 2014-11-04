class TimeEntryPermitter < Permitter
  fields [ :date, :description, :duration, :status]
  namespace :task
end