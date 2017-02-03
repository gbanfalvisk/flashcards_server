Rails.application.routes.draw do
  
  scope module: 'api' do
    namespace :v1 do

      # Registration
      post 'register', to: 'users#register'

      # Sessions
      post 'login',  to: 'sessions#login'
      post 'logout', to: 'sessions#logout'

      get    'cards',     to: 'cards#index'
      post   'cards',     to: 'cards#create'
      get    'cards/:id', to: 'cards#show'
      put    'cards/:id', to: 'cards#update'
      delete 'cards/:id', to: 'cards#destroy'

      get    'decks',     to: 'decks#index'
      post   'decks',     to: 'decks#create'
      get    'decks/:id', to: 'decks#show'
      put    'decks/:id', to: 'decks#update'
      delete 'decks/:id', to: 'decks#destroy'

      get    'deckcards',     to: 'deck_cards#index'
      post   'deckcards',     to: 'deck_cards#create'
      get    'deckcards/:id', to: 'deck_cards#show'
      delete 'deckcards/:id', to: 'deck_cards#destroy'

    end
  end

  
  #resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
