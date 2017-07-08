Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  #match 'signout', to: 'sessions#destroy', as: 'signout'
  match "/websocket", :to => WebsocketRails::ConnectionManager.new, via: [:get, :post]
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',   
    :omniauth_callbacks => 'omniauth_callbacks',
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
  scope "/search" do
    get "/" => "articles#search", as: "search"
  end
  get 'allranking' => "articles#allranking"
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
  #resources :articles, only: [:index,:show,:create,:edit,:update,:destroy,:new]  do
  resources :articles do
    member do
      get :liking_users
      post :publish
      post :draft
    end
  end
  get "access_log_index" => "users#access_log_index"

  #resources :users,param: :name ,except: [:edit ,:show] do
  resources :users,param: :name ,only: [:index,:access_log_index] do
    member do
      get :like_articles
      get :share_twitter
      get :share_facebook
      get :inshare_twitter
      get :inshare_facebook
      get :edit_articles
    end
  end
  scope ":name", controller: :users do  
   get "/" => "users#show", as: "user" 
   get :like_articles
   get :share_twitter
   get :share_facebook
   get :inshare_twitter
   get :inshare_facebook
   get :edit_articles
  end
  
  scope module: :settings do 
  #namespace :settings do
    resource :profile
    resource :account
    resource :password
#    match '' => 'notifications#paginate', via: :get
    #get 'notifications/flag_off' => '/notifications#flag_off'
    get '?page=:page' => 'notifications#paginate'
  #get '?page=:page' => '/notifications#flag_off'
end

  post '/like/:article_id' => 'likes#like', as: 'like'
  delete '/unlike/:article_id' => 'likes#unlike', as: 'unlike'
  get "edit_articles" => "users#edit_articles"
  #get 'signup' => 'users#new'
  root 'static_pages#home'
  get  '/auth/:provider/callback' => 'sessions#callback'
  post '/auth/:provider/callback'  => 'sessions#callback'
  get  '/auth/failure' => 'sessions#failure'  
  #get   'login'   => 'sessions#new'
  #post   'login'   => 'sessions#create'
  #delete 'logout'  => 'sessions#destroy'
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
  get 'notifications/flag_off'
  match '' => "notifications#paginate" ,via: :get      #任意のページでpaginationするためのルーティング
  
 
end
