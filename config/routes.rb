Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '', to: 'health_check#show'
      resources :geolocations, only: %i[index show create destroy]
    end
  end
end
