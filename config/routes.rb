# frozen_string_literal: true

Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'users/show'
  get 'users/index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show index]
  resources :users do
    member do 
      get :following, :followers
    end
  end
  resources :followings
  resources :opinions do
    resources :likes, only: [:create, :destroy]
  end

   delete 'like', to: 'likes#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'opinions#index'
end

