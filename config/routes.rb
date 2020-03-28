Rails.application.routes.draw do
  get '/top', to: 'ramen#top'
  get '/index', to: 'ramen#index'
  get '/id', to: 'ramen#show'

  get 'user/new', to: 'user#new'
  get 'user/id/show', to: 'user#show'
end
