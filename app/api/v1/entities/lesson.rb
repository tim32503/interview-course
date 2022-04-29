# frozen_string_literal: true

module V1
  module Entities
    class Lesson < Entities::Base
      expose :id
      expose :title
      expose :description
      expose :expired_at, using: V1::Entities::Order, format_with: :iso8601
    end
  end
end
