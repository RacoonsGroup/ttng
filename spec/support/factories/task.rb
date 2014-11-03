FactoryGirl.define do
  factory :task do
    name { Faker::Name.first_name }

    project
    user
    date { Date.today }

  end
end