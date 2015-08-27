set :output, "#{path}/log/cron.log"

# every 1.day, at: '10:00 am' do
#   runner "RemindersController.attestation_day"
# end

# every 1.day, at: '10:05 am' do
#   runner "RemindersController.birth_dates"
# end

every :minute do
  runner "RemindersController.attestation_day"
end

every :minute do
  runner "RemindersController.birth_dates"
end
