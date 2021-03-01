Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "searches#index"
  resources :searches do
    collection do
      get :suggestions
    end
  end
  resources :search_histories, only: :create do
    member do
      post :update
    end
  end
end
