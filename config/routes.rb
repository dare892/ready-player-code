Rails.application.routes.draw do
  
  mount ActionCable.server => '/cable'

  resources :challenge_games
  resources :games
  resources :challenge_answers
  resources :challenges
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
