Rails.application.routes.draw do
  get "payment/check", to: "payments#check"
  post "payment/check", to: "payments#result"
  get 'home/index'
  get "/imoney/:service", to: "imoney#show", as: :imoney_service
  devise_for :users
  get "/dashboard", to: "dashboard#index"
  resources :deposits, only: [:new, :create, :index]

  resources :withdrawals, only: [:new, :create, :index]

  resources :supervisions, only: [:index] do
    member do
      patch "approve"
      patch "reject"
    end
  end

  resources :transactions, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
