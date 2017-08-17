class WallPostsController < ApplicationController

  def create
    wallpost = current_user.wall_posts.create(wall_post_params)
    if params[:wall_post][:mention_id].present?
      wallpost.save
      WallPostMailer.new_post(wallpost).deliver_now
      flash[:success] = "Posted!"
      redirect_back fallback_location: newsfeed_path
    elsif wallpost.save
      flash[:success] = "Posted!"
      redirect_back fallback_location: newsfeed_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to fallback_location: newsfeed_path
    end
  end

  def wall_post_params
    params.require(:wall_post).permit(:body, :mention_id, :image)
  end

  def index
    @user = current_user
    wallposts_combo = current_user.wall_posts.all + current_user.wall_mentions.all
    @wallposts = wallposts_combo.sort_by(&:created_at).reverse
    @wallpost = WallPost.new
    @comment = Comment.new
  end
end
