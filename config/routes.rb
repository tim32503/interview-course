# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :courses

  mount ApiRoot => ApiRoot::PREFIX

  root to: 'home#index'
end
