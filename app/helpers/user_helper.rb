# frozen_string_literal: true

# 使用者 Helper
module UserHelper
  ROLE_LIST =
    [
      { id: 1, code: 'user', name: '訪客' },
      { id: 2, code: 'admin', name: '管理員' }
    ].freeze

  def user_role_options
    ROLE_LIST.map { |role| ["我是#{role[:name]}", role[:code]] }
  end

  def user_role_name
    ROLE_LIST.find { |role| role[:code] == current_user.role }[:name]
  end
end
