# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'ranq'
set :repo_url, 'https://github.com/lefedoreichmann/vagranq.git'
set :branch, "master"
set :deploy_to, "/var/www/vagranq"
set :confitionally_migrate, true
set :linked_files, fetch(:linked_files, []).push("config/settings.yml")

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :bundle_env_variables, { nokogiri_use_system_libraries: 2 }
# ()
set :keep_releases, 5

#set :rbenv_custom_path, 'C:\Users\C0113339_2\.rbenv-win\versions\2.3.0'
set :rbenv_path, '/usr/local/rbenv/'
# ruby
set :rbenv_ruby, '2.3.0'
#
set :log_level, :debug
#C:\Users\C0113339_2\.rbenv-win\shims;C:\Users\C0113339_2\.rbenv-win\bin;

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end

  Rake::Task["deploy:check"].clear_actions
  task :check do
    #invoke "#{scm}:check" git
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
