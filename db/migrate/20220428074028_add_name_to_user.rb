# frozen_string_literal: true

# User 資料表 - 新增 name 欄位
class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column(:users, :name, :string)
  end
end
