Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'submitemail', to: 'email_submission#index'
  post 'send_email', to: 'email_submission#send_email'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
end
