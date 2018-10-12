require 'securerandom'

class User < ApplicationRecord
  validates_presence_of :name, :email, :password

  has_secure_password

  enum status: ['non-active', 'active']

  def activate_account
    self.update(status: 'active', activation_token: nil)
  end

  def generate_token
    self.activation_token = SecureRandom.uuid
    self.save!
  end
end
