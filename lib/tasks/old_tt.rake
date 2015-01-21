namespace :old_tt do
  desc "TODO"
  task migrate_old_tt: :environment do
    data = YAML.load('data.yml')
    users_migrate(data["users"])
  end
end

def users_migrate(data)
  cols = data["columns"]
  users = data["records"]
  users.each do |user|
    user_h = {}
    user.each_with_index do |index, value|
      user_h << Hash[cols[index], value]
    end
    debugger
    user_h
  end
end