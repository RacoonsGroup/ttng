set :output, "#{path}/log/cron.log"

every 1.day, at: '18:00 am' do
  runner "RemindersController.attestation_day"
end

every 1.day, at: '18:05 am' do
  runner "RemindersController.birth_dates"
end
