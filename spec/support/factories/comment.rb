FactoryGirl.define do
  factory :comment do
    project
    title 'Title'
    info 'info'
    encrypted false
  end
end