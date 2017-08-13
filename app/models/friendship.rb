class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.friended_by_count(user)
    list = []
    list << find_by(friend_id: user.id)
    if list == [nil]
      "0"
    else
      list.length
    end
  end
end