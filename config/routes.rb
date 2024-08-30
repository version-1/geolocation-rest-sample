Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '', to: 'health_check#show'
      resources :geolocations
    end
  end
end
