require 'redis'

if Rails.env != "production"
REDIS = Redis.new(host: "52.193.60.42", port: "6379") 
else
 REDIS = Redis.new(host: ENV['REDIS_PRO'] ,port: "6379")
end
