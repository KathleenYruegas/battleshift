require 'securerandom'

class User < ApplicationRecord
  validates_presence_of :name, :email

  validates_presence_of :password, :if => :password

  has_secure_password

  enum status: ['non-active', 'active']

  def account_activation
    self.status = 'active'
  end

  def generate_token
      self.activation_token = SecureRandom.uuid
  end
end
