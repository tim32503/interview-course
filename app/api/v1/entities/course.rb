# frozen_string_literal: true

module V1
  module Entities
    class Course < Entities::Base
      expose :id
      expose :title
      expose :currency
      expose :price
      expose :course_type
      expose :description
      expose :is_launched
      expose :url
      expose :expiration_period
      expose(:teacher, using: V1::Entities::User, &:user)
    end
  end
end
