# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meetings
  devise_for :users, controllers: {
    confirmations: "confirmations"
  }
  resources :rooms
  root "rooms#index"
end
