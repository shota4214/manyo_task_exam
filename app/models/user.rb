class User < ApplicationRecord
  before_destroy :not_destroy_last_admin
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, 
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  paginates_per 10

  private

  def not_destroy_last_admin
    if User.where(admin: 'true').count == 1 && self.admin?
      errors.add :base, '管理者は必ず１名必要です'
      throw :abort
    end
  end
end
