Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end

      resources :users, only: [:index, :show]
    end
  end
  
  resources :users, only: [:index, :show, :edit]
end
