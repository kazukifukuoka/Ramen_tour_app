Rails.application.routes.draw do
  devise_for :users
  root to: 'top#top'

  resources :ramen_stores
end
