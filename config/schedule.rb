set :output, {error: 'log/cron_error.log', standard: 'log/cron_standard.log'}

every 1.day, at: '10:00 am' do
  rake 'attestation_day'
end

every 1.day, at: '10:05 am' do
  rake 'birth_dates'
end
