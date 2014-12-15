FactoryGirl.define do
  factory :project_info do
    project
    title 'Title'
    info 'info'
    encrypted false
  end
end