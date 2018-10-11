class User < ApplicationRecord
  validates_presence_of :name, :email, :password

  has_secure_password

  enum status: ['non-active', 'active']

  def account_activation
    self.status = 'active'
  end
end
