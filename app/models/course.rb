# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user

  has_many :orders
  has_many :students, through: :orders, source: :student

  validates :title, :currency, :course_type, :expiration_period, presence: true
  validates :is_launched, inclusion: { in: [true, false] }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: '金額必須大於等於 %{count}' }

  scope :is_available, -> { where(is_launched: true) }
end
