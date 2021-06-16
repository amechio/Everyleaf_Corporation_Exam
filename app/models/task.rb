class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :details, presence: true, length: { maximum: 250 }
  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  enum priority: { 低: 1, 中: 2, 高: 3 }
  scope :by_limit, -> { order(limit: :desc) }
  scope :by_priority, -> { order(priority: :desc) }
  scope :by_created_at, -> { order(created_at: :desc) }
  scope :title_like, -> (title) { where('title Like ?', "%#{title}%") }
  scope :select_status, -> (status) { where(status: [status]) }
  scope :select_priority, -> (priority) { where(priority: [priority]) }
end
