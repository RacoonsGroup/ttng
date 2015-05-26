FactoryGirl.define do
  factory :contact do
    customer
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobile { Faker::PhoneNumber.cell_phone }
    skype { Faker::Internet.user_name }
    email { Faker::Internet.email }
    describe { Faker::Lorem.sentence }
  end
end