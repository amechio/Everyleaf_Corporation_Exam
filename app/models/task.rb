class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :details, presence: true, length: { maximum: 250 }
  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
end
