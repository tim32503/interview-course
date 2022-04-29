# frozen_string_literal: true

module V1
  module Entities
    class Course < Entities::Base
      expose :id
      expose :title
      expose :course_type
      expose :description
      expose :is_launched
      expose(:teacher, using: V1::Entities::User, &:user)
    end
  end
end
