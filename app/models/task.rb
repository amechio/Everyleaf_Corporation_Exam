class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :details, length: { maximum: 250 }
end
