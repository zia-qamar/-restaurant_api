Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :guests, :only => [:show, :create, :index, :update]
      resources :hotels, :only => [:show, :create, :index, :update]
      resources :reservations
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
