# frozen_string_literal: true

module V1
  module Entities
    class Student < Entities::Base
      expose(:lessons, using: V1::Entities::Course) do |user|
        user.orders.map(&:lesson).uniq
      end
      expose(:orders, using: V1::Entities::Order)
    end
  end
end
