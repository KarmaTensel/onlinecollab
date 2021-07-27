class Post < ApplicationRecord
	include Status
	
	has_rich_text :content
	has_many :comments, dependent: :destroy
	has_many :answers, dependent: :destroy

	belongs_to :user

	acts_as_votable

	validates :title, :tags, :content, :status, :visibility, :user_id, presence: true

	scope :post_all, -> { where(visibility: 'All') }
	scope :post_admin, -> { where(visibility: 'Admin') }
	scope :post_cowoker, -> { where(visibility: 'Co-workers') }

	scope :post_employee, -> { where(visibility: 'Employee') }
	scope :post_company_employee, -> { post_employee.joins(:user).merge(User.same_company) }

	PUBLISH_WAITING, PUBLISHED = 'not_published', 'Publish'

  scope :publish_waiting, -> {where(status: Post::PUBLISH_WAITING) }
  scope :ready_for_publish, -> { where('publish_at <= ?', Time.now) }

	def publish_now!
    self.status = Post::PUBLISHED
    self.published_at = self.publish_at
    save!
  end

end