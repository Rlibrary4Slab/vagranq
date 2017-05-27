Rails.application.routes.draw do
  get 'notifications/flag_off'

  get 'notifications/paginate'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  #match 'signout', to: 'sessions#destroy', as: 'signout'

  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',   
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :passwords => 'users/passwords'
  } 

  devise_scope :user do
    #get "sign_in", :to => "users/sessions#new", as: :new_user_session
    #get "sign_out", :to => "users/sessions#destroy" , as: :destroy_user_session
    #delete :sign_out, to: 'devise/sessions#destroy', as: :destroy_user_session
  end  
  #resources :articles, only: [:show,:create,:edit,:destroy,:new]  do
  resources :u, only: [:index, :show] do
    scope module: :u do
      resources :articles, only: [:index, :show]
    end
  end
  resources :articles, only: [:index,:show,:create,:edit,:update,:destroy,:new]  do
    member do
      get :liking_users
      post :publish
      post :draft
    end
  end

  resources :users,param: :name ,except: :edit do
    member do
      get :like_articles
    end
  end
  namespace :settings do
    resource :profiles
    resource :accounts
    resource :passwords
  end
  post '/like/:article_id' => 'likes#like', as: 'like'
  delete '/unlike/:article_id' => 'likes#unlike', as: 'unlike'
  
  get 'signup' => 'users#new'
  get 'allranking' => "articles#allranking"
  get "home" => "static_pages#home" 
  get "fashion" => "articles#fashion"
  get "beauty" => "articles#beauty"
  get "hangout" => "articles#hangout"
  get "gourmet" => "articles#gourmet"
  get "lifestyle" => "articles#lifestyle"
  get "entertainment" =>"articles#entertainment"
  get "interior" => "articles#interior"
  get "gadget" => "articles#gadget"
  get "learn" => "articles#learn"
  get "funny" => "articles#funny" 
  get "search" => "articles#search"
  root 'static_pages#home'
  
  get   'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  #resources :microposts,          only: [:create, :destroy]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  #get '*anything' => 'errors#routing_error'
  #get '*anything' => 'errors#not_found'
  #get '*path', controller: "application",action: 'render_404' 
  
  match '' => "notifications#paginate" ,:via => :get      #任意のページでpagination
 
end
