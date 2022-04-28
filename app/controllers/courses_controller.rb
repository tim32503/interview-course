# frozen_string_literal: true

# 課程
class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course, only: %i[edit update destroy]

  load_and_authorize_resource

  def index
    @courses = Course.accessible_by(current_ability)
  end

  def new
    @course = current_user.courses.new
  end

  def create
    @course = current_user.courses.new(course_params)

    if @course.save
      redirect_to courses_path, notice: '課程建立成功！'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: '課程更新成功！'
    else
      render :edit
    end
  end

  def destroy
    @course&.destroy

    redirect_to courses_path, notice: '課程已刪除！'
  end

  private

  def find_course
    @course = current_user.courses.find_by(id: params[:id])
  end

  def course_params
    params.require(:course).permit(
      :title,
      :url,
      :course_type,
      :expiration_period,
      :currency,
      :price,
      :description,
      :is_launched
    )
  end
end
