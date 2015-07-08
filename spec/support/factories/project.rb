FactoryGirl.define do
  factory :project do
    customer
    name { Faker::Name.name }
    rate 10000

    trait :finished do
      state 5
    end
  end
end