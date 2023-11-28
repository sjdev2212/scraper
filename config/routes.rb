Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"

  resources :scraps, only: [:new, :create, :index] do
    member do
      get 'process_csv'
    end
    resources :scrap_details, only: [:index]
  end
end
