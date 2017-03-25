# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
set :branch, 'master'
set :stage, :production
set :rails_env, 'production'
#server 'ranq-media.com', user: 'ranq', roles: %w{app db web}, my_property: :my_value
server '52.197.133.116', user: 'ec2-user', roles: %w{app db web},password: "ranq"
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}

set :ssh_options, {
	#keys:[File.expand_path('C:\.ssh\keypareRanq.pem')]
	keys:[File.expand_path('/home/vagrant/.ssh/keypareRanq.pem')]
}
