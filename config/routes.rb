# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :courses do
    collection do
      get ':customize', {
        to: 'courses#customize',
        constraints: ->(request) { Course.where(url: request[:customize]).any? }
      }
    end
  end

  mount ApiRoot => ApiRoot::PREFIX

  root to: 'home#index'
end
