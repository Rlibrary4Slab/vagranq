Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  GA.tracker = "UA-80435618-1"
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  #config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  #config.action_mailer.smtp_settings = {
  #:enable_starttls_auto => true,
  #:address => "smtp.gmail.com",
  #:port => 587,
  #:domain => 'smtp.gmail.com',
  #:user_name => "ranqmedia@gmail.com", #gmailアドレス
  #:password => "forstart", #gmailパスワード
  #:authentication => 'login',
  #}
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: "ranq-media.com", port: 3000}
  config.action_mailer.smtp_settings = {
   :enable_starttls_auto => true,
   :address => "smtp.gmail.com",
   :port => 587,
   #:domain => 'smtp.gmail.com',
   :user_name => "ranqmedia@gmail.com", #gmailアドレス
   :password => "forstart", #gmailパスワード
   #:authentication => 'login',
   :authentication => :plain
  }
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  config.assets.precompile += %w( ckeditor/* )
  config.assets.precompile += %w(*.js)
  config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.middleware.delete Rack::Lock
  config.session_store :redis_store, servers: 'redis://ranq-mini-redis.ct7glm.ng.0001.apne1.cache.amazonaws.com/0', expire_in: 1.day 
 
end
