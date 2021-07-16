class Post < ApplicationRecord
	include Status
	has_rich_text :content
	has_many :comments, dependent: :destroy
	has_many :answers, dependent: :destroy

	belongs_to :user

	validates :title, :tags, :content, :status, :visibility, :user_id, presence: true

	scope :post_all, -> { where(visibility: 'All') }
	scope :post_admin, -> { where(visibility: 'Admin') }
	scope :post_cowoker, -> { where(visibility: 'Co-workers') }

	scope :post_employee, -> { where(visibility: 'Employee') }
	scope :post_company_employee, -> { post_employee.joins(:user).merge(User.same_company) }

end