# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

ENV['RAILS_ENV'] ||= 'production'
set :environment, ENV['RAILS_ENV']

# require "../lib/tasks/tasks.rb"
# require File.expand_path('lib/tasks/tasks.rb')
 require File.expand_path(File.dirname(__FILE__) + "/environment.rb")
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#  set :output, "/RanQ/Production/wheneverlog.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

#every 1.minute do
every 1.day, at: '0:01 am' do
  runner "Batch.yesterday_view_count"
  runner "Batch.delete_old_notifications"
#  runner "Batch.hello"
end

#every 1.minute do
every 1.day, at: '0:05 am' do
  runner "Batch.user_ranking_point"
#  runner "Batch.hello"
end

# Learn more: http://github.com/javan/whenever
