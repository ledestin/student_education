Rails.application.routes.draw do
  get "/students", to: "students#index"
  get "/students/:id", to: "students#show"
  put "/students/:id", to: "students#update"
end
