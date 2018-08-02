Rails.application.routes.draw do
  root to: "home#index"

  get "/teachers", to: "teachers#index"

  resources :students
end
