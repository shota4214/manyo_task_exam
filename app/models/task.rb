class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: {waiting: 0, doing: 1, done: 2}
  enum priority: {low: 0, medium: 1, high: 2}
end
