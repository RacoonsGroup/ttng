FactoryGirl.define do
  factory :time_entry do
    task
    duration 10
    date Date.today
  end
end