Rails.application.routes.draw do
  devise_for :users
  root to: 'top#top'

  get 'ramens', to: 'ramen_stores#index'
  post 'ramens', to: 'ramen_stores#create'
  get 'ramens/new', to: 'ramen_stores#new'
  get 'ramens/:id', to: 'ramen_stores#show'

  get 'users/new', to: 'users#new'
  get 'users/id', to: 'users#show'
end
