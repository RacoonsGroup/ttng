FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    subject 'indiv'
    profile 'start_up'
    describe { Faker::Lorem.sentence }
    source { Faker::Lorem.word }

    trait :invalid_customer do
      name nil
      subject nil
    end
  end
end