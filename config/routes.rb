Rails.application.routes.draw do
  resources :rooms
  devise_for :users

  root 'rooms#index'
end
