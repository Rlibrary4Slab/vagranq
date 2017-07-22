require 'redis'

if Rails.env != "production"
  if ENV['REDIS_PRO'] != "52.193.60.42"

   REDIS = Redis.new(host: "localhost", port: "6379") 
  else
   REDIS = Redis.new(host: ENV['REDIS_PRO'] ,port: "6379")
  end
else
 REDIS = Redis.new(host: ENV['REDIS_PRO'] ,port: "6379")
end
