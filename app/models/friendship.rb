class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.friended_by_count(user)
    Friendship.where(friend: user).count
  end
end