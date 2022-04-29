# frozen_string_literal: true

module V1
  class Courses < Grape::API
    before { authenticate! }

    desc '購買指定課程'
    post '/courses/:id/buy' do
      course = Course.is_available.find_by(id: params[:id])

      raise ActiveRecord::RecordNotFound if course.nil?

      today = Time.zone.today
      existed_order = current_user.orders.where('expired_at >= ?', today).where(course_id: course.id)

      raise CannotBuyLessonError if existed_order.present?

      order = current_user.orders.new(course_id: course.id, expired_at: today + course.expiration_period.days)

      raise StandardError unless order.save

      {
        lesson: V1::Entities::Order.represent(
          order,
          only: [:id, :expired_at, { course: %i[title currency price course_type teacher] }]
        )
      }
    end
  end
end
