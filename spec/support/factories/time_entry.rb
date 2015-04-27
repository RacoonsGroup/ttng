FactoryGirl.define do
  factory :time_entry do
    related_task
    duration 10
    date Date.today
  end
end