class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :details, presence: true, length: { maximum: 250 }
end
