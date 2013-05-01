require 'bundler/capistrano'
require 'rvm/capistrano'

before 'deploy:setup', 'rvm:install_rvm'
#after 'rvm:install_rvm', 'rvm:enable_auto_libs'
before 'deploy:setup', 'rvm:install_ruby'

namespace :rvm do
	task :enable_auto_libs do
		run 'rvm autolibs enable'
	end
end

set :rvm_ruby_string, 'ruby-2.0.0-p0'

set :application, "roomie"
set :deploy_to, "/home/ubuntu/#{application}"

set :user, 'ubuntu'
set :use_sudo, false
ssh_options[:keys] = [File.join('~/.ssh/amazon_ec2_project_2.pem')] # Key for Everett's ec2 instance

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :scm, :git
set :repository, 'git@github.com:railsCloudGroup/project-470'
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true

server '54.235.87.183', # Everett's ec2 server
 	:app,
 	:web,
 	:db,
 	:primary => true
server '54.225.104.65',
  :app, :web

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 2
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :rails_env, 'production'
set :passenger_port, 3000
set :startcmd, lambda { "cd #{current_path} && bundle exec passenger start -d -p #{passenger_port} -e #{rails_env}  --pid-file=#{current_path}/tmp/pids/passenger.#{passenger_port}.pid  #{current_path}" }
set :stopcmd, lambda { "cd #{current_path} && bundle exec passenger stop -p #{passenger_port}" }

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
		run("#{startcmd}")
	end
  task :stop do
		run("#{stopcmd}")
 	end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code', 'deploy:migrate'
