require 'redis'

if Rails.env != "production"
# uri = URI.parse("localhost:6379")
  uri = URI.parse(ENV["REDIS_DEV"])
 REDIS = Redis.new(host: uri.host, port: uri.port)
else
# uri = URI.parse("localhost:6379")
 uri = URI.parse(ENV["REDIS_PRO"]) 
 REDIS = Redis.new(host: ENV['REDIS_PRO'] ,port: "6379")
end
