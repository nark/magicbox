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

  resources :samples, only: [:index, :general, :rooms, :harvest] do 
    get :general, on: :collection
    get :rooms, on: :collection
    get :harvest, on: :collection
  end
  resources :observations

  resources :batches, only: [:index, :show]
  
  resources :harvests, only: [:index]
  
  resources :grows, except: [:edit, :update, :new, :create] do
    resources :harvests, only: [:show] do
      
    end

    resources :weeks
    resources :observations
    resources :subjects do
      resources :observations
    end

    get :print_qr, on: :member
  end

  resources :events

  resources :rooms, only: [:show, :take_camshot] do
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

    resources :grows, only: [:edit, :update, :new, :create, :destroy] do
      resources :harvests, except: [:index, :show] do
        resources :batches, except: [:index, :show]
      end
      resources :subjects do
        post :move_to, on: :member
      end
    end

    resources :rooms do
      resources :devices, only: [:index, :edit, :update, :new, :create, :start, :stop, :destroy] do
        post :start, on: :member
        post :stop,  on: :member
      end
    end
    
    resources :devices, only: [:index]

    resources :strains
    resources :data_types
    resources :scenarios do
      get :run, on: :member
      get :export, on: :member
      post :import, on: :collection
    end
    
    resources :conditions
    resources :operations
    resources :alerts do
      post :test, on: :member
      post :trigger, on: :member
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

      # device token
      resources :users, only: [:show] do
        resources :push_devices, only: [:create]
      end

  		resources :devices, only: [:index, :show, :update, :start, :stop] do
  			post :start, on: :member
  			post :stop,  on: :member
  		end

      resources :rooms
      resources :grows
      resources :subjects do
        resources :observations
      end
      resources :scenarios
      resources :conditions
      resources :operations
      resources :observations
      resources :events
      resources :users, only: [:index]

	  	resources :data_types, only: [:index, :show] do
	  		resources :samples, :defaults => { :format => :json }, only: [:index, :show]
	  	end

	  	resources :samples, :defaults => { :format => :json }, only: [:index, :show, :create]
		end
	end


  # Commontator
  mount Commontator::Engine => '/commontator'


  # API doc
	apipie
end
