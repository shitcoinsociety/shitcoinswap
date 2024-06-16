Rails.application.routes.draw do

  resource :session
  resources :projects
  resources :password_resets
  resources :users
  resources :deposits
  resources :portfolios

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/auth/:provider/callback" => "sessions#create"

  inertia "/privacy" => "static/privacy"

  get "/@:nickname" => "users#show"

  # Defines the root path route ("/")
  root "projects#index"
end
