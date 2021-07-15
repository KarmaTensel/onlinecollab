class User < ApplicationRecord

  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          has_many :posts, dependent: :destroy
          has_many :comments, dependent: :destroy
          validates_associated :posts 
end
