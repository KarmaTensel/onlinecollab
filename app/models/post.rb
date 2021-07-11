class Post < ApplicationRecord
	validates :title, :tags, :content, :user_id, presence: true
	belongs_to :user
	has_rich_text :content
	has_many :comments
end