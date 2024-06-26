set :application, 'pulso_unab'
set :repo_url, "git@github.com:artool-spa/pulso-unab.git"
set :rvm_ruby_version, "2.7.2@#{fetch(:application)}"
set :rvm_ruby, '2.7.2'
set :keep_releases, 3

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/master.key', 'config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :bundle_binstubs, nil

set :passenger_restart_with_touch, true
