# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Courses', type: :request) do
  let!(:user) { create(:student) }
  let!(:available_courses) { create_list(:available_course, 10) }
  let!(:unavailable_course) { create(:unavailable_course) }

  describe 'POST /courses/:id/buy' do
    context '未登入者嘗試購買課程' do
      before(:each) do
        post "/api/v1/courses/#{unavailable_course.id}/buy"
      end

      it '回傳狀態碼 401' do
        expect(response).to(have_http_status(401))
      end
    end

    context '自行嘗試使用亂數 token 驗證並嘗試購買課程' do
      before(:each) do
        token = 'wzFwtJJi5LIUm6rgEvQmgdqABAWdekLxJxmDnTxs'

        post "/api/v1/courses/#{unavailable_course.id}/buy", params: { token: token }
      end

      it '回傳狀態碼 401' do
        expect(response).to(have_http_status(401))
      end
    end

    context '購買上架中 且 尚未購買過的課程' do
      before(:each) do
        @course = available_courses.last
        token = user.tokens.first.key

        post "/api/v1/courses/#{@course.id}/buy", params: { token: token }

        @response = JSON.parse(response.body).slice('title', 'total', 'expired_at')
      end

      it '回傳狀態碼 201' do
        expect(response).to(have_http_status(201))
      end

      it '回傳訂單資料' do
        data = {
          title: @course.title,
          total: "#{@course.currency}$ #{@course.price.to_i}",
          expired_at: (Time.zone.today + @course.expiration_period.days)
        }
        result = JSON.parse(data.to_json)

        expect(@response).to(eq(result))
      end
    end

    context '購買已下架 且 尚未購買過的課程' do
      before(:each) do
        token = user.tokens.first.key

        post "/api/v1/courses/#{unavailable_course.id}/buy", params: { token: token }
      end

      it '回傳狀態碼 404' do
        expect(response).to(have_http_status(404))
      end
    end

    context '購買上架中 但 已購買過的課程' do
      before(:each) do
        token = user.tokens.first.key
        course = available_courses.last
        user.orders.create(course_id: course.id, expired_at: Time.zone.tomorrow)

        post "/api/v1/courses/#{course.id}/buy", params: { token: token }

        @response = JSON.parse(response.body)
      end

      it '回傳狀態碼 404' do
        expect(response).to(have_http_status(404))
      end

      it '回傳購買失敗錯誤訊息' do
        data = {
          error: {
            code: 404,
            message: '您已購買過此課程，且仍在有效期限內'
          }
        }
        result = JSON.parse(data.to_json)

        expect(@response).to(eq(result))
      end
    end
  end
end
