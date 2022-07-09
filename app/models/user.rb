class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, 
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tasks
  paginates_per 10
end
