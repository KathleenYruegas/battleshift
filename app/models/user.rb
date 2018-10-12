require 'securerandom'

class User < ApplicationRecord
  before_create :generate_token, :generate_api_key
  validates_presence_of :name, :email
  validates_presence_of :password, :if => :password
  has_secure_password
  enum status: ['non-active', 'active']

  def activate_account
    self.update!(status: 'active', activation_token: nil)
  end

  def generate_token
    self.activation_token = SecureRandom.uuid
  end

  def generate_api_key
    self.api_key = SecureRandom.uuid
  end
end
