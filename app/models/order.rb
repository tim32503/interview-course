# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'user_id'
  belongs_to :lesson, class_name: 'Course', foreign_key: 'course_id'

  validates :expired_at, presence: true
end
