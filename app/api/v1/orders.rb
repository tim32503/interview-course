# frozen_string_literal: true

module V1
  class Orders < Grape::API
    before { authenticate! }

    desc '瀏覽所有購買課程'
    get '/orders' do
      user = User.includes(orders: [:lesson])

      if params[:is_available].present? && params[:is_available] == 'true'
        user = user.where(courses: { is_launched: true }).where('orders.expired_at >= ?', Time.zone.today)
      elsif params[:is_available].present? && params[:is_available] == 'false'
        user =
          user.where(courses: { is_launched: false })
              .or(User.includes(orders: [:lesson]).where('orders.expired_at < ?', Time.zone.today))
      end

      user = user.where(courses: { course_type: params[:type] }) if params[:type].present?
      user = user.find_by(id: current_user.id)

      V1::Entities::Student.represent(user)
    end
  end
end
