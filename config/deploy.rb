# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'ranq'
set :repo_url, 'https://github.com/lefedoreichmann/ranqdep.git'
set :branch, "master"
set :deploy_to, "/var/www/ranqdeployer"

set :linked_files, fetch(:linked_files, []).push("config/settings.yml")

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }
# 保持するバージョンの個数(※後述)
set :keep_releases, 5

#set :rbenv_custom_path, 'C:\Users\C0113339_2\.rbenv-win\versions\2.3.0'
set :rbenv_path, '/usr/local/rbenv/'
# rubyのバージョン
set :rbenv_ruby, '2.3.0'
#出力するログのレベル。
set :log_level, :debug
#C:\Users\C0113339_2\.rbenv-win\shims;C:\Users\C0113339_2\.rbenv-win\bin;

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  Rake::Task["deploy:check"].clear_actions
  task :check do
    #invoke "#{scm}:check" gitを使わないので不要
    invoke 'deploy:check:directories'
    invoke 'deploy:check:linked_dirs'
    invoke 'deploy:check:make_linked_dirs'
    invoke 'deploy:check:linked_files'
  end
  
  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
