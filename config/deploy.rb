default_run_options[:pty] = true
set :application, "goout"
set :repository,  "git@github.com:ezhux/goout.git"
set :deploy_to, "/home/ezhux/goout"

set :domain, "go-out.lt"
set :scm, :git
set :scm_verbose, true
set :branch, 'master'
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :user, "ezhux"

#set :deploy_via, :remote_cache
set :deploy_via, :copy

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain 

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     run "#{try_sudo} touch #{File.join(current_path,'log','feed_updater.log')}"
   end
 end
