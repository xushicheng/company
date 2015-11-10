Rails.application.routes.draw do
  get 'home'    => 'page#home'
  get 'about'   => 'page#about'
  get 'contact' => 'page#contact'
  get 'member'  => 'page#member'
  root 'page#home'

  match 'signup' => 'users#signup', via: [:get, :post], as: 'signup'
  get 'login' => 'users#login', as: 'login'
  post 'create_login_session' => 'users#create_login_session'
  delete "logout" => "users#logout", :as => "logout"
  resources :users, only: [:show, :create]

  resources :blogs
  resources :comments

  get 'admin' => 'users#admin', as: 'admin'
end
