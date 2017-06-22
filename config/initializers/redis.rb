require 'redis'

if Rails.env != "production"
 uri = URI.parse(ENV["REDIS_DEV"]) 
else
 uri = URI.parse(ENV["REDIS_PRO"]) 
end
REDIS = Redis.new(host: uri.host, port: uri.port)
