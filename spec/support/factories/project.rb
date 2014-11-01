FactoryGirl.define do
  factory :project do
    customer
    name { Faker::Name.name }
    rate 10000
  end
end