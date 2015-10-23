namespace :whenever do
  name = lambda { whenever_name || "#{domain}_#{rails_env}" }

  desc "Update crontab"
  task :update => :environment do
    queue %{
      echo "-----> Update crontab for #{name.call}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; #{bundle_bin} exec whenever --update-crontab #{name.call} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end
end
