class WallPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :mentioned, class_name: "User", optional: true
  validates :body, presence: true
  has_many :likes, as: :item
  has_many :comments
end