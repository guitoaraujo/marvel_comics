# frozen_string_literal: true

Rails.application.routes.draw do
  root 'comics#index'

  devise_for :users
  
  get 'comics/', to: 'comics#index'
  get 'comics/search', to: 'comics#search'
  post 'comics/add_favorite', to: 'comics#add_favorite'
  delete 'comics/remove_favorite', to: 'comics#remove_favorite'
end
