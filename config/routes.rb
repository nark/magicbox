Rails.application.routes.draw do
  # Devise setup  
  devise_scope :user do
    authenticated :user do
      root to: 'admin/dashboard#index', as: :authenticated_root
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

  # Admin namespace
  namespace :admin do
  	get "/dashboard" => "dashboard#index"
    resources :samples, only: :index

    resources :users, only: [:index, :new, :edit, :create, :update, :destroy, :update_password] do
      get :update_password, on: :member
    end

    resources :grows do
      resources :subjects do
        resources :observations
      end

      get :print_qr, on: :member
    end
    
    resources :rooms do
      resources :devices  do
        post :start, on: :member
        post :stop,  on: :member
      end
      resources :events
    end
  
    resources :scenarios
    resources :conditions
    resources :operations
    
  	get '/' => "dashboard#index"
  end


  # The API namespace ()
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
