Rails.application.routes.draw do
  get 'players/new'
  resources :players
  resources :games
  root 'players#new'
  get 'players/new' => 'players#index', as: "first_route"
  get 'games/new' => 'players#index', as: "second_route"
end
