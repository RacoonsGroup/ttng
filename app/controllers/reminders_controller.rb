class RemindersController < ApplicationController
  def self.attestation_day
    User.available.each do |user|
      if (Date.today.mjd - user.hire_date.mjd) - 60 == 0 || (Date.today.mjd - user.hire_date.mjd) % 180 == 0
        NotifMailer.attestation(user).deliver_now!
      end
    end
  end

  def self.birth_dates
    User.available.each do |user|
      if user.birth_date.strftime("%m") == (Date.today + 10).strftime("%m") && user.birth_date.strftime("%d") == (Date.today + 10).strftime("%d")
        NotifMailer.birth_dates(user).deliver_now!
      end
    end
  end
end
