Rails.application.routes.draw do
  get "dashboard", to: "dashboard#index"
  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"
  delete "logout", to: "sessions#destroy"
  get "home/index"
  resources :top_ups

  root "home#index"
end
