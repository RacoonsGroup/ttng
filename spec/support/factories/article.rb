FactoryGirl.define do
  factory :article do
    user
    url { Faker::Internet::url }
    description 'Article'
    title 'Article'

    trait :invalid_article do
      description nil
      url nil
    end
  end
end