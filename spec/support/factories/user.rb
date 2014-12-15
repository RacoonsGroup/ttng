FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      position 'admin'
    end

    trait :manager do
      position 'manager'
    end

    trait :developer do
      position 'developer'
    end

    trait :invalid do
      email nil
    end
  end
end