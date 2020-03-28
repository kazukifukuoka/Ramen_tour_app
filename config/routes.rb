Rails.application.routes.draw do
  root to: 'ramen#top'
  get 'ramen/index', to: 'ramen#index'
  get 'ramen/id', to: 'ramen#show'

  get 'user/new', to: 'user#new'
  get 'user/id/', to: 'user#show'
end
