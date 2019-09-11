Rails.application.routes.draw do

  resources :responses
  resources :game_mappings
  resources :game_mapping_groups
  mount ActionCable.server => '/cable'

  resources :challenge_games
  resources :games do
    member do
      get 'load' => 'games#load', as: :load
      get 'display_results' => 'games#display_results', as: :display_results
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
    member do
      get 'load_other_player/:session_hash' => 'rooms#load_other_player', as: :load_other_player
    end
  end
  resources :languages

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'new_guest' => 'users/registrations#new_guest'
  end


  get '/' => 'pages#index'
  get 'single' => 'pages#single'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
