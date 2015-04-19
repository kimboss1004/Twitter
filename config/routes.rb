Rails.application.routes.draw do

  root to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:destroy] do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end

  get '/mentions', to: 'statuses#mentions'
  resources :statuses do
    member do
      post 'retweet'
    end
  end

  resources :hashtags, only: [:show]
end
