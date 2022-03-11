# frozen_string_literal: true

Rails.application.routes.draw do
  get "/send-mails", to: "send_mails#index", as: "send_mails"
  resources :meetings
  devise_for :users, controllers: {
    confirmations: "confirmations"
  }
  resources :rooms
  root "rooms#index"
end
