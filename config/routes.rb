# frozen_string_literal: true

Rails.application.routes.draw do
  root 'comics#index'
  get 'comics/', to: 'comics#index'
  get 'comics/search', to: 'comics#search'
end
