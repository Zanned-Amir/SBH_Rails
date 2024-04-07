Rails.application.routes.draw do
  root 'home#index'
  get 'home/index' , to: 'home#index'
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }


    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions:'users/sessions'
    }

  get 'admin', to: 'admin#index'
  get 'home/show_products_by_category', to: 'home#show_products_by_category', as: :show_products_by_category_home

  post 'add_to_cart', to: 'home#add', as: 'add_to_cart'
  post 'add_to_cart_from_home', to: 'home#add_to_cart', as: 'add_to_cart_from_home'
  get 'cart', to: 'home#cart', as: 'cart'
  post 'remove_from_cart', to: 'home#remove', as: 'remove_from_cart'

  resources :role_permissions
  resources :user_roles
  resources :permissions
  resources :roles
  resources :users
  resources :reviews
  resources :order_details
  resources :orders do
    member do
      get 'details'
    end
  end
  resources :products
  resources :categories
    
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
