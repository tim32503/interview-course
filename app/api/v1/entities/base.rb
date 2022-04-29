# frozen_string_literal: true

module V1
  module Entities
    class Base < Grape::Entity
      format_with(:iso8601, &:iso8601)
    end
  end
end
