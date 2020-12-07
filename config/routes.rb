Rails.application.routes.draw do
  root to: 'games#new'
  resources :games
  resources :players
  resources :reveals
end
