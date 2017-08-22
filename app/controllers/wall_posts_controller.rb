class WallPostsController < ApplicationController
  before_action :require_login

  def create
    wallpost = current_user.wall_posts.create(wall_post_params)
    if params[:wall_post][:mention_id].present?
      wallpost.save
      WallPostMailer.new_post(wallpost).deliver_now
      NotifySlack.new.notify_new_wall_post(wallpost)
      flash[:success] = "Posted!"
      redirect_back fallback_location: newsfeed_path
    elsif wallpost.save
      NotifySlack.new.notify_new_wall_post(wallpost)
      flash[:success] = "Posted!"
      redirect_back fallback_location: newsfeed_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to fallback_location: newsfeed_path
    end
  end

  def index
    @user = current_user
    #@wallposts = WallPost.all.sort_by(&:created_at).reverse
    @wallposts = WallPost.order("updated_at DESC").page(1).per(10)
    @wallpost = WallPost.new
    @comment = Comment.new
  end

  def paging
    params[:per] ||= 10
    @wallposts = WallPost.order("updated_at DESC").page(params[:page]).per(params[:per])

    render partial: 'wall_post', collection: @wallposts, layout: false
  end

  private

  def wall_post_params
    params.require(:wall_post).permit(:body, :mention_id, :image)
  end
  
end
