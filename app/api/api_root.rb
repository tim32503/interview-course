# frozen_string_literal: true

# API 底層
class ApiRoot < Grape::API
  PREFIX = '/api'

  format :json

  mount V1::Base
end
