class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: {waiting: 0, doing: 1, done: 2}
  enum priority: {high: 0, medium: 1, low: 2}
  scope :sort_title, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :sort_status, -> (status) { where(status: status) }
  paginates_per 10
  belongs_to :user
end
