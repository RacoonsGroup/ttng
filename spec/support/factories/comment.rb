FactoryGirl.define do
  factory :comment do
    project
    title 'Title'
    info 'info'
    encrypted false

    trait :general do
      form 'general'
    end

    trait :commercial do
      form 'commercial'
    end

    trait :developer do
      form 'developer'
    end
  end
end