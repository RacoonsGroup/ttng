class TimeEntryPermitter < Permitter
  fields [ :date, :description, :duration, :status, :delivered_time]
  namespace :time_entry
end