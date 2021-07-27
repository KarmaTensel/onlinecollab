class User < ApplicationRecord

  has_one_attached :avatar
  acts_as_voter

  enum role: [:user, :employee, :moderator, :admin]

  after_initialize do
    self.username ||= "user_#{rand(36**8).to_s(36)}" if self.new_record?
	end

  scope :same_company, -> { where(company: current_user.company) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :posts, dependent: :destroy
        has_many :comments, dependent: :destroy
        validates_associated :posts
        has_many :post_votes, dependent: :destroy
end
