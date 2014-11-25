require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :domain, '104.131.81.150'
set :deploy_to, '/var/www/taskv'
set :repository, 'git@codeplane.com:fnando/taskv-d3.git'
set :branch, 'master'
set :shared_paths, ['config/database.yml', 'log', '.env']

set :user, 'deploy'
set :forward_agent, true

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/.env"]
  queue  %[echo "-----> Be sure to edit 'shared/.env'."]
end

desc "Display routes"
task :'rake:routes' => :environment do
  queue! %[cd #{deploy_to}/#{current_path} && bundle exec rake routes]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue "touch #{deploy_to}/tmp/restart.txt"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

