set :stage, :production

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, "master"

role :app, %w{ubuntu@52.39.145.111}
role :web, %w{ubuntu@52.39.145.111}
role :db,  %w{ubuntu@52.39.145.111}

load File.expand_path('../../secrets_deploy.rb', __FILE__)

set :default_env, {
  database_url:  "postgresql://#{fetch(:dbuser)}:#{fetch(:dbpassword)}@#{fetch(:dbhost)}/#{fetch(:dbname)}"
}

set :ssh_options, {
  keys: %w(~/.ssh/funnel_key.pem),
  forward_agent: true,
#  auth_methods: %w(password)
}
