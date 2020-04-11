Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
    get 'users/:id', to: 'users/sessions#show', as: :user
  end
  root to: 'top#top'

  resources :ramen_stores

end
