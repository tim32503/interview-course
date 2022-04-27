# frozen_string_literal: true

# 使用者 Helper
module UserHelper
  ROLE_LIST =
    [
      { id: 1, code: 'student', name: '學生' },
      { id: 2, code: 'teacher', name: '老師' },
      { id: 3, code: 'admin', name: '管理員' }
    ].freeze

  def user_role_options
    ROLE_LIST.reject { |role| role[:code] == 'admin' }.map { |role| ["我是#{role[:name]}", role[:code]] }
  end
end
