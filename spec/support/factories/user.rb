FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    position 'developer'


    trait :chief do
      position 'chief'
    end

    trait :manager do
      position 'manager'
    end

    trait :developer do
      position 'developer'
      after(:create) do |developer|
        developer.projects = [create(:project)]
      end
    end

    trait :nobody do
      position 'nobody'
    end

    trait :hr do
      position 'hr'
    end

    trait :buh do
      position 'buh'
    end

    trait :saler do
      position 'saler'
    end

    trait :teamleader do
      position 'teamleader'
    end

    trait :customer do
      position 'customer'
    end

    trait :freelancer do
      position 'freelancer'
    end

    trait :invalid do
      email nil
    end
  end
end
