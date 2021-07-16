class Post < ApplicationRecord
	include Status
	has_rich_text :content
	has_many :comments, dependent: :destroy
	has_many :answers, dependent: :destroy

	belongs_to :user

	validates :title, :tags, :content, :status, :visibility, :user_id, presence: true
end
