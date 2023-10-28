# frozen_string_literal: true

Rails.application.routes.draw do
  get 'edit_public_page/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'submitemail', to: 'email_submission#index'
  post 'send_email', to: 'email_submission#send_email'
  get 'reset/:token', to: 'password_reset#reset'
  post 'submit_reset', to: 'password_reset#change_password'
  # Defines the root path route ("/")
  # root "articles#index"

  get 'passward/reset/edit', to: 'password_resets#edit'
  patch 'passward/reset/edit', to: 'password_resets#update'

  root 'home#index'

  get '/login', to: 'sessions#new', as: 'sessions_new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#main', as: 'dashboard'
  get '/dashboard/hours', to: 'hours#index', as: 'hours'
  get '/dashboard/hours/new', to: 'hours#new', as: 'new_hour'
  post '/dashboard/hours', to: 'hours#create', as: 'create_hour'
  delete '/dashboard/hours', to: 'hours#destroy', as: 'delete_hour'

  post '/services', to: 'services#create'
  get '/services', to: 'services#new'

  get '/services/:id', to: 'services#show', as: 'show_service'
  
  delete '/deleteservices/:id/hide', to: 'services#hide', as: 'hide_service'
  post '/togglepublish/:id', to: 'services#togglepublish', as: 'service_publish'

  get '/servicesindex', to: 'services#index'

  post '/editService/:token', to: 'services#edit'
  get 'editService/:token', to: 'services#edit_intial', as: 'edit_service'

  get 'public/:username', to: 'public_page#show', as: 'public_page'
  get '/edit_public_page', to: 'edit_public_page#index', as: 'edit_public_page'

  patch '/update/user_profile', to: 'edit_public_page#update', as: 'edit_public_page_update'
end
