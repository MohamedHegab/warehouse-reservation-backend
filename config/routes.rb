Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  namespace :api do
    resources :warehouses do
      resources :business_hours, except: [:show]
      resources :reserved_slots, param: :uuid, except: [:show]
    end
  end
end
