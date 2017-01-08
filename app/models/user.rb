class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates_uniqueness_of :email
  has_many :orders

  enum role: %w(default admin)
end