Rails.application.routes.draw do
  devise_for :users

  root 'splash#index'

  get 'home/index', as: 'home_index'
  get 'home/index/new', to: 'home#new', as: 'home_new'
  get 'home/index/:category_id', to: 'home#show', as: 'home_show'
  get 'home/index/:category_id/new', to: 'transactions#new', as: 'transactions_new'
  post 'home/index/:category_id/create', to: 'transactions#create', as: 'transactions_create'

  post 'home/index/create', to: 'home#create', as: 'home_create'

end