Rails.application.routes.draw do
  resources :events
  
  # Devise setup
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'admin/dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end


  # Admin namespace
  namespace :admin do
  	get "/dashboard" => "dashboard#index"

  	resources :devices  do
      post :start, on: :member
      post :stop,  on: :member
    end

    resources :subjects
    resources :scenarios
    resources :conditions
    resources :operations
    
  	get '/' => "dashboard#index"
  end


  # The API namespace
  namespace :api do
  	namespace :v1 do
  		get '/context', to: "context#index"

  		resources :devices, only: [:index, :show, :update, :start, :stop] do
  			post :start, on: :member
  			post :stop,  on: :member
  		end

      resources :subjects
      resources :scenarios
      resources :conditions
      resources :operations

	  	resources :data_types, only: [:index, :show] do
	  		resources :samples, :defaults => { :format => :json }, only: [:index, :show]
	  	end

	  	resources :samples, :defaults => { :format => :json }, only: [:index, :show, :create]
		end
	end


  # API doc
	apipie
end
