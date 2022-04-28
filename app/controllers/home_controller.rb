# frozen_string_literal: true

# 首頁
class HomeController < ApplicationController
  def index
    @courses = Course.is_available
  end
end
