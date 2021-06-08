Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "members#new"
  resources :friendships
  resources :sessions

  get "/members/:id", to: "members#show"
  post "/create_member", to: "members#new"
  post "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
end
