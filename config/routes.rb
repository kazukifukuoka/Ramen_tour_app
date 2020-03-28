Rails.application.routes.draw do
  root to: 'ramens#top'
  get 'ramens/index', to: 'ramens#index'
  get 'ramens/id', to: 'ramens#show'

  get 'users/new', to: 'users#new'
  get 'users/id/', to: 'users#show'
end
