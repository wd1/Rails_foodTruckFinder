Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reviews, only:[:new, :create]
  resources :trucks, only: [:index, :show]
  resources :users, only:[:show, :edit, :update, :destroy]
  resources :favorites, only:[:create, :destroy]
  get '/signup', to: 'users#new', as: 'signup'
  get "/signin", to: "sessions#new", as: "signin"
  post "/sessions", to: "sessions#create", as: "sessions"
  delete "/sessions", to: "sessions#destroy", as: "signout"
  post "/signup", to: 'users#create', as: "users"
  get "/analytics", to: "sessions#index", as: "analytics"
  root "sessions#new"

end
