Rails.application.routes.draw do

  resources :news_tags 
  post "postfromgas" => "news_tags#postfromgas"
  mount Ckeditor::Engine => '/ckeditor'
  #mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/api'
  match "/websocket", :to => WebsocketRails::ConnectionManager.new, via: [:get, :post]
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup
  namespace :api do
    post "inquiry_article" => "inquiry#inquiry_article"
    post "oauth_user" => "users#oauth_user"
    post "guest_user_registration" => "users#guest_user_registration"
    post "oauth_loginuser" => "users#oauth_loginuser"
    delete "twitter_auth_out" => "users#twitter_auth_out"
    delete "facebook_auth_out" => "users#facebook_auth_out"
    resources :users, param: :access_token
    get "articles_siderank" => "articles#siderank"
    resources :items,only:[:create,:update]
    resources :password_resets, only: [:new, :create, :edit, :update]
  end  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',   
    :omniauth_callbacks => 'omniauth_callbacks',
    :passwords => 'users/passwords'
  } 
  get 'ranking' => 'static_pages#ranking'
  get 'help' => 'static_pages#help'
  get 'agreement' => 'static_pages#agreement'
  get 'inquiry' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'
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
  scope module: :settings do 
    resource :setup
    resource :profile
    resource :account
    resource :password
#    match '' => 'notifications#paginate', via: :get
    #get 'notifications/flag_off' => '/notifications#flag_off'
    get '?page=:page' => 'notifications#paginate'
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
  resources :articles do
    member do
      post :set_top_article
      post :unset_top_article
      get :article_inquiry
      get :liking_users
      post :publish
      post :draft
    end
  end
  get "access_log_index" => "users#access_log_index"
  get 'verify'  => 'sessions#verify_access_token'
  get 'verify_user'  => 'sessions#verify_user_column'
  get 'verify_logout'  => 'sessions#verify_logout'
  get 'verify_like'  => 'likes#verify_like'
  get 'verify_unlike'  => 'likes#verify_unlike'
  get 'verify_item_like'  => 'item_likes#verify_like'
  get 'verify_item_unlike'  => 'item_likes#verify_unlike'
  get 'verify_like_or_not'  => 'likes#verify_like_or_not'
  get 'verify_item_like_or_not'  => 'item_likes#verify_like_or_not'
  resources :items 

  resources :users,param: :name ,only: [:index,:access_log_index] do

    member do
      get :like_articles
      get :edit_articles
    end
  end
  scope "@:name", controller: :users do  
   get "/" => "users#show", as: "user" 
   get :like_articles
   get :edit_articles
  end
  delete "twitter_auth_out" => "users#twitter_auth_out"
  delete "facebook_auth_out" => "users#facebook_auth_out"
  
  post "share_twitter" => "settings/profiles#share_twitter"
  post "share_facebook" => "settings/profiles#share_facebook"
  

  post '/itemlike/:item_id' => 'item_likes#like', as: 'itemlike'
  delete '/unitemlike/:item_id' => 'item_likes#unlike', as: 'unitemlike'

  post '/like/:article_id' => 'likes#like', as: 'like'
  delete '/unlike/:article_id' => 'likes#unlike', as: 'unlike'

  get "edit_articles" => "users#edit_articles"
  root 'static_pages#home'
  get  '/auth/:provider/callback' => 'sessions#callback'
  post '/auth/:provider/callback'  => 'sessions#callback'
  get  '/auth/failure' => 'sessions#failure'  
  resource :authentication_token, only: [:update, :destroy]
  #resources :microposts,          only: [:create, :destroy]
  
  #get '*path', controller: "application",action: 'render_404' 
  get 'notifications/flag_off'
  match '' => "notifications#paginate" ,via: :get      #任意のページでpaginationするためのルーティング
  #get '*path', controller: 'application', action: 'render_404' 
  #get '*path', controller: 'application', action: 'render_500' 
  get '*path', controller: 'application', action: 'render_404' if Rails.env.production?
  #get '*path', controller: 'application', action: 'render_500' if Rails.env.production?
  
 
end
