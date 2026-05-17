Rails.application.routes.draw do
  get  "signup",  to: "registrations#new",    as: :signup
  post "signup",  to: "registrations#create"

  get  "login",   to: "sessions#new",         as: :login
  post "login",   to: "sessions#create"
  delete "logout", to: "sessions#destroy",    as: :logout

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#show", as: :home
end
