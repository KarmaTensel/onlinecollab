class User < ApplicationRecord

  enum role: [:user, :employee, :moderator, :admin]

  after_initialize do
    self.role ||= :user if self.new_record?
    self.username ||= "user_#{rand(36**8).to_s(36)}" if self.new_record?
    self.company ||= "?" if self.new_record?
 
    # guaranteed maximum length: 8
    # It generates random strings of lowercase a-z and 0-9. It's not very customizable but it's short and clean.
	end

  scope :same_company, -> { where(company: current_user.company) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :posts, dependent: :destroy
        has_many :comments, dependent: :destroy
        validates_associated :posts
end
