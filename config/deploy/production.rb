# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
set :branch, 'mainstream'
#set :branch, 'master'
set :stage, :production
set :rails_env, 'production'
set :default_env, {
    path: "$PATH",
    rbenv_root: "/home/ec2-user/.rbenv",
    AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
    AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY'],
    MYSQL_DATABASE_PASS: ENV['MYSQL_DATABASE_PASS'],
    REDIS_PRO: ENV['REDIS_PRO']

}
#server 'ranq-media.com', user: 'ranq', roles: %w{app db web}, my_property: :my_value
server '52.193.60.42', user: 'ec2-user', roles: %w{app db web},password: "ranq"
#server '13.113.15.218', user: 'ec2-user', roles: %w{app db web},password: "ranq"
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}

set :ssh_options, {
	#keys:[File.expand_path('C:\.ssh\keypareRanq.pem')]
	keys:[File.expand_path('/home/vagrant/.ssh/keypareRanq.pem')]
}
