Rails.application.routes.draw do
  devise_for :users
  root to: 'top#top'

  resources :ramen_stores

  get 'users/new', to: 'users#new'
  get 'users/id', to: 'users#show'
end
