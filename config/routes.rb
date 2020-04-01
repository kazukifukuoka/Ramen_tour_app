Rails.application.routes.draw do
  devise_for :users
  root to: 'ramen_stores#top'

  get 'ramens/index', to: 'ramen_stores#index'
  get 'ramens/:id', to: 'ramen_stores#show'

  get 'ramens/comments/:id', to: 'ramen_store_comments#show'

  get 'ramens/search', to: 'ramen_store_searches#index'

  get 'users/new', to: 'users#new'
  get 'users/id', to: 'users#show'
end
