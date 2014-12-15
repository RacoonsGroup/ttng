class DayPermitter < Permitter
  fields [:date, :holiday, :reason]
  namespace :day
end