
working_directory '/var/www/rails/ranqdeployer'

pid '/var/www/rails/ranqdeployer/pids/unicorn.pid'

stderr_path '/var/www/rails/ranqdeployer/log/unicorn.log'
stdout_path '/var/www/rails/ranqdeployer/log/unicorn.log'

listen '/tmp/unicorn.demo-app.sock'

worker_processes 2

timeout 30


