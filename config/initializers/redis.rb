require 'redis'

if Rails.env != "production"
 
 REDIS = Redis.new(host: ENV['REDIS_DEV'], port: "6379")
else
 REDIS = Redis.new(host: ENV['REDIS_PRO'] ,port: "6379")
end
