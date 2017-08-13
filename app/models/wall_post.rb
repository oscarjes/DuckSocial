class WallPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :mentioned, class_name: "User", optional: true
  validates :body, presence: true
end