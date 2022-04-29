# frozen_string_literal: true

module V1
  module Entities
    class User < Entities::Base
      expose :id
      expose :name
      expose :email
    end
  end
end
