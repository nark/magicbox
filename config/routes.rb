Rails.application.routes.draw do
  # Devise setup  
  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit/:id' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update'
  end

  resources :users, only: [:show]

  get "/dashboard" => "dashboard#index"
  
  get "/journal" => "journal#index"
  get "/calendar" => "calendar#index"

  resources :todos do
    post :done, on: :member
    post :undone, on: :member
  end

  resources :notifications do
    delete :clear_all, on: :collection
  end

  resources :samples, only: :index
  resources :observations
  
  resources :grows, except: [:edit, :update, :new, :create] do
    resources :weeks
    resources :observations
    resources :subjects do
      resources :observations
    end

    get :print_qr, on: :member
  end

  resources :events

  resources :rooms, except: [:index, :edit, :update, :new, :create] do
    post :take_camshot, on: :member
    resources :devices, only: [:show, :query]  do
      post :query, on: :member
    end
  end

  # Admin namespace
  namespace :admin do
    get "/dashboard/gpio" => "dashboard#gpio"

    resources :users, only: [:index, :new, :edit, :create, :update, :destroy, :update_password] do
      get :update_password, on: :member
    end

    resources :grows do
      resources :subjects do

      end
    end

    resources :rooms do
      resources :devices, only: [:index, :edit, :update, :new, :create, :start, :stop] do
        post :start, on: :member
        post :stop,  on: :member
      end
    end
    
    resources :devices
    resources :data_types
    resources :scenarios do
      get :run, on: :member
    end
    resources :conditions
    resources :operations
    resources :alerts do
      post :test, on: :member
    end
    resources :categories
    resources :resources
    
    resource :settings

  	get '/' => "users#index"
  end


  # The API namespace ()
  namespace :api do
  	namespace :v1 do
  		get '/context', to: "context#index"

  		resources :devices, only: [:index, :show, :update, :start, :stop] do
  			post :start, on: :member
  			post :stop,  on: :member
  		end

      resources :rooms
      resources :grows
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
