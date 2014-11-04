class TimeEntryPermitter < Permitter
  fields [ :date, :description, :duration, :status]
  namespace :time_entry
end