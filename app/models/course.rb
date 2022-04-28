# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, :currency, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, message: '金額必須大於等於 %{count}' }

  belongs_to :user

  scope :is_available, -> { where(is_launched: true) }
end
