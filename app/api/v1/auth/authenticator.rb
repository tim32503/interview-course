# frozen_string_literal: true

module V1
  module Auth
    class Authenticator
      def initialize(request, params)
        @request = request
        @params  = params
      end

      def authenticate!
        check_token!
        token
      end

      def token
        @token = ApiAccessToken.joins(:user).where(key: @params[:token]).first
      end

      def check_token!
        return @params[:token] unless token
      end
    end
  end
end
