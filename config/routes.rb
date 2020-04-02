Rails.application.routes.draw do
  devise_for :users, controllers: {
    
        :sessions => 'users/sessions',
        :registrations => 'users/registrations',
        :passwords => 'users/passwords',
        :omniauth_callbacks => 'users/omniauth_callbacks'
      }
  
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "articles#index"
  get '/books/search' => 'books#search'
  
  resources :users, only: [:show]
  resources :articles, except: [:show]
end
