# frozen_string_literal: true

Rails.application.routes.draw do
  resources :rooms
  devise_for :users

  root 'rooms#index'
end
