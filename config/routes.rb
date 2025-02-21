Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
Rails.application.routes.draw do
  # Root route: login page.
  root "sessions#new"

  # Registration Routes
  get  '/signup', to: 'users#new',    as: 'signup'
  post '/signup', to: 'users#create'

  # Authentication Routes
  get    '/login',  to: 'sessions#new',    as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Kudos Routes: new, create, and feed.
  resources :kudos, only: [:new, :create] do
    collection do
      get :feed  # helper: feed_kudos_path
    end
  end

  # Leaderboard Route
  get '/leaderboard', to: 'leaderboard#index'

  # User Profile & Search Routes
  resources :users, only: [:index, :show]
end

