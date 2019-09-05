Rails.application.routes.draw do
  
  resources :game_mappings
  resources :game_mapping_groups
  mount ActionCable.server => '/cable'

  resources :challenge_games
  resources :games do
    member do
      get 'load' => 'games#load', as: :load
    end
  end
  resources :challenge_answers
  resources :challenges do
    member do
      get 'load' => 'challenges#load', as: :load
    end
  end
  resources :room_users
  resources :messages
  resources :rooms do
    collection do
      post 'pin_enter' => 'rooms#pin_enter'
    end
  end
  resources :languages
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'new_guest' => 'users/registrations#new_guest'
  end

  
  get '/' => 'pages#index'
  get 'single' => 'pages#single'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
