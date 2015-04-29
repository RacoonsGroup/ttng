FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    subject 'phizik'
    profile 'start_up'
    describe { Faker::Name.name }
    source { Faker::Name.name }
  end
end