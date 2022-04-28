# frozen_string_literal: true

# 課程
class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.accessible_by(current_ability)
  end
end
