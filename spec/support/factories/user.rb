FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      admin true
    end

    trait :invalid do
      email nil
    end
  end
end