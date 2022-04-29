# frozen_string_literal: true

# API Token
class ApiAccessToken < ApplicationRecord
  belongs_to :user

  before_create :generate_keys

  private

  def generate_keys
    loop do
      self.key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')

      break unless ApiAccessToken.where(key: key).any?
    end
  end
end
