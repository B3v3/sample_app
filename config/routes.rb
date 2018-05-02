Rails.application.routes.draw do

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :password_resets,     only: [:new, :edit, :create, :update]
    resources :account_activations, only: [:edit]
    resources :microposts,          only: [:create, :destroy]
    resources :relationships,       only: [:create, :destroy]

  get  '/signup' => 'users#new'
  post '/signup' => 'users#create'



  get '/home' => 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'

  get    '/login'  => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'


  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
