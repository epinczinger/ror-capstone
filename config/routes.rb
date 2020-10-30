# frozen_string_literal: true

Rails.application.routes.draw do
  

  authenticate :user do
  root to: 'opinions#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show index]
  
  resources :opinions do
    resources :likes, only: [:create]
  end  
  
  delete 'like', to: 'likes#destroy'
  resources :followings
  
end

