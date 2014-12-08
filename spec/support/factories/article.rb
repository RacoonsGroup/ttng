FactoryGirl.define do
  factory :article do
    user
    url { Faker::Internet::url }
    description 'Article'
    title 'Article'
  end
end