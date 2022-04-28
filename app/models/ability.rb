# frozen_string_literal: true

# 使用者權限
class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    return unless user.role == 'admin'

    can :manage, Course, user: user
  end
end
