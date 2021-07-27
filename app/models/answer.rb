class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_rich_text :content
  acts_as_votable
end
