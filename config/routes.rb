Rails.application.routes.draw do
  get 'about'   => 'page#about'
  get 'contact' => 'page#contact'
  root to: 'page#home'

  match 'signup' => 'users#signup', via: [:get, :post], as: 'signup'
  get 'login' => 'users#login', as: 'login'
  post 'create_login_session' => 'users#create_login_session'
  delete "logout" => "users#logout", :as => "logout"
  resources :users, only: [:show, :create]

  resources :blogs
  resources :comments

  namespace :admin do
    resources :users
    resources :blogs
    resources :comments
    resources :sessions, :only=>[:new, :create, :destroy]
    root to: 'dashboard#index'
  end
end
