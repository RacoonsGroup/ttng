namespace :nobodies do
  desc 'Remove on projects users that have nobody postion'
  task remove: :environment do
    Project.find_each do |project|
      project.users.nobodies.delete_all
    end
  end
end