module WallPostsHelper

  def display_mentions(wall_post)
    if wall_post.mentions.count  == 1
      "With " + wall_post.mentions.first.user.fullname
    elsif wall_post.mentions.count  == 2
      "With " + wall_post.mentions.first.user.fullname + " and 1 other"
    else
      "With " + wall_post.mentions.first.user.fullname + " and #{wall_post.mentions.count-1} others"
    end
  end
end
