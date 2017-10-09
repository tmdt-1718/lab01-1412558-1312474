Rails.application.routes.draw do
  devise_for :users
  get 'posts', to:'posts#index'
resources :posts do
  resources :comments
end

root 'home#index'
get '/about', to: 'about#index'
get '/home', to: 'home#index'
get '/posts', to: 'posts#index'
get '/albums', to: 'albums#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
