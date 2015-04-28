FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    subject { rand(0..1) }
    profile { rand(0..2) }
    describe { Faker::Name.name }
    source { Faker::Name.name }
  end
end