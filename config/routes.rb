# frozen_string_literal: true

Rails.application.routes.draw do
  get 'edit_public_page/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'submitemail', to: 'email_submission#index'
  post 'send_email', to: 'email_submission#send_email'
  get 'reset/:token', to: 'password_reset#reset'
  post 'submit_reset', to: 'password_reset#change_password'

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

  get '/public/:username/services/:id', to: 'services#show', as: 'show_service'

  delete '/deleteservices/:id/hide', to: 'services#hide', as: 'hide_service'
  post '/togglepublish/:id', to: 'services#togglepublish', as: 'service_publish'

  get '/servicesindex', to: 'services#index'

  post '/editService/:token', to: 'services#submit_edit'
  get 'editService/:token', to: 'services#edit_page', as: 'edit_service'

  get 'public/:username', to: 'public_page#show', as: 'public_page'
  get '/edit_public_page', to: 'edit_public_page#index', as: 'edit_public_page'

  patch '/update/user_profile', to: 'edit_public_page#update', as: 'edit_public_page_update'
  get '/public/:username/:service_id/create/appointment', to: 'appointments#index', as: 'appointments_page_index'
  post '/public/:username/:service_id/create/appointment/submit', to: 'appointments#create_submit',  as: 'appointments_page_create_submit'
  get '/appointment/get/timings/:start_date', to: 'appointments#fetch_slot_times',  as: 'appointments_page_fetch_slot_times_for_date'
end
