# frozen_string_literal: true

module V1
  class Base < Grape::API
    version 'v1', using: :path

    use V1::Auth::Middleware

    include V1::ExceptionHandlers

    helpers ::V1::Helpers

    mount Courses
    mount Orders
  end
end
