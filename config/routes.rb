# frozen_string_literal: true

Rails.application.routes.draw do
  resources :meetings do
    collection do
      get "/send-mails", to: "send_mails#index", as: "send_mails"
      post "/send-mails", to: "meetings#send_mails", as: "send_mail"
    end
  end
  devise_for :users, controllers: {
    confirmations: "confirmations"
  }
  resources :rooms
  get "users/show", to: "users#show"
  root "rooms#index"
end
