class WallPostsController < ApplicationController

  def create
    wallpost = current_user.wall_posts.create(wall_post_params)
    if wallpost.save
      flash[:success] = "Posted!"
      redirect_to profile_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to profile_path
    end
  end

  def wall_post_params
    params.require(:wall_post).permit(:body, :mention_id)
  end

end
