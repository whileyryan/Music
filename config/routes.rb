Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  
  get '/users/load_concerts' => 'users#load_concerts'

  get '/users/original' => 'users#original_concerts'

  get 'users/:id' => 'users#show'

  post '/users/new_zipcode' => 'users#new_zipcode'


  post '/store_zipcode/:zip' => 'users#store_zipcode'

  post 'search/show' => 'search#show'

  post 'users/about' => 'users#about'

  resources :artists, only: [:show] do
    resources :reviews
  end

  post '/artists/follow' => 'artists#follow'

end
