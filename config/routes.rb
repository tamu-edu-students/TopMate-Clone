Rails.application.routes.draw do
  get 'edit_public_page/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'submitemail', to: 'email_submission#index'
  post 'send_email', to: 'email_submission#send_email'
  get 'password_reset_edit_url/:token', to: 'password_reset#reset'
  post 'submit_reset', to: 'password_reset#change_password'
  # Defines the root path route ("/")
  # root "articles#index"

  get 'passward/reset/edit', to: 'password_resets#edit'
  patch 'passward/reset/edit', to: 'password_resets#update'

  root 'home#index'

  get '/login', to: 'sessions#new' , as: 'sessions_new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#main', as: 'dashboard'

  post '/services', to: 'services#create'
  get '/services', to: 'services#new'

  get '/servicesindex', to: 'services#index'

end
