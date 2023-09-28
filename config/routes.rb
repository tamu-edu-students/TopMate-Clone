Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get 'passward/reset/edit', to 'password_resets#edit'
  # patch 'passward/reset/edit', to 'password_resets#update'

  root 'welcome#index'
end
