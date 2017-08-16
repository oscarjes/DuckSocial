class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wall_post
  validates :body, presence: true
end
