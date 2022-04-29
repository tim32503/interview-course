# frozen_string_literal: true

module V1
  module Entities
    class Order < Entities::Base
      expose(:id)
      expose :expired_at, format_with: :iso8601
      expose(:course, merge: true, using: V1::Entities::Course, &:lesson)
    end
  end
end
