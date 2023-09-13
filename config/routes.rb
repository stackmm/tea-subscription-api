Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        resources :subscriptions, only: [:index]
      end
      resources :subscriptions, only: [:create, :destroy]
    end
  end
end
