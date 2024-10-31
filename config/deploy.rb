# config valid for current version and patch releases of Capistrano
lock("~> 3.19.1")

set(:application, "app-cap")
set(:repo_url, "git@github.com:codev009/app-cap.git")

# or :system, or :fullstaq (for Fullstaq Ruby), depends on your rbenv setup
set(:rbenv_type, :system)
set(:rbenv_ruby, "3.3.5")
# Default branch is :master
set(:branch, "main")
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set(:deploy_to, "/var/www/app-cap")

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
namespace(:deploy) do
  desc("Run seed")
  task(:seed) do
    on(roles(:all)) do
      within(current_path) do
        execute(:bundle, :exec, "rails", "db:seed", "RAILS_ENV=production")
      end
    end
  end

  after(:migrating, :seed)
end
