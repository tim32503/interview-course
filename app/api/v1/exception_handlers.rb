# frozen_string_literal: true

module V1
  # 錯誤處理
  module ExceptionHandlers
    def self.included(base)
      base.instance_eval do
        # Grape 驗證錯誤
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({
            error: {
              code: 1001,
              message: e.message
            }
          }.to_json, e.status)
        end

        # 查無 Record
        rescue_from ActiveRecord::RecordNotFound do
          rack_response({ message: '404 Not found' }.to_json, 404)
        end

        # 無對應路徑
        route :any, '*path' do
          error!('404 Not Found', 404)
        end
      end
    end
  end

  class Error < Grape::Exceptions::Base
    attr_accessor :code, :text

    def initialize(opts = {})
      super

      @code    = opts[:code]   || 2000
      @text    = opts[:text]   || ''

      @status  = opts[:status] || 400
      @message = { error: { code: @code, message: @text } }
    end
  end

  class AuthorizationError < Error
    def initialize
      super(code: 2001, text: 'Authorization failed', status: 401)
    end
  end

  class CannotBuyLessonError < Error
    def initialize
      super(code: 3001, text: '您已購買過此課程，且仍在有效期限內', status: 401)
    end
  end
end
