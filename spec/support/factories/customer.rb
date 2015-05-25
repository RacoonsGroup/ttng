FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    subject 'phizik'
    profile 'start_up'
    describe { Faker::Lorem.sentence }
    source { Faker::Lorem.word }
  end
end