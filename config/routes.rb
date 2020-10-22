# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show index]
  resources :opinions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'opinions#index'
end
