Rails.application.routes.draw do
  root to: 'welcome#index'
  get "/register", to: "users#new"
  get "/dashboard", to: "dashboard#show"
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end

      resources :users, only: [:index, :show, :update, :create]
    end
  end

  resources :users, only: [:index, :show, :edit, :update, :create]
end
