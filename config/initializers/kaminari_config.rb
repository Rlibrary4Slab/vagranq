Kaminari.configure do |config|
   config.page_method_name = :per_page_kaminari
   config.default_per_page = 4
   #config.max_per_page = nil
   config.window = 2 
   #config.outer_window = 1
   #config.left = 2 
   #config.right = 2
   config.param_name = :page
end
