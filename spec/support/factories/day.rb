FactoryGirl.define do
  factory :day do
    date Date.today
    holiday false
    reason 'Reason'

    trait :holiday do
      holiday true
    end
  end
end