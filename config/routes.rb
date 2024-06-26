Rails.application.routes.draw do
  root 'home#index'
  get 'home/index' , to: 'home#index' , as: 'home_index'
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
  get 'home/show_product/:id', to: 'home#show_product', as: :show_product

  post 'add_to_cart', to: 'home#add', as: 'add_to_cart'
  post 'add_to_cart_from_home', to: 'home#add_to_cart', as: 'add_to_cart_from_home'
  get 'cart', to: 'home#cart', as: 'cart'
  post 'remove_from_cart', to: 'home#remove', as: 'remove_from_cart'
  get 'order_confirmation' , to: 'home#order_confirmation', as: 'order_confirmation'
  get "checkout", to: 'home#checkout', as: 'checkout'
  get "save_order", to: 'home#save_order', as: 'save_order'

  get "home/shop", to: 'home#shop', as: 'shop'
  

 
  scope '/admin' do
    resources :orders do
      member do
        get 'details'
      end
    end
    resources :products
    resources :categories
    resources :users
    resources :reviews
    resources :order_details
  end
  
  get 'home/descover', to: 'home#descover', as: 'descover'
  delete 'order_details/:id', to: 'orders#destroyDetailOrder', as: 'destroy_detail'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
