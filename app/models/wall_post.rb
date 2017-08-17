class WallPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :mentioned, class_name: "User", optional: true
  validates :body, presence: true
  has_many :likes, as: :item
  has_many :comments

  def display_comments_count
    if comments.count == 0
      "No Comments Yet"
    elsif comments.count == 1
      "1 Comment"
    else
      "#{comments.count} Comments"
    end
  end
end