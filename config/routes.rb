Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  #mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Root => '/api'
  match "/websocket", :to => WebsocketRails::ConnectionManager.new, via: [:get, :post]
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',   
    :omniauth_callbacks => 'omniauth_callbacks',
    :passwords => 'users/passwords'
  } 
  get 'ranking' => 'static_pages#ranking'
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
      get :liking_users
      post :publish
      post :draft
    end
  end
  get "access_log_index" => "users#access_log_index"

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
    resource :profile
    resource :account
    resource :password
#    match '' => 'notifications#paginate', via: :get
    #get 'notifications/flag_off' => '/notifications#flag_off'
    get '?page=:page' => 'notifications#paginate'
end

  post '/like/:article_id' => 'likes#like', as: 'like'
  delete '/unlike/:article_id' => 'likes#unlike', as: 'unlike'
  get "edit_articles" => "users#edit_articles"
  root 'static_pages#home'
  get  '/auth/:provider/callback' => 'sessions#callback'
  post '/auth/:provider/callback'  => 'sessions#callback'
  get  '/auth/failure' => 'sessions#failure'  
  #resources :microposts,          only: [:create, :destroy]
  
  #get '*path', controller: "application",action: 'render_404' 
  get 'notifications/flag_off'
  match '' => "notifications#paginate" ,via: :get      #任意のページでpaginationするためのルーティング
  #get '*path', controller: 'application', action: 'render_404' 
  #get '*path', controller: 'application', action: 'render_500' 
  #get '*path', controller: 'application', action: 'render_404' if Rails.env.production?
  #get '*path', controller: 'application', action: 'render_500' if Rails.env.production?
  
 
end
