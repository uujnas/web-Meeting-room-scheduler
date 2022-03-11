# frozen_string_literal: true

Rails.application.routes.draw do
  get "/send-mails", to: "send_mails#index", as: "send_mails"
  post "/send-mails", to: "meetings#send_mails", as: "send_mail"
  resources :meetings
  devise_for :users, controllers: {
    confirmations: "confirmations"
  }
  resources :rooms
  root "rooms#index"
end
