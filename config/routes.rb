Rails.application.routes.draw do
  get 'posts', to:'posts#index'
resources :posts
root 'home#index'
get '/about', to: 'about#index'
get '/home', to: 'home#index'
get '/blogs', to: 'blogs#index'
get '/albums', to: 'albums#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
