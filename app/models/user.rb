class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  before_destroy :admin_destroy_confirm
  before_update :admin_edit_confirm
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  enum role: { normal: 0, admin: 1 }
  def admin_destroy_confirm
    if User.where(role: 1).count == 1 && self.role == 'admin'
      throw :abort
    end
  end
  def admin_edit_confirm
    if User.where(role: 1).count == 1 && self.role == 'normal'
      throw(:abort)
    end
  end
end
