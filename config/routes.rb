Rails.application.routes.draw do
  put "/students/:id", to: "students#update"
end
