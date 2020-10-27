# frozen_string_literal: true

Rails.application.routes.draw do
   
  resources :opinions do
    resources :likes, only: [:create]
  end
  delete 'like', to: 'likes#destroy'
  resources :followings

  
  get 'users/show'
  get 'users/index'
  
  authenticate :user do
  root to: 'opinions#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')


  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %i[show index]

 


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end

