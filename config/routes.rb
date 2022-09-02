Rails.application.routes.draw do

  get '/api/v1/items/:item_id/merchant', to: 'api/v1/item_merchants#show'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end

      resources :items, only: [:index, :show, :create, :destroy, :update]
    end
  end
end
