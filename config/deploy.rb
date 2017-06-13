# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'ranq'
set :repo_url, 'https://github.com/lefedoreichmann/vagranq.git'
set :branch, "master"
set :deploy_to, "/var/www/vagranq"
set :confitionally_migrate, true
set :linked_files, fetch(:linked_files, []).push("config/settings.yml")

set :default_env, {
    path: "$PATH",
    rbenv_root: "/home/ec2-user/.rbenv",
    AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
    AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY']
}

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :bundle_env_variables, { nokogiri_use_system_libraries: 2 }
# ()
set :keep_releases, 5

# ruby
set :rbenv_ruby, '2.3.0'
#
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
      #invoke 'nginx:restart'
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
  
  require 'yaml'

  desc "Backup the remote production database"
  task :backup do
   application ="ranq"
   filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
   file = "/tmp/#{filename}"
   #execute :orback , on_rollback { delete file }
   db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), 'database.yml'))).result)['production']
   on roles :all do
  
    execute :mysqldump, "-u #{db['username']} --password=#{db['password']} #{db['database']} | bzip2 -c > #{file}"  do |ch, stream, data|
     puts data
    end
   end
   backup_dir = File.dirname(__FILE__) + "/../backups/"
   `mkdir -p #{backup_dir}` unless File.exists?(backup_dir)
   gets file, "#{backup_dir}/#{filename}"
   on roles :all do
    execute :rm, "#{file}"
   end
  end

  desc "Backup the database before running migrations"
  #after :check, :backup 
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
