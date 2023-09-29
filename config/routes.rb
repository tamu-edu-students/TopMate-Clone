Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'

  get '/login', to: 'sessions#new' , as: 'sessions_new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#main', as: 'dashboard'
end
