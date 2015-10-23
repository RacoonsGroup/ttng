desc 'check attestation_day'
task :attestation_day => :environment do
  User.available.each do |user|
    if (Date.today.mjd - user.hire_date.mjd) - 60 == 0 || (Date.today.mjd - user.hire_date.mjd) % 180 == 0
      NotifMailer.attestation(user).deliver_now!
    end
  end
end

desc 'check birth_dates'
task :birth_dates => :environment do
  File.open("#{Rails.root}/log/cron_error.log", 'a+') { |f| f.puts("-------#{ENV["GMAIL_USER"]}------#{ENV["GMAIL_PASSWORD"]}---------") }
  User.available.each do |user|
    if user.birth_date.strftime("%m") == (Date.today + 10).strftime("%m") && user.birth_date.strftime("%d") == (Date.today + 10).strftime("%d")
      NotifMailer.birth_dates(user).deliver_now!
    end
  end
end
