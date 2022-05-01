# frozen_string_literal: true

# 課程 Helper
module CourseHelper
  CURRENCY_LIST = [
    { id: 1, code: 'TWD', name: '新台幣', symbol: '$' },
    { id: 2, code: 'HKD', name: '港元', symbol: '$' },
    { id: 3, code: 'USD', name: '美元', symbol: '$' },
    { id: 4, code: 'JPY', name: '日圓', symbol: '¥' }
  ].freeze

  COURSE_TYPE = [
    { id: 1, code: 'english', name: '英文' },
    { id: 2, code: 'math', name: '數學' },
    { id: 3, code: 'chinese', name: '國文' }
  ].freeze

  def currency_options
    CURRENCY_LIST.map { |currency| ["#{currency[:name]}（#{currency[:symbol]}）", currency[:code]] }
  end

  def course_type_options
    COURSE_TYPE.map { |type| [type[:name], type[:code]] }
  end

  def expiration_period_options
    (1..31).map { |day| ["#{day} 天", day] }
  end

  def url_for_course(course)
    course.url.present? ? "/courses/#{course.url}" : course_path(course)
  end
end
