FactoryGirl.define do
  factory :related_task do
    name { Faker::Name.first_name }
    project
    user
    date { Date.today }
  end
end