# frozen_string_literal: true

# 訂單
class OrdersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @orders = current_user.orders.accessible_by(current_ability)
  end
end
