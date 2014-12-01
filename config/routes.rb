Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'

  get 'users/:id' => 'users#show'

  post '/store_zipcode/:zip' => 'users#store_zipcode'

  post 'search/show' => 'search#show'

  post 'users/users_about' => 'users#about'

  resources :artists, only: [:show] do
    resources :reviews
  end

  post '/artists/follow' => 'artists#follow'



end
