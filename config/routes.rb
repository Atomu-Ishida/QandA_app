Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :questions do
    collection do
      get :unsolved
      get :solved
    end
    resources :answers,only: [:create]
  end
  root to: 'questions#index'
  
  namespace :admin do
    root to: 'questions#index'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :users
    resources :questions, only: [:index, :destroy]
  end
  
end
