Rails.application.routes.draw do
  namespace :api do
    resources :warehouses do
      resources :business_hours, except: [:show]
    end
  end
end
