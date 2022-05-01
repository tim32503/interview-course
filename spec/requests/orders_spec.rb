# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Orders', type: :request) do
  let!(:user) { create(:student) }
  let!(:orders) { create_list(:order, 10, student: user) }

  describe 'GET /orders' do
    context '未登入者嘗試瀏覽訂購紀錄' do
      before(:each) do
        get '/api/v1/orders'
      end

      it '回傳狀態碼 401' do
        expect(response).to(have_http_status(401))
      end
    end

    context '自行嘗試使用亂數 token 驗證並嘗試瀏覽訂購紀錄' do
      before(:each) do
        token = 'wzFwtJJi5LIUm6rgEvQmgdqABAWdekLxJxmDnTxs'

        get '/api/v1/orders', params: { token: token }
      end

      it '回傳狀態碼 401' do
        expect(response).to(have_http_status(401))
      end
    end

    context '瀏覽訂購紀錄' do
      before(:each) do
        token = user.tokens.first.key

        get '/api/v1/orders', params: { token: token }

        @response = JSON.parse(response.body)
      end

      it '回傳狀態碼 200 及訂購紀錄' do
        expect(@response['orders'].size).to(eq(user.orders.size))
        expect(response).to(have_http_status(200))
      end
    end
  end
end
