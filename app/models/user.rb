# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses
  has_many :orders
  has_many :lessons, through: :orders, source: :lesson
  has_many :tokens, class_name: 'ApiAccessToken'
end
