Rails.application.routes.draw do
  get 'searches/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :searches do
    collection do
      get :suggestions
    end
  end
end
