require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, ''
set :deploy_to, ''
set :repository, ''
set :branch, 'master'

set :user, 'deployer'
set :port, '2001'
set :forward_agent, true
set :term_mode, nil
set :ssh_options, '-A'

task :environment do
  invoke :'rvm:use[ruby-2.1.3@demset]'
end

set :rvm_path, '/usr/local/rvm/scripts/rvm'
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

task :restart do
  queue 'sudo restart project'
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
    invoke :restart
  end
end



