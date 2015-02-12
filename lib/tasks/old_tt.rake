namespace :old_tt do
  desc "TODO"
  task migrate_old_tt: :environment do
    data = YAML.load_file("#{Rails.root}/data.yml")
    Project.create!(name: "Empty Project",
                    customer: Customer.create(name: "Empty Customer"),
                    description: "empty",
                    rate: 0
    )
    users_migrate(data["users"])
    projects_migrate(data["projects"])
    tasks_migrate(data["time_entries"])
  end
end

def users_migrate(data)
  cols = data["columns"]
  users = data["records"]
  users.each do |user|
    user_h = {}
    user.each_with_index {|value, index| user_h.merge!(Hash[cols[index], value])}

    User.create!(id: user_h["id"],
                email: user_h["email"],
                password: "password",
                first_name: user_h["name"].split(' ').first || 'nil',
                last_name: user_h["name"].split(' ').last || 'nil',
                birth_date: Date.current,
                hire_date: Date.current,
                position: 0)
  end
end

def projects_migrate(data)
  cols = data["columns"]
  projects = data["records"]
  projects.each do |project|
    project_h = {}
    project.each_with_index {|value, index| project_h.merge!(Hash[cols[index], value])}

    Project.create!(name: project_h["project_name"],
                    customer: Customer.create(name: project_h["project_name"]),
                    description: project_h["project_description"],
                    rate: 0
    )
  end
end

def tasks_migrate(data)
  cols = data["columns"]
  tasks = data["records"]
  tasks.each do |task|
    task_h = {}
    task.each_with_index {|value, index| task_h.merge!(Hash[cols[index], value])}

    new_task = Task.create!(name: task_h["name"],
                 user_id: task_h["user_id"],
                 project: Project.find_by_name(task_h["project"]) || Project.find_by_name("Empty Project"),
                 description: task_h["description"],
                 status: 0,
                 task_type: 0,
                 url: task_h["url"],
                 date: task_h["date"],
    )
    new_task.time_entries.create!(duration: task_h["real_time"], date: task_h["date"])
  end
end