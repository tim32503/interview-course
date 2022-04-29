# frozen_string_literal: true

module V1
  module Helpers
    def authenticate!
      current_user or raise AuthorizationError
    end

    def current_user
      @current_user ||= env['v1.user']
    end
  end
end
