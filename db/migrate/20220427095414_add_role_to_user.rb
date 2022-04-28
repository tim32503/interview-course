# frozen_string_literal: true

# User 資料表 - 新增 role 欄位
class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column(:users, :role, :string, default: 'user')
  end
end
