Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
  }

  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
  end
  root to: 'top#top'

  resources :ramen_stores

end
