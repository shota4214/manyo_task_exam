class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: {waiting: 0, doing: 1, done: 2}
  enum priority: {high: 0, medium: 1, low: 2}
  scope :sort_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :sort_status, -> (status) { where(status: status) }
  scope :user_tasks, -> (current_user_id) { where(user_id: current_user_id).includes(:user) }
  paginates_per 10
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
