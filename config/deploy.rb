require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, '78.46.73.243'
set :deploy_to, '/home/deployer/ttng'
set :repository, 'git@github.com:RacoonsGroup/ttng.git'
set :branch, 'master'

set :user, 'deployer'
set :port, '2004'
set :forward_agent, true
set :term_mode, nil
set :ssh_options, '-A'

task :environment do
  invoke :'rvm:use[ruby-2.1.5@ttng]'
end

set :shared_paths, ['config/database.yml', 'config/secrets.yml','log', 'tmp', 'public']

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/public"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/public"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    invoke :'unicorn:restart'
  end
end

namespace :unicorn do
  set :deploy_to, '/home/deployer/ttng'
  set :unicorn_pid, "#{deploy_to}/#{current_path}/tmp/pids/unicorn.pid"
  set :unicorn_conf, "#{deploy_to}/#{current_path}/config/unicorn.rb"

  desc "Start unicorn"
  task :start => :environment do
    queue 'echo "Start Unicorn"'
    queue! "cd #{deploy_to}/#{current_path} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  desc "Stop unicorn"
  task :stop => :environment do
    queue 'echo "Stop Unicorn"'
    queue! %{cd #{deploy_to}/#{current_path} && 
      if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; 
        then kill -QUIT `cat #{unicorn_pid}`; 
      fi}
  end

  desc "Restart unicorn"
  task :restart => :environment do
    queue 'echo "Restart Unicorn"'
    queue! %{cd #{deploy_to}/#{current_path} &&
      if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ];
        then kill -USR2 `cat #{unicorn_pid}`;
      else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D;
      fi}
  end
end
