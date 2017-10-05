Rails.application.routes.draw do
root 'home#index'
  get 'albums', to: 'albums#index'


get '/about', to: 'about#index'
get '/home', to: "home#index"
get '/blogs', to: "blogs#index"
get '/albums', to: "albums#index"
get '/users', to: "users#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
