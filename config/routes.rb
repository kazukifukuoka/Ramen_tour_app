Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    sessions: "users/sessions"
  }

  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
    get 'users/:id', to: 'users/sessions#show', as: :user
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'homes#top'

  resources :ramen_stores do
    resources :ramen_store_reviews, as: :reviews, path: '/reviews', except: [:index]
  end

end
