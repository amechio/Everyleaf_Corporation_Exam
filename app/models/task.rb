class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :details, presence: true, length: { maximum: 250 }
  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  scope :by_limit, -> { order(limit: :desc) }
  scope :by_created_at, -> { order(created_at: :desc) }
  scope :title_like, -> (:title) { where('title Like ?', "%#{:title}%") }
  scope :status_like, -> (status) { where(status: [status]) }
end
