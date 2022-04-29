# frozen_string_literal: true

module V1
  module Entities
    class Order < Entities::Base
      expose(:id)
      expose(:title) do |order|
        order.lesson.title
      end
      expose(:total) do |order|
        "#{order.lesson.currency}$ #{order.lesson.price.to_i}"
      end
      expose(:expired_at, format_with: :iso8601)
    end
  end
end
