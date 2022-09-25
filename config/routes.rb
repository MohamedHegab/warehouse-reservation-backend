Rails.application.routes.draw do
  namespace :api do
    resources :warehouses
  end
end
