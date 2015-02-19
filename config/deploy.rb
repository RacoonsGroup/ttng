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

set :rvm_path, '/home/deployer/.rvm/bin/rvm'
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



