# frozen_string_literal: true

module V1
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        return unless auth_provided?

        @env['v1.token'] = Authenticator.new(request, params).authenticate!
        @env['v1.user'] ||= @env['v1.token']&.user
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def params
        @params ||= request.params
      end

      def auth_provided?
        params[:token].present?
      end
    end
  end
end
