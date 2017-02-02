module JQuery
  module Selection
    module Rails
      require 'jquery/selection/rails/engine' if defined?(Rails)
    end
  end
end
require 'jquery/selection/rails/upload' if defined?(Rails)
