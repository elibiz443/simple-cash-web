Rails.application.routes.draw do
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"
  delete "logout", to: "sessions#destroy"

  get "home", to: "home#index"
  get "dashboard", to: "dashboard#index"
  resources :top_ups
  get "wallet", to: "top_ups#show"
  resources :transactions
  resources :reports
  resources :notifications
  get "profile", to: "home#profile"

  root "home#index"
end
