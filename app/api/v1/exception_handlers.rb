# frozen_string_literal: true

module V1
  # 錯誤處理
  module ExceptionHandlers
    def self.included(base)
      base.instance_eval do
        # Grape 驗證錯誤
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!({ error: { code: e.status, message: e.message } }, e.status)
        end

        # 查無 Record
        rescue_from ActiveRecord::RecordNotFound do
          error!({ error: { code: 404, message: '404 Not Found' } }, 404)
        end

        # 無對應路徑
        route :any, '*path' do
          error!({ error: { code: 404, message: '404 Not Found' } }, 404)
        end
      end
    end
  end

  class Error < Grape::Exceptions::Base
    attr_accessor :code, :text

    def initialize(opts = {})
      super

      @status  = opts[:status] || 400
      @text    = opts[:text]   || ''

      @message = { error: { code: @status, message: @text } }
    end
  end

  class AuthorizationError < Error
    def initialize
      super(status: 401, text: 'Authorization failed')
    end
  end

  class CannotBuyLessonError < Error
    def initialize
      super(status: 404, text: '您已購買過此課程，且仍在有效期限內')
    end
  end
end
